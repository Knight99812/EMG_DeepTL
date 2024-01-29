from torch import nn


class DAN(nn.Module):
    def __init__(self, num_classes=10):
        super(DAN, self).__init__()
        self.CovNet = nn.Sequential(
            nn.Conv2d(4, 16, kernel_size=(3, 3), stride=(1, 1), padding=1),
            nn.ReLU(inplace=True),
            nn.MaxPool2d(kernel_size=2, stride=2),
            nn.Conv2d(16, 32, kernel_size=(3, 3), stride=(1, 1), padding=0),
            nn.ReLU(inplace=True),
            nn.MaxPool2d(kernel_size=2, stride=2)
        )
        self.fc1 = nn.Sequential(
            nn.Dropout(),
            nn.Linear(32 * 3 * 3, 256),
            nn.ReLU(inplace=True)
        )
        self.fc2 = nn.Sequential(
            nn.Dropout(),
            nn.Linear(256, 128),
            nn.ReLU(inplace=True)
        )
        self.fc3 = nn.Sequential(
            nn.Linear(128, 128),
            nn.ReLU(inplace=True)
        )
        self.clf = nn.Linear(128, num_classes)
        self.clf.weight.data.normal_(0, 0.005)

    def forward(self, source, target):
        source = self.CovNet(source)
        source = source.view(source.size(0), -1)
        source_fc1 = self.fc1(source)
        source_fc2 = self.fc2(source_fc1)
        source_fc3 = self.fc3(source_fc2)
        source_out = self.clf(source_fc3)

        target = self.CovNet(target)
        target = target.view(target.size(0), -1)
        target_fc1 = self.fc1(target)
        target_fc2 = self.fc2(target_fc1)
        target_fc3 = self.fc3(target_fc2)
        target_out = self.clf(target_fc3)
        return source_fc1, source_fc2, source_fc3, source_out, target_fc1, target_fc2, target_fc3, target_out

