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


def output_solution(x):
    """
    Prints a list in the following format: = x[1]+x[2]+x[3]...
    :param x: list of int (a solution)
    :return:-
    """
    res = '= '
    for i in x:
        res += str(i) + '+'
    res = res[:-1]
    print(res)


def is_solution(x, n):
    return sum(x) == n


def consistent(x, n):
    """
    Computes whether a path can lead to a solution by checking if the elements x is in ascending order( to check if it's unique,
    so we don't find the same solution again.) and by checking that the sum of the current path (x) is smaller or
    equal than the given number.
    :param x: list of int (path to a solution OR a solution)
    :param n: int (the given number to be discomposed)
    :return: True if current path can lead to a solution OR if it's a solution, False otherwise
    """
    for i in range(0, len(x) - 1):
        if x[i] > x[i + 1]:
            return False
    return sum(x) <= n


def back_rec(x, primes, n, sol):
    """
    Computes and prints all forms of a number as a sum of prime numbers in a recursive way.
    :param x: list of int (Possible solution)
    :param primes: list of int (list of primes smaller than n)
    :param n: int (the given number)
    :param sol: list of int (valid solutions already found)
    :return: -
    """
    x.append(0)
    for i in primes:
        x[-1] = i
        # ^ set current component
        if consistent(x, n):
            if is_solution(x, n):
                # ^ if it's a solution, it gets printed and added to list of solutions
                output_solution(x)
                sol.append(x.copy())
            back_rec(x, primes, n, sol)
            # ^ continues only if it can lead to a solution
    x.pop()


if __name__ == '__main__':
    n = ''
    while isinstance(n, int) is False:
        try:
            n = int(input('Give a positive number >'))
        except ValueError:
            print("a number pls!!!")
    primes = list_primes(n)
    solutions = []
    back_rec([], primes, n, solutions)
    if n <= 3:
        print('no bueno numbero')
    else:
        print('=', n)
        print(len(solutions))
