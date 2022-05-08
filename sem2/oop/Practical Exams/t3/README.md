# Weather
Write an application allowing you to see the weather for the current day. Each **Time Interval** is represented by its start and end hours (between `0` and `23`), `precipitation probability` and a `description` (e.g. *sunny*, *rainy* or *cloudy*). This data is loaded from a text file in which each time interval of the day is represented, and no intervals overlap. You may use the following data:

`0;2;5;overcast`\
`2;5;10;overcast`\
`5;6;15;foggy`\
`6;8;20;foggy`\
`8;9;10;overcast`\
`9;12;5;sunny`\
`12;15;0;sunny`\
`15;16;5;overcast`\
`16;17;45;rain`\
`17;19;85;thunderstorm`\
`19;21;35;rain`\
`21;23;22;overcast`

Write a GUI application using the Qt framework which allows to:
1. Visualize all time intervals in a [QListWidget](https://doc.qt.io/qt-5/qlistwidget.html). The list will display each time interval, the precipitation probability and the description. When the application starts, the list is automatically populated from the file  **[2p]**.
2. Filter the list according to precipitation probability. This will be achieved using a [QSlider](https://doc.qt.io/qt-5/qslider.html) widget with a `[0, 100]` scale. The list will be filtered to present the data for those time intervals where the precipitation probability is smaller than the slider's value (e.g. setting the slider at 50 filters the list to not show any time interval where the precipitation probability is `>50%`) **[2p]**
3. Filter the list according to `description`. This will be achieved using a number of [QCheckBox](https://doc.qt.io/qt-5/qcheckbox.html) controls. There will be one checkbox for each existing weather description (e.g for the example above, there will be 5 checkboxes labelled `overcast`, `foggy`, `sunny`, `rain` and `thunderstorm`). The list will be filtered to present the data for those time intervals that have their corresponding check box selected (e.g. if only the checkboxes for `sunny` and `rain` are selected, time intervals with other  descriptions will not be shown) **[2p]**.
4. The filters for functionalities **2** and **3** can be combined (e.g. setting the slider to `16` and selecting only the `foggy` checkbox will show only the `5-6` time interval) **[2p]**.
5. Allow the user to return to the unfiltered list by pressing a button. This will also set the slider to `100` and deselect all checkboxes **[1p]**.

## Requirements
* No score is awarded for a console-based user interface.
* If the data are not read from the file, **0.5p** are subtracted from the indicated score for each functionality.

Default **[1p]**
