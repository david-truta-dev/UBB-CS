import time

from repository import *


class Controller:
    def __init__(self, repo):
        self.repository = repo
        self._numberOfSeeds = None
        self._stepsNb = None
        self._populationSize = None
        self._numberOfIterations = None
        self._mutationProbability = None
        self._crossoverProbability = None
        self._statistics = []  # [[average_fitness_1, random_seed_1],...[average_fitness_numberOfIterations_, random_seed__numberOfIterations]]
        self._iteration = 0
        self._last_stats = []

    def setSeedNb(self, nb):
        self._numberOfSeeds = nb

    def setDronePosition(self, x, y):
        self.repository.setDronePositions(x, y)

    def setSteps(self, steps):
        self._stepsNb = steps

    def setNumberOfIterations(self, iterations):
        self._numberOfIterations = iterations

    def setMutationProbability(self, probability):
        self._mutationProbability = probability

    def setPopulationSize(self, size):
        self._populationSize = size

    def setCrossoverProbability(self, probability):
        self._crossoverProbability = probability

    def iteration(self):
        self._iteration += 1

        population = self.repository.currentPopulation()
        self.repository.evaluatePopulation(population)

        select = population.selection(population.size())

        parents = select[:len(select) // 2]
        pairs = len(parents) // 2
        used_pairs = []
        nb_of_pairs = 0

        for i in range(pairs):
            first = parents[randint(0, len(parents) - 1)]
            second = parents[randint(0, len(parents) - 1)]
            if [first, second] not in used_pairs:
                nb_of_pairs += 2
                used_pairs.append([first, second])
                firstCrossed, secondCrossed = first.crossover(second, self._crossoverProbability)
                first.mutate(self._mutationProbability)
                secondCrossed.mutate(self._mutationProbability)
                self.repository.addIndividual(population, firstCrossed)
                self.repository.addIndividual(population, secondCrossed)
        select = population.selection(population.size() - nb_of_pairs)
        population.setIndividuals(select)

    def run(self, args=0):
        # args - list of parameters needed in order to run the algorithm
        # until stop condition
        #    perform an iteration
        #    save the information need it for the statistics
        # return the results and the info for statistics

        self._last_stats = []
        for i in range(0, self._numberOfIterations):
            self.iteration()
            if args == self._numberOfSeeds - 1:
                self._last_stats.append(self.repository.computeAverageFitnessAndDeviation())

        self._statistics.append(self.repository.computeBestFitnessLatestPopulation())

    def solver(self):
        start_time = time.time()
        # args - list of parameters needed in order to run the solver
        # create the population,
        # run the algorithm
        # return the results and the statistics
        for i in range(self._numberOfSeeds):
            seed(100 - i)
            population = self.repository.createPopulation(self._populationSize, self._stepsNb)
            self.repository.addPopulation(population)
            self.run(i)

        print("--- %.2f seconds ---" % (time.time() - start_time))
        return self.repository.getFirstPath(), self._statistics, self._last_stats
