import os
import random
import numpy as np
import scipy.io as scio
import torch.utils.data as Data

from model import *
from function import *
from sklearn.metrics import accuracy_score
from MK_MMD import MultipleKernelMaximumMeanDiscrepancy


path = '..\\..\\..\\..\\hybrid-dataset\\'
nottouse = [5, 11, 19, 32, 38, 39]
num2transfer = 2  # target numbers for each gesture
avgacc = 0
acc = []

for i in range(1, 42):
    if i in nottouse:
        continue
    feature_train = []
    label_train = []
    for j in range(1, 42):
        if j == i or j in nottouse:
            continue
        for k in range(1, 3):
            if j <= 20:
                data_path = path + 'V1\\'
            else:
                data_path = path + 'V2-V3\\'
            train_file = 'feature\\' + str(j) + '_' + str(k) + '.mat'
            train_data = scio.loadmat(os.path.join(data_path, train_file))
            feature_temp = train_data['feature']
            label_file = 'label\\' + str(j) + '_' + str(k) + '.mat'
            train_label = scio.loadmat(os.path.join(data_path, label_file))
            label_temp = train_label['label'].squeeze()
            if len(feature_train) == 0:
                feature_train = feature_temp
                label_train = label_temp
            else:
                feature_train = np.concatenate((feature_train, feature_temp), axis=0)
                label_train = np.concatenate((label_train, label_temp), axis=0)

    train_xt = torch.from_numpy(feature_train.astype(np.float32))
    train_xt, _, _ = standardization(train_xt)
    train_yt = torch.from_numpy(label_train.astype(np.int64))

    train_data = Data.TensorDataset(train_xt, train_yt)
    train_loader = Data.DataLoader(dataset=train_data, batch_size=20, shuffle=True, drop_last=True)

    loss_func1 = MultipleKernelMaximumMeanDiscrepancy(kernels1)
    loss_func2 = MultipleKernelMaximumMeanDiscrepancy(kernels2)

    for m in range(1, 3):
        if i <= 20:
            data_path = path + 'V1\\'
        else:
            data_path = path + 'V2-V3\\'
        test_file = 'feature\\' + str(i) + '_' + str(m) + '.mat'
        test_data = scio.loadmat(os.path.join(data_path, test_file))
        label_file = 'label\\' + str(i) + '_' + str(m) + '.mat'
        test_label = scio.loadmat(os.path.join(data_path, label_file))
        feature_test = test_data['feature']
        label_test = test_label['label'].squeeze()

        # divide validation set into test and target
        idx_target = []
        idx_test = []
        for n in range(0, 10):
            idx = list(np.nonzero(label_test == n)[0])
            random.shuffle(idx)
            if len(idx) > num2transfer:
                idx_target.extend(idx[:num2transfer])
                idx_test.extend(idx[num2transfer:])
            else:
                idx_target_temp = idx[:-1]
                idx_test.append(idx[-1])
                num2copy = num2transfer - len(idx_target_temp)
                for nn in range(0, num2copy):
                    idx_target_temp.extend(random.sample(idx_target_temp, 1))
                idx_target.extend(idx_target_temp)

        target_xt = feature_test[idx_target, :, :, :]
        target_yt = label_test[idx_target]
        test_xt = feature_test[idx_test, :, :, :]
        test_yt = label_test[idx_test]

        target_xt = torch.from_numpy(target_xt.astype(np.float32))
        target_yt = torch.from_numpy(target_yt.astype(np.int64))
        test_xt = torch.from_numpy(test_xt.astype(np.float32))
        test_yt = torch.from_numpy(test_yt.astype(np.int64))

        target_xt, mu, sigma = standardization(target_xt)
        x = torch.ones_like(test_xt)
        y = torch.ones_like(test_xt)
        for jj in range(4):
            x[:, jj, :, :] = mu[jj]
            y[:, jj, :, :] = sigma[jj]
        test_xt = (test_xt - x) / y

        target_data = Data.TensorDataset(target_xt, target_yt)
        target_loader = Data.DataLoader(dataset=target_data, batch_size=20, shuffle=True)

        model = BJMMD(num_classes=10)

        for epoch in range(1, TRAIN_EPOCHS + 1):
            model.train()
            loss1, loss2, clf_loss = train(model, loss_func1, loss_func2, epoch, learning_rate, train_loader, target_loader)

        model.eval()
        _, _, _, _, _, ypred = model(test_xt, test_xt)
        pred = ypred.data.max(1)[1]
        acc_temp = accuracy_score(test_yt, pred)
        acc.append(acc_temp)
        avgacc += acc_temp / 70
        print(len(acc))
        print('\n')



