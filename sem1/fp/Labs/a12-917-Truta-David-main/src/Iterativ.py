def prime(n):
    """
    Returns whether a number is prime or not.
    :param n: int
    :return: True if n is prime, False otherwise
    """
    if n < 2:
        return False
    if n > 2 and n % 2 == 0:
        return False
    i = 3
    while i * i <= n:
        if n % i == 0:
            return False
        i += 2
    return True


def list_primes(n):
    """
    Computes all prime numbers smaller than n
    :param n: int
    :return: list of int
    """
    res = []
    for i in range(2, n):
        if prime(i):
            res.append(i)
    return res


def output_solution(x, primes):
    """
    Prints the values from primes, with the indices from x, in the following format: = x[1]+x[2]+x[3]...
    :param x: primes of int (indices of a solution)
    :param primes: list of int (prime numbers smaller than the given number n)
    :return: -
    """
    sir = "= "
    for i in range(0, len(x) - 1):
        sir = sir + str(primes[x[i]]) + "+"
    sir += str(primes[x[-1]])
    print(sir)


def is_solution(x, primes, n):
    """
    Returns whether x contains the indices of a solution or not.
    :param x: list of int (indices of a solution)
    :param primes: list of int (prime numbers smaller than the given number n)
    :param n: int (the given number to be discomposed)
    :return: True if it's a solution, False otherwise.
    """
    s = 0
    for i in range(0, len(x)):
        s += primes[x[i]]
    return s == n


def consistent(x, primes, n):
    """
    Computes whether a path can lead to a solution by checking if the elements x is in ascending order( to check if it's unique,
    so we don't find the same solution again.) and by checking that the sum of the current path (x) is smaller or
    equal than the given number.
    :param x: list of int (path to a solution OR a solution)
    :param primes: list of int (prime numbers smaller than the given number n)
    :param n: int (the given number to be discomposed)
    :return: True if current path can lead to a solution OR if it's a solution, False otherwise
    """
    s = 0
    for i in range(0, len(x) - 1):
        if x[i] > x[i + 1]:
            return False
    for i in range(0, len(x)):
        s += primes[x[i]]
    return s <= n


def back_iter(primes, n, solutions):
    """
    Computes and prints all forms of a number as a sum of prime numbers in an iterative way.
    :param primes: list of int (list of primes smaller than n)
    :param n: int (the given number)
    :param solutions: list of int (valid solutions already found, actually, the indices of a solution)
    :return:
    """
    x = [-1]
    while len(x) > 0:
        chosen = False
        while not chosen and x[-1] < len(primes) - 1:
            x[-1] = x[-1] + 1
            # ^ increasing last component
            chosen = consistent(x, primes, n)
        if chosen:
            if is_solution(x, primes, n):
                # ^ if it's a solution, it gets printed and added to list of solutions
                solutions.append(x.copy())
                output_solution(x, primes)
            else:
                x.append(-1)
        else:
            x = x[:-1]
            # ^ deleting last element if not consistent


if __name__ == '__main__':
    n = ''
    while isinstance(n, int) is False:
        try:
            n = int(input('Give a positive number >'))
        except ValueError:
            print("a number pls!!!")
    primes = list_primes(n)
    solutions = []
    back_iter(primes, n, solutions)
    if n <= 3:
        print('no bueno numbero')
    else:
        print('=', n)
        print(len(solutions))
