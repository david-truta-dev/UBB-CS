import torch

import myModel
import math
filePath = "myNet.pt"
ann = myModel.Net(2, 100, 1)

ann.load_state_dict(torch.load(filePath))
ann.eval()

while True:
    x = float(input("x = "))
    y = float(input("y = "))
    print(ann(torch.tensor((x, y))).tolist())
    print(math.sin(x + y / math.pi))
