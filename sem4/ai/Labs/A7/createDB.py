import math

import torch
from constants import *
"""
    If U uniformly distributed on [0, 1] => (-10 - 10) * U + 10 uniformly distributed on [-10, 10]
"""


def function(x, y):
    return math.sin(x + y / math.pi)


def getRandomValues():
    return [-20 * x + 10 for x in torch.rand(SAMPLE_SIZE)]


def getRandomPoints():
    return getRandomValues(), getRandomValues()


def computeDb():
    filePath = "mydataset.dat"
    result = []
    allX, allY = getRandomPoints()
    for i in range(SAMPLE_SIZE):
        result.append((allX[i], allY[i], function(allX[i], allY[i])))
    torchData = torch.tensor([point for point in result])
    torch.save(torchData, filePath)
    # self._data_set = torch.tensor([point for point in points])


computeDb()
