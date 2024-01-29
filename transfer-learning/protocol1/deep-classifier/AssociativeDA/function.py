import torch
import math
from torch.autograd import Variable
from torch import nn
import torch.nn.functional as F

BATCH_SIZE = 20
TRAIN_EPOCHS = 60
learning_rate = 1e-2
WEIGHT_DECAY = 5e-4
MOMENTUM = 0.9


def standardization(data):
    mu = torch.mean(data, dim=(0, 2, 3))
    sigma = torch.std(data, dim=(0, 2, 3))
    x = torch.ones_like(data)
    y = torch.ones_like(data)
    for i in range(4):
        x[:, i, :, :] = mu[i]
        y[:, i, :, :] = sigma[i]
    return (data - x) / y, mu, sigma


def step_decay(epoch, learning_rate):
    """
    learning rate step decay
    :param epoch: current training epoch
    :param learning_rate: initial learning rate
    :return: learning rate after step decay
    """
    initial_lrate = learning_rate
    drop = 0.8
    epochs_drop = 10.0
    lrate = initial_lrate * math.pow(drop, math.floor((1 + epoch) / epochs_drop))
    return lrate


class WalkerLoss(nn.Module):

    def forward(self, Psts, y):
        equality_matrix = torch.eq(y.clone().view(-1, 1), y).float()
        p_target = equality_matrix / equality_matrix.sum(dim=1, keepdim=True)
        p_target.requires_grad = False

        L_walker = F.kl_div(torch.log(1e-8 + Psts), p_target, size_average=False)
        L_walker /= p_target.size()[0]

        return L_walker


class VisitLoss(nn.Module):

    def forward(self, Pt):
        p_visit = torch.ones([1, Pt.size()[1]]) / float(Pt.size()[1])
        p_visit.requires_grad = False
        if Pt.is_cuda:
            p_visit = p_visit.cuda()
        L_visit = F.kl_div(torch.log(1e-8 + Pt), p_visit, size_average=False)
        L_visit /= p_visit.size()[0]

        return L_visit


class AssociationMatrix(nn.Module):

    def __init__(self):
        super(AssociationMatrix, self).__init__()

    def forward(self, xs, xt):
        """
        xs: (Ns, K, ...)
        xt: (Nt, K, ...)
        """

        # TODO not sure why clone is needed here
        Bs = xs.size()[0]
        Bt = xt.size()[0]

        xs = xs.clone().view(Bs, -1)
        xt = xt.clone().view(Bt, -1)

        W = torch.mm(xs, xt.transpose(1, 0))

        # p(xt | xs) as softmax, normalize over xt axis
        Pst = F.softmax(W, dim=1)  # Ns x Nt
        # p(xs | xt) as softmax, normalize over xs axis
        Pts = F.softmax(W.transpose(1, 0), dim=1)  # Nt x Ns

        # p(xs | xs)
        Psts = Pst.mm(Pts)  # Ns x Ns

        # p(xt)
        Pt = torch.mean(Pst, dim=0, keepdim=True)  # Nt

        return Psts, Pt


class AssociativeLoss(nn.Module):

    def __init__(self, walker_weight=1., visit_weight=1.):
        super(AssociativeLoss, self).__init__()

        self.matrix = AssociationMatrix()
        self.walker = WalkerLoss()
        self.visit = VisitLoss()

        self.walker_weight = walker_weight
        self.visit_weight = visit_weight

    def forward(self, xs, xt, y):
        Psts, Pt = self.matrix(xs, xt)
        L_walker = self.walker(Psts, y)
        L_visit = self.visit(Pt)

        return self.visit_weight * L_visit + self.walker_weight * L_walker


def fit(model, epoch, learning_rate, visit_weight, walker_weight, train_loader, target_loader):
    log_interval = 10
    LEARNING_RATE = step_decay(epoch, learning_rate)
    print(f'Learning Rate: {LEARNING_RATE}')

    optimizer = torch.optim.SGD([
        {'params': model.sharedNet1.parameters()},
        {'params': model.sharedNet2.parameters()},
        {'params': model.fc.parameters(), 'lr': 10 * LEARNING_RATE},
    ], lr=LEARNING_RATE, momentum=MOMENTUM)

    iter_source = iter(train_loader)
    iter_target = iter(target_loader)
    num_iter = len(train_loader)

    correct = 0
    total_loss = 0
    CL_loss = nn.CrossEntropyLoss()
    DA_loss = AssociativeLoss(walker_weight=walker_weight, visit_weight=visit_weight)

    for i in range(1, num_iter):
        source_data, source_label = iter_source.next()
        target_data, _ = iter_target.next()
        if i % len(target_loader) == 0:
            iter_target = iter(target_loader)

        source_data, source_label = Variable(source_data), Variable(source_label)
        target_data = Variable(target_data)

        optimizer.zero_grad()

        phi_s, yp = model(source_data)
        phi_t, ypt = model(target_data)
        yp = yp.squeeze().clone()
        ypt = ypt.squeeze().clone()
        clf_loss = CL_loss(yp, source_label)
        Aso_loss = DA_loss(phi_s, phi_t, source_label).mean()

        sum_loss = clf_loss + Aso_loss
        preds = yp.data.max(1, keepdim=True)[1]
        correct += preds.eq(source_label.data.view_as(preds)).sum()
        total_loss += clf_loss

        sum_loss.backward()
        # clf_loss.backward()

        torch.nn.utils.clip_grad_norm(model.parameters(), 2)

        optimizer.step()

        if i % log_interval == 0:
            print('Train Epoch {}: [{}/{} ({:.0f}%)]\tLoss: {:.6f}\tclf_Loss: {:.6f}\tAso_Loss: {:.6f}'.format(
                epoch, i * len(source_data), len(train_loader) * BATCH_SIZE,
                       100. * i / len(train_loader), sum_loss.data.item(), clf_loss.data.item(),
                Aso_loss.data.item()))

    total_loss /= len(train_loader)
    acc_train = float(correct) * 100. / (len(train_loader) * BATCH_SIZE)

    print('Average classification loss: {:.4f}, Accuracy: {}/{} ({:.2f}%)'.format(
        total_loss.data.item(), correct.item(), len(train_loader) * BATCH_SIZE, acc_train))

