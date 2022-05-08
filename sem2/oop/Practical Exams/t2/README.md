# What's up, Doc?

ACME Inc. want to offer an application to help people monitor their health. The application stores the results for two medical measurements: BMI (Body Mass Index) and BP (Blood Pressure). The BMI is characterized by a `double` value. This result is normal when in the interval `[18.5, 25]`. The BP is characterized by `integer` systolic and diastolic values. The result is normal when the systolic value is in the interval `[90, 119]`, and the diastolic one is in the interval `[60, 79]`. Both of them will include the date they were recorded.
 
The application will provide the following functionalities:
1.	Add a new measurement. Read the measurement type and date. If it is BMI, then read the double value, otherwise read the integer values for systolic and diastolic pressures.\
  **(a)**	A new measurement with the given information is added **[1p]**.\
  **(b)**	If the measurement type is not `"BMI”` or `“BP”`, or if the date is not composed of exactly 10 characters (e.g. today is `2021.04.26`), then the measurement should not be added, and an error message shown **[1p]**. *Points awarded only if this is implemented using the exception mechanism and exception type objects. You may use existing exceptions (e.g. std::exception, std::runtime_error)*.\
  **(c)**	After the measurement is added, show a message specifying if it is within the range of normal values **[1p]**.
2.	Display the list of recorded measurements. The first row will consist of the person’s name, with one measurement result on each subsequent row **[1p]**. Use text justification to pretty print the table **[1p]**.    
3.	Show if the person is healthy. The person is considered to be healthy if all their measurements for the past two months have normal values. The current month is provided by the user. If the month is 1, only measurements in the current month are considered **[2p]**.
4.	Save all the measurements taken after a given date to a text file. Each row will represent the type, date and value for one measurement. The filename is provided by the user **[2p]**.

## Non-functional requirements
- Have at least 5 measurements in the initial list (you may add them directly from source code).
- The solution must implement the UML diagram below; you are free to add other classes or methods.
- Functionalities **1(c)**, **3** and **4** are graded only if your implementation uses inheritance and polymorphism, according to the UML diagram below.

<img width="726" alt="class_hierarchy" src="https://user-images.githubusercontent.com/25611695/115854078-8fa1d580-a432-11eb-8b96-0e7a048e4a53.png">

**[default 1p]**
