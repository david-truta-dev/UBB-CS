# Problem number 9.
# Determines the product of all the proper factors of a given number n
from math import sqrt


def product_of_proper_div(m):
    """
    Computes the product of all the proper factors of m
    :param m: The number from which we get the proper factors
    :return: p - product of the proper factors of m
    """
    p = 1
    # If the number is negative, then it has more proper factors.
    # For example: -9 has the p.f. : -1, 1, 3 ,-3.And so the answer is 9
    if m < 0:  # We check if the number is negative
        m = -m
        sq = int(sqrt(m))
        if sq * sq == m:
            p = p * sq * (-sq) * (-1)
            for i in range(2, sq):
                if m % i == 0:
                    p = p * i * m / i * (-i) * (-m / i)
        else:
            for i in range(2, sq + 1):
                if m % i == 0:
                    p = p * i * m / i * (-i) * (-m / i)
    else:
        sq = int(sqrt(m))
        if sq * sq == m:
            p = p * sq
            for i in range(2, sq):
                if m % i == 0:
                    p = p * i * m/i
        else:
            for i in range(2, sq+1):
                if m % i == 0:
                    p = p * i * m/i
    return p


if __name__ == '__main__':
    try:
        n = int(input("Enter a number:"))
        print("The product of the proper factors of the number is:", int(product_of_proper_div(n)))
    except:
        print("This i not a number!Enter a number!")
