import csv
import math
import random
import numpy as np
import matplotlib.pyplot as plt

numberOfClusters = 4


def readCSV(fileName):
    result = {}
    points = []
    with open(fileName) as csv_file:
        spam_reader = csv.reader(csv_file)
        for row in spam_reader:
            if row[0] == 'label':
                continue
            points.append((float(row[1]), float(row[2])))
            result[(float(row[1]), float(row[2]))] = row[0]
    return result, points


def selectInitialCentroids(elements, k=numberOfClusters):
    result = []
    for i in range(k):
        result.append(random.choice(elements))
    return result


def euclideanDistance(pointA, pointB):
    return np.linalg.norm(np.array(pointA) - np.array(pointB))


def assignPointsToCentroid(points, centroids):
    assignedLabel = {}
    for centroid in centroids:
        assignedLabel[centroid] = []

    for point in points:
        minDistance = np.inf
        for centroid in centroids:
            if euclideanDistance(point, centroid) < minDistance:
                assignedLabel[centroid].append(point)
                minDistance = euclideanDistance(point, centroid)
    return assignedLabel


def computeMeanX(points):
    return np.mean([point[0] for point in points])


def computeMeanY(points):
    return np.mean([point[1] for point in points])


def recomputeCentroid(clusters, centroids):
    newCentroids = []

    for centroid in clusters.keys():
        currentCluster = clusters[centroid]
        newCentroid = (computeMeanX(currentCluster), computeMeanY(currentCluster))
        newCentroids.append(newCentroid)

    return newCentroids


def conditionToStopKMean(centroids, newCentroids):
    if centroids == newCentroids:
        return True
    return False


def solve():
    data, points = readCSV("dataset.csv")
    finalLabels = {}
    finalDunnIndex = -np.inf
    for i in range(10):
        random.seed(i * 25 + 956 / (i + 1))
        centroids = selectInitialCentroids(points)
        # initialPlot(points, centroids)
        assignedLabel = assignPointsToCentroid(points, centroids)
        newCentroids = recomputeCentroid(assignedLabel, centroids)
        while not conditionToStopKMean(centroids, newCentroids):
            centroids = newCentroids
            assignedLabel = assignPointsToCentroid(points, centroids)
            newCentroids = recomputeCentroid(assignedLabel, centroids)

        interClusterDistance = min(
            [euclideanDistance(centroids[a], centroids[b]) for a in range(len(centroids)) for b in
             range(a + 1, len(centroids))])
        intraClusterDistance = max([euclideanDistance(point, centroid) for centroid in assignedLabel.keys() for point in
                                    assignedLabel[centroid]])
        currentDunnIndex = interClusterDistance / intraClusterDistance
        print("The dunn index for iteration", i, "is", currentDunnIndex)
        if finalDunnIndex < currentDunnIndex:
            finalDunnIndex = currentDunnIndex
            finalLabels = assignedLabel
        finalPlot(assignedLabel)

    finalPlot(finalLabels)
    statistics(finalLabels, data, giveValueToEachCentroid(finalLabels))


def initialPlot(points, centroids):
    plt.scatter([point[0] for point in points], [point[1] for point in points], c='black')
    plt.scatter([centroid[0] for centroid in centroids], [centroid[1] for centroid in centroids], c='red')
    plt.xlabel('val1')
    plt.ylabel('val2')
    plt.show()


def giveValueToEachCentroid(assignedLabels):
    centroids = list(assignedLabels.keys())
    centroidA = min(centroids, key=lambda x: x[0])
    centroids.remove(centroidA)

    centroidC = max(centroids, key=lambda x: x[0])
    centroids.remove(centroidC)

    centroidD = min(centroids, key=lambda x: x[1])
    centroids.remove(centroidD)

    return {centroidA: 'A', centroids[0]: 'B', centroidC: 'C', centroidD: 'D'}


def finalPlot(assignedLabels):
    colours = ['red', 'green', 'blue', 'purple']
    index = 0
    for key in assignedLabels:
        plt.scatter(
            [point[0] for point in assignedLabels[key]],
            [point[1] for point in assignedLabels[key]],
            c=colours[index]
        )
        index += 1

    plt.scatter([centroid[0] for centroid in assignedLabels], [centroid[1] for centroid in assignedLabels], c='black')
    plt.show()


def statistics(assignedLabels, initialData, mappedCentroids):
    correctlyComputed = 0
    correctForLabel = {'A': 0, 'B': 0, 'C': 0, 'D': 0}
    totalForLabel = {'A': 0, 'B': 0, 'C': 0, 'D': 0}
    totalInitialLabel = {'A': 0, 'B': 0, 'C': 0, 'D': 0}
    for key, value in assignedLabels.items():
        for val in value:
            if initialData[val] == mappedCentroids[key]:
                correctlyComputed += 1
                correctForLabel[initialData[val]] += 1
            totalForLabel[mappedCentroids[key]] += 1
            totalInitialLabel[initialData[val]] += 1

    accuracyIndex = correctlyComputed / len(initialData)
    print("Accuracy index:", accuracyIndex)

    precision = {}
    rappel = {}
    score = {}
    for key in ['A', 'B', 'C', 'D']:
        precision[key] = correctForLabel[key] / totalForLabel[key]
        rappel[key] = correctForLabel[key] / totalInitialLabel[key]
        score[key] = 2 * precision[key] * rappel[key] / (precision[key] + rappel[key] + 1)

    print("Precision:", precision)
    print("Rappel:", rappel)
    print("Score:", score)


solve()
