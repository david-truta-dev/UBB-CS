# Test 1
Welcome to the future. The age of Python is long gone. After the roaring 2000s reigned by Java, from the ashes of the two decade empire ruled by Python, another language takes over the realm: Mamba. Mamba is minimalist and allows writing simple math instructions in the form of function calls defined syntactically as follows:

`function_name(p1,p2,...,pn)=p1(+|-)p2(+|-)p3(+|-)...(+|-)pn`

Let's consider the following Mamba functions as examples:\
`add(a,b)=a+b`\
`negate(param)=-param`\
`alternate_sum(first,second,third,fourth)=first-second+third-fourth`

You are employed by the establishment to write, in the now obsolete Python language, a program that evaluates Mamba functions. You will implement the commands below, so that users can run them repeteadly and in any order:

1. `add function_name(p1,p2,...,pn)=p1(+|-)p2(+|-)p3(+|-)...(+|-)pn`\
This adds the given Mamba function to you program [**2p**]. For example:\
`add add(a,b)=a+b`\
`add alternate_sum(first,second,third,fourth)=first-second+third-fourth`

2. `list function_name`\
This displays the correct Python code of the given function to the console (whitespace not required) [**2p**]. An error is displayed if the function was not previously defined [**1p**]. For example:\
`list add` should display `def add(a,b): return a+b`\
`list alternate_sum` should display `def alternate_sum(first,second,third,fourth): return first-second+third-fourth`

3. `eval function_name(actual_parameters)`\
This displays on the console the result of calling the function with the given parameters [**2p**]. In case the function definition contains an error, a message is displayed on the console [**1p**]. For example:\
`eval add(1,2)` will print `3`\
`eval alternate_sum(1,2,3,4)` will print `-2`

---
**Keep in mind:**
- Use procedural programming (using classes is prohibited), functions communicate using parameters and return values.
- Create specification for the `add` function [**1p**]
- Grading is done according to (partially) working functionalities
- Once the `add` and `list` functionalities are implemented, study Python's inbuilt [exec function](https://docs.python.org/3/library/functions.html#exec)
- Default [**1p**]
