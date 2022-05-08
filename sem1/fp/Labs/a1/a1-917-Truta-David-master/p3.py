# Problem number 13
# Determines the n-th element of the sequence 1,2,3,2,5,2,3,7,2,3,2,5,11,...


def prime_divisors(m, my_list):
    """
    Computes the prime divisors of m in my_list.
    :param m:
    :param my_list: The list where we store the prime divisors of m
    :return: -
    """
    my_list.clear()
    om = m  # We keep the value of m in om, because we are gonna modify m
    d = 2
    while m > 1 and d < om:
        if m % d == 0:
            my_list.append(d)
        while m % d == 0:
            m /= d
        d += 1


def nth_element(n):
    """
    Computes the given sequence until it reaches the n-th element,
    but only retains the proper divisors of a number, not the whole sequence.
    :param n:
    :return: n-th element of the sequence
    """
    if n == 1:
        return 1
    k, num = 2, 2
    my_list = [0]
    while True:
        prime_divisors(num, list)
        if len(my_list) == 0:
            if n == k:
                return num
            k += 1
            num += 1
        else:
            for i in range(len(my_list)):
                if k == n:
                    return my_list[i]
                k += 1
            num += 1


if __name__ == '__main__':
    try:
        x = int(input("Enter a natural number:"))
        print("The",x, " number of the sequence is:", nth_element(x))
    except:
        print("This is not a natural number!Enter a natural number!")
