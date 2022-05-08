# Write the implementation for A2 in this file
# Properties 3 and 8
from math import sqrt
import random


# =====================  Getter & Setter Functions  ==============================
def create_complex(r, i):
    """ Returns a tuple of two ints, which represents a real number."""
    if isinstance(r, int) is False or isinstance(i, int) is False:
        raise ValueError('Real and Imaginary parts should be given as natural numbers!')
    c = (r, i)
    return c


def get_complex_real(comp):
    """Returns real part of complex number(first element of tuple)"""
    return comp[0]


def get_complex_im(comp):
    """Returns imaginary part of complex number(second element of tuple)"""
    return comp[1]


# =================  UI section  ================================================
def what_it_does():
    """
    UI function
    Description of program for the UI
    :return: -
    """
    print("\tThis program reads n complex numbers and it returns the longest sequence of complex"
          "\nnumbers that observes a given property.", end="")


def read_complex():
    """
    UI function
    Returns two int values , which represent the real and imaginary part of a complex.
    :return: returns two int values
    """
    return create_complex(int(input("Give real part of a complex number:")),
                          int(input("Give imaginary part of a complex number:")))


def read_new_list_complex():
    """
    UI function
    This returns a list of tuples, which represent the complex numbers.
    :return: a list of tuples
    """
    x = int(input("How many complex numbers:"))
    c_list = []
    for i in range(x):
        c_list.append(tuple(read_complex()))
    return c_list


def add_to_list(c_list):
    """
    UI function
    Adds complex number(s) to an existing list.
    :param c_list: a list of complex numbers
    :return: -
    """
    print("How many complex numbers do you want to add?(ex:1,2,3,...)")
    x = input("Enter here:")
    x = int(x)
    for i in range(x):
        c_list.append(tuple(read_complex()))
    print("Current list: ", end="")
    write_list_complex(c_list, 0, len(c_list))


def simplified_im_part(comp):
    """
    UI function
    Returns a string, which represents a simplified view of the imaginary part.
    :param comp: a complex number(tuple)
    :return: a string
    """
    if get_complex_im(comp) == -1:
        # if im. part is -1 it writes '-i' instead of '-1i'
        return "-i"
    elif get_complex_im(comp) == 1:
        if get_complex_real(comp) == 0:
            # if im. part is 1 and real part is 0 it writes 'i' instead of '+1i'
            return "i"
        else:
            # if im. part is 1 and real part is different from 0, it writes '+i' instead of '+1i'
            return "+i"
    elif get_complex_im(comp) > 0:
        return "+" + str(get_complex_im(comp)) + 'i'
        # if im. part is bigger than 0 and different from 1, it writes '+4i' instead of '4i'
    else:
        # if im. part is less than 0 and different from 1, it writes '-4i', because the - is added by itself
        # I had to separate the case from above(im. part >0) from this onw to not get something like '+-4i'
        return str(get_complex_im(comp)) + 'i'


def simplified_comp(comp):
    """
    UI function
    Returns a string, which represents a simplified view of the complex number.
    :param comp: a complex number(tuple)
    :return: a string
    """
    if get_complex_real(comp) == 0 and get_complex_im(comp) == 0:
        # If the real and im. parts are 0 show only one zero
        return str(get_complex_real(comp))
    elif get_complex_real(comp) == 0:
        # If the real part is 0 ant the other is not show only the im. part
        return str(simplified_im_part(comp))
    elif get_complex_im(comp) == 0:
        # If the im. part is 0 ant the other is not show only the real part
        return str(get_complex_real(comp))
    else:
        # If none of them are 0 then just
        return str(get_complex_real(comp)) + simplified_im_part(comp)


def write_complex(comp):
    """
    UI function
    Prints a complex number and simplifies it.
    :param comp: A complex number(tuple)
    :return: -
    """
    print(simplified_comp(comp), end="")


def write_list_complex(c_list, s, e):
    """
    UI function
    Prints a list of complex numbers from index s to e-1
    :param e: ending index
    :param s: start index
    :param c_list: list of complex numbers
    :return: -
    """
    write_complex(c_list[s])
    for i in range(s + 1, e):
        print(", ", end="")
        write_complex(c_list[i])


def wr_longest_seq(c_list, s, e):
    """
    Prints the longest sequence of comp. numbers that meet the requirements, form c_list.
    :param c_list: list of comp. numbers
    :param s: starting index of longest sequence
    :param e: ending index of longest sequence
    :return: -
    """
    if s == e == 0 or e - s == 1:
        print("\nThere are no sequences longer than 1.")
    else:
        print("\nLongest sequence: ", end="")
        write_list_complex(c_list, s, e)


