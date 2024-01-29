from torch import nn


class DeepCORAL(nn.Module):
    def __init__(self, num_classes=10):
        super(DeepCORAL, self).__init__()
        self.sharedNet1 = nn.Sequential(
            nn.Conv2d(4, 16, kernel_size=(3, 3), stride=(1, 1), padding=1),
            nn.ReLU(inplace=True),
            nn.MaxPool2d(kernel_size=2, stride=2),
            nn.Conv2d(16, 32, kernel_size=(3, 3), stride=(1, 1), padding=0),
            nn.ReLU(inplace=True),
            nn.MaxPool2d(kernel_size=2, stride=2)
        )
        self.sharedNet2 = nn.Sequential(
            nn.Dropout(),
            nn.Linear(32 * 3 * 3, 256),
            nn.ReLU(inplace=True),
            nn.Dropout(),
            nn.Linear(256, 128),
            nn.ReLU(inplace=True),
            nn.Linear(128, 128),
            nn.ReLU(inplace=True),
        )
        self.fc = nn.Linear(128, num_classes)
        # self.fc.weight.data.normal_(0, 0.005)

    def forward(self, source, target):
        source = self.sharedNet1(source)
        source = source.view(source.size(0), -1)
        source = self.sharedNet2(source)
        source = self.fc(source)

        target = self.sharedNet1(target)
        target = target.view(target.size(0), -1)
        target = self.sharedNet2(target)
        target = self.fc(target)
        return source, target




