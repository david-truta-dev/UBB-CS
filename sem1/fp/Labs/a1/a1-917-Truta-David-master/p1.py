# Problem number one.
# Generates the first prime number larger than a given natural number n.
from math import sqrt


def is_prime(m):
    """
    Computes whether a number is prime or not.
    :param m: The number we check if it's a prime number
    :return: 1 if m is prime, 0 if it's not
    """
    if m == 2:
        return 1

    if m < 2 or m % 2 == 0:
        return 0

    for i in range(3, int(sqrt(m)) + 1, 2):
        if m % i == 0:
            return 0
    return 1


def next_prime(m):
    """
    Computes the smallest prime number greater than m.
    :param m: The number we compare the returned value to
    :return: the smallest prime number greater than m
    """
    if m <= 1:
        return 2
    if m % 2 == 0:
        m = m + 1
    else:
        m = m + 2

    while True:
        if is_prime(m):
            return m
        m = m + 2


if __name__ == '__main__':
    try:
        n = int(input("Enter a natural number:"))
        print("The next largest prime number is:", next_prime(n))
    except:
        print("This i not a number!Enter a number!")