def get_command(c_list):
    """
    UI function
    returns a string, which lets the ui() function know what to do.
    :param c_list: the list of complex numbers(,needed in order to print it.)
    :return: a string (new, no, yes)
    """
    return str(input("\n\t\t'add' - add more complex numbers to the current list"
                     "\n\t\t'new' - delete default list and add a new list"
                     "\n\t\t'new random' - delete default list and create a new random list(length of list is 10)"
                     "\n\t\t'1' - print the longest sequence of comp. numb. that have the same module"
                     "\n\t\t'2' - print the longest sequence of comp. numb. that have their module in range [0,10]"
                     "\n\t\t'both' - print the longest sequence with both properties"
                     "\n\t\t'x' - Exit program"
                     "\n\tCommand:"))


def ui(c_list):
    """
    Main UI function
    This calls all the other functions(except default_list), depending on the input(which is given by get_command())
    It is also the only UI function that calls a functionality function(longest_sequence())
    :param c_list: the list of comp. numbers.
    :return:-
    """
    what_it_does()
    print("\nDefault list: ", end="")
    write_list_complex(c_list, 0, len(c_list))
    command = get_command(c_list)
    while command != "x":
        if command == "add":
            try:
                add_to_list(c_list)
            except ValueError as ve:
                print("ERROR!" + str(ve))
        elif command == "new":
            try:
                c_list = read_new_list_complex()
                print("New list:", end="")
                write_list_complex(c_list, 0, len(c_list))
            except ValueError as ve:
                print("ERROR!" + str(ve))
        elif command == '1':
            print("Current list:", end="")
            write_list_complex(c_list, 0, len(c_list))
            s, e = longest_sequence(c_list, command)
            wr_longest_seq(c_list, s, e)
        elif command == '2':
            print("Current list:", end="")
            write_list_complex(c_list, 0, len(c_list))
            s, e = longest_sequence(c_list, command)
            wr_longest_seq(c_list, s, e)
        elif command == 'both':
            print("Current list:", end="")
            write_list_complex(c_list, 0, len(c_list))
            s, e = longest_sequence(c_list, command)
            wr_longest_seq(c_list, s, e)
        elif command == 'new random':
            c_list = default_list()
            print("Current list:", end="")
            write_list_complex(c_list, 0, len(c_list))
        else:
            print("Enter a relevant command!")
        command = get_command(c_list)


# ================================ Operations section ======================================


def default_list():
    """
    Functionality function
    Returns list of 10 tuples, which represent the default complex numbers of the list.
    Random comp. numbers.
    :return: list of 10 tuples
    """
    c_list = []
    for i in range(10):
        r = random.randrange(-100, 100)
        i = random.randrange(-100, 100)
        c_list.append(create_complex(r, i))

    # c_list = [create_complex(0, 1), create_complex(-1, 0), create_complex(1, 0), create_complex(1, -1),
    #           create_complex(6, 13), create_complex(5, 4), create_complex(2, 2), create_complex(-2, -2),
    #           create_complex(2, -2), create_complex(-2, 2)]
    return c_list


def module_of_complex(comp):
    """
    Functionality function
    Computes the module of a complex number.
    :param comp: a complex number(tuple)
    :return: the module of a complex number
    """
    return sqrt(get_complex_real(comp) * get_complex_real(comp) + get_complex_im(comp) * get_complex_im(comp))


def module_in_range(comp):
    """
    Functionality function
    Returns if a complex number's module is in [0,10] range.
    :param comp: a comp. number
    :return: true if value in range, false if it's not
    """
    return module_of_complex(comp) <= 10


def longest_sequence(c_list, p):
    """
    Functionality function
    Computes starting and ending index of longest sequence(depending on properties), if the length of longest sequence
     is 1, then st = en  = 0.
    :param p: the property of the longest sequence.
    :param c_list: list of comp. numbers.
    :return: st = starting index of longest sequence, en = ending index of longest sequence
    """
    st, en, mx, k, i = 0, 0, 0, 0, 0
    # k is an offset, a second index which searches for the longest sequence starting from i.
    while i < len(c_list):
        a, k = module_of_complex(c_list[i]), 0
        while True:
            # stopping while loop depending on the property!
            if p == "1":
                # property 1
                if i + k >= len(c_list) or a != module_of_complex(c_list[i + k]):
                    break
            elif p == "2":
                # property 2
                if i + k >= len(c_list) or module_in_range(c_list[i + k]) == 0:
                    break
            elif p == "both":
                # both properties
                if i + k >= len(c_list) or a > 10 or a != module_of_complex(c_list[i + k]):
                    break
            k += 1
        if k > mx:
            # k = length of longest sequence starting from i, if k is bigger than the length  longest sequence(mx)
            # , then it becomes the longest sequence.
            mx = k
            st = i
            en = i + k
        if k > 1:
            # if the second while loop did some significant steps, we advance in the first loop by k.
            i += k
        else:
            # else advance in first loop by one.
            i += 1
    return st, en


# ============================== Starting function =====================================


def start():
    comp_list = default_list()
    # create a list with the default values.
    ui(comp_list)
    # calls ui function which takes care of the rest.


start()
