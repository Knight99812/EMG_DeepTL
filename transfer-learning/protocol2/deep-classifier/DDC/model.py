import mmd
from torch import nn


class DDCNet(nn.Module):
    def __init__(self, num_classes=10):
        super(DDCNet, self).__init__()
        self.features = nn.Sequential(
            nn.Conv2d(4, 16, kernel_size=(3, 3), stride=(1, 1), padding=1),
            nn.ReLU(inplace=True),
            nn.MaxPool2d(kernel_size=2, stride=2),
            nn.Conv2d(16, 32, kernel_size=(3, 3), stride=(1, 1), padding=0),
            nn.ReLU(inplace=True),
            nn.MaxPool2d(kernel_size=2, stride=2),
        )
        self.classifier = nn.Sequential(
            nn.Dropout(),
            nn.Linear(32 * 3 * 3, 256),
            nn.ReLU(inplace=True),
            nn.Dropout(),
            nn.Linear(256, 128),
            nn.ReLU(inplace=True)
        )
        self.bottleneck = nn.Sequential(
            nn.Linear(128, 128),
            nn.ReLU(inplace=True)
        )
        self.final_classifier = nn.Sequential(
            nn.Linear(128, num_classes)
        )

    def forward(self, source, target):
        source = self.features(source)
        source = source.view(source.size(0), -1)
        source = self.classifier(source)
        source = self.bottleneck(source)

        mmd_loss = 0
        if self.training:
            target = self.features(target)
            target = target.view(target.size(0), -1)
            target = self.classifier(target)
            target = self.bottleneck(target)
            # mmd_loss += mmd.mmd_linear(source, target)
            mmd_loss += mmd.mix_rbf_mmd2(source, target, [10 ^ 3])

        result = self.final_classifier(source)

        return result, mmd_loss
