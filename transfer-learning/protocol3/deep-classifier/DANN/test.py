import os
import random
import numpy as np
import scipy.io as scio
import torch.utils.data as Data

from sklearn.metrics import accuracy_score
from function import *
from model import *

data_path = '..\\..\\..\\..\\hybrid-dataset\\V1\\'
idx = [1, 2, 3, 4, 5, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 33]
dict = {}
for key in idx:
    dict[key] = 0
nottouse = [5, 11, 19]
avgacc = 0
acc = []

for i in range(1, 21):
    if i in nottouse:
        continue
    feature_train = []
    label_train = []
    for j in range(1, 21):
        if j == i or j in nottouse:
            continue
        for k in range(1, 3):
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

    for m in range(1, 3):  # validation set
        test_file = 'feature\\' + str(i) + '_' + str(m) + '.mat'
        test_data = scio.loadmat(os.path.join(data_path, test_file))
        label_file = 'label\\' + str(i) + '_' + str(m) + '.mat'
        test_label = scio.loadmat(os.path.join(data_path, label_file))
        feature_test = test_data['feature']
        label_test = test_label['label'].squeeze()

        target_file = 'transfer-data\\feature\\' + str(i) + '_' + str(m) + '.mat'
        target_data = scio.loadmat(os.path.join(data_path, target_file))
        label_file = 'transfer-data\\label\\' + str(i) + '_' + str(m) + '.mat'
        target_label = scio.loadmat(os.path.join(data_path, label_file))
        feature_target = target_data['feature_realign_smooth']
        label_target = target_label['label'].squeeze()

        idx = list(range(0, len(label_target)))
        random.shuffle(idx)
        target_xt = feature_target[idx[0:20], :, :, :]
        target_yt = label_target[idx[0:20]]

        for key in target_yt:
            dict[key] = dict.get(key, 0) + 1

        target_xt = torch.from_numpy(target_xt.astype(np.float32))
        target_yt = torch.from_numpy(target_yt.astype(np.int64))
        test_xt = torch.from_numpy(feature_test.astype(np.float32))
        test_yt = torch.from_numpy(label_test.astype(np.int64))
        test_xt, _, _ = standardization(test_xt)
        target_xt, _, _ = standardization(target_xt)

        target_data = Data.TensorDataset(target_xt, target_yt)
        target_loader = Data.DataLoader(dataset=target_data, batch_size=20, shuffle=True, drop_last=True)

        model = DaNN(n_input=4 * 16 * 16, n_hidden=256, n_class=10)
        optimizer = torch.optim.SGD(
            model.parameters(),
            lr=LEARNING_RATE,
            momentum=MOMEMTUN,
            weight_decay=L2_WEIGHT
        )

        for e in tqdm(range(1, N_EPOCH + 1)):
            model = train(model=model, optimizer=optimizer,
                          epoch=e, data_src=train_loader, data_tar=target_loader)

        test_xt = test_xt.reshape(-1, 4 * 16 * 16)
        model.eval()
        ypred, _, _ = model(test_xt, test_xt)
        pred = ypred.data.max(1)[1]
        acc_temp = accuracy_score(test_yt, pred)
        acc.append(acc_temp)
        avgacc += acc_temp / 34
        print(len(acc))
        print('\n')


print(avgacc)

