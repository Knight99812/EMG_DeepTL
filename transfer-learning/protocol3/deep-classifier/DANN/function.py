import mmd
import torch
from tqdm import tqdm
import torch.nn as nn

N_EPOCH = 60
LAMBDA = 0.25
GAMMA = 10 ^ 3
LEARNING_RATE = 0.02
MOMEMTUN = 0.05
L2_WEIGHT = 0.003
# RESULT_TRAIN = []
# RESULT_TEST = []
# log_train = open('log_train_a-w.txt', 'w')
# log_test = open('log_test_a-w.txt', 'w')


def mmd_loss(x_src, x_tar):
    return mmd.mix_rbf_mmd2(x_src, x_tar, [GAMMA])


def standardization(data):
    mu = torch.mean(data, dim=(0, 2, 3))
    sigma = torch.std(data, dim=(0, 2, 3))
    x = torch.ones_like(data)
    y = torch.ones_like(data)
    for i in range(4):
        x[:, i, :, :] = mu[i]
        y[:, i, :, :] = sigma[i]
    return (data - x) / y, mu, sigma


def train(model, optimizer, epoch, data_src, data_tar):
    total_loss_train = 0
    criterion = nn.CrossEntropyLoss()
    correct = 0
    batch_j = 0
    list_src, list_tar = list(enumerate(data_src)), list(enumerate(data_tar))
    for batch_id, (data, target) in enumerate(data_src):
        _, (x_tar, y_target) = list_tar[batch_j]
        data, target = data.data.view(-1, 4*16*16), target
        x_tar, y_target = x_tar.view(-1, 4*16*16), y_target
        model.train()
        y_src, x_src_mmd, x_tar_mmd = model(data, x_tar)

        loss_c = criterion(y_src, target)
        loss_mmd = mmd_loss(x_src_mmd, x_tar_mmd)
        pred = y_src.data.max(1)[1]  # get the index of the max log-probability
        correct += pred.eq(target.data.view_as(pred)).sum()
        loss = loss_c + LAMBDA * loss_mmd
        optimizer.zero_grad()
        loss.backward()
        optimizer.step()
        total_loss_train += loss.data
        res_i = 'Epoch: [{}/{}], Batch: [{}/{}], loss: {:.6f}'.format(
            epoch, N_EPOCH, batch_id + 1, len(data_src), loss.data
        )
        batch_j += 1
        if batch_j >= len(list_tar):
            batch_j = 0
    total_loss_train /= len(data_src)
    acc = correct * 100. / (len(data_src)*20)
    res_e = 'Epoch: [{}/{}], training loss: {:.6f}, correct: [{}/{}], training accuracy: {:.4f}%'.format(
        epoch, N_EPOCH, total_loss_train, correct, (len(data_src)*20), acc
    )
    tqdm.write(res_e)
    # log_train.write(res_e + '\n')
    # RESULT_TRAIN.append([epoch, total_loss_train, acc])
    return model


def test(model, data_tar, e):
    total_loss_test = 0
    correct = 0
    criterion = nn.CrossEntropyLoss()
    with torch.no_grad():
        for batch_id, (data, target) in enumerate(data_tar):
            data, target = data.view(-1, 4*16*16), target
            model.eval()
            ypred, _, _ = model(data, data)
            loss = criterion(ypred, target)
            pred = ypred.data.max(1)[1]  # get the index of the max log-probability
            correct += pred.eq(target.data.view_as(pred)).sum()
            total_loss_test += loss.data
        accuracy = correct * 100. / (len(data_tar)*20)
        res = 'Test: total loss: {:.6f}, correct: [{}/{}], testing accuracy: {:.4f}%'.format(
            total_loss_test, correct, (len(data_tar)*20), accuracy
        )
    tqdm.write(res)
    # RESULT_TEST.append([e, total_loss_test, accuracy])
    # log_test.write(res + '\n')



