import torch
import math
import torch.nn as nn
from torch.autograd import Variable
from MK_MMD import GaussianKernel


BATCH_SIZE = 20
TRAIN_EPOCHS = 60
learning_rate = 1e-2
WEIGHT_DECAY = 5e-4
MOMENTUM = 0.9
layer1_kernels = (GaussianKernel(alpha=0.5), GaussianKernel(1.), GaussianKernel(2.))
layer2_kernels = (GaussianKernel(1.), )


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


def train(model, loss_func, epoch, learning_rate, source_loader, target_loader):
    log_interval = 10
    LEARNING_RATE = step_decay(epoch, learning_rate)
    print(f'Learning Rate: {LEARNING_RATE}')

    optimizer = torch.optim.SGD([
        {'params': model.CovNet.parameters()},
        {'params': model.fc1.parameters()},
        {'params': model.fc2.parameters()},
        {'params': model.clf.parameters(), 'lr': 10 * LEARNING_RATE},
    ], lr=LEARNING_RATE, momentum=MOMENTUM)

    iter_source = iter(source_loader)
    iter_target = iter(target_loader)
    num_iter = len(source_loader)

    correct = 0
    total_loss = 0
    clf_criterion = nn.CrossEntropyLoss()
    cuda = 0

    for i in range(1, num_iter):
        source_data, source_label = iter_source.next()
        target_data, _ = iter_target.next()
        if i % len(target_loader) == 0:
            iter_target = iter(target_loader)
        if cuda:
            source_data, source_label = source_data.cuda(), source_label.cuda()
            target_data = target_data.cuda()

        source_data, source_label = Variable(source_data), Variable(source_label)
        target_data = Variable(target_data)

        optimizer.zero_grad()

        a, out1, b, out2 = model(source_data, target_data)
        clf_loss = clf_criterion(out1, source_label)
        jmmd_loss = loss_func((a, out1), (b, out2))

        if jmmd_loss < 0:
            jmmd_loss = torch.zeros(1)

        sum_loss = clf_loss + jmmd_loss
        preds = out1.data.max(1, keepdim=True)[1]
        correct += preds.eq(source_label.data.view_as(preds)).sum()
        total_loss += clf_loss

        sum_loss.backward()
        # clf_loss.backward()
        torch.nn.utils.clip_grad_norm(model.parameters(), 2)
        optimizer.step()

        if i % log_interval == 0:
            print('Train Epoch {}: [{}/{} ({:.0f}%)]\tLoss: {:.6f}\tclf_Loss: {:.6f}\tjmmd_Loss: {:.6f}'.format(
                epoch, i * len(source_data), len(source_loader) * BATCH_SIZE,
                       100. * i / len(source_loader), sum_loss.data.item(), clf_loss.data.item(), jmmd_loss.data.item()))

    total_loss /= len(source_loader)
    acc_train = float(correct) * 100. / (len(source_loader) * BATCH_SIZE)

    print('Average classification loss: {:.4f}, Accuracy: {}/{} ({:.2f}%)'.format(
        total_loss.data.item(), correct.item(), len(source_loader) * BATCH_SIZE, acc_train))

