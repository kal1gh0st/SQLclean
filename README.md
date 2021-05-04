# SQLclean
![immagine](https://user-images.githubusercontent.com/56889513/117015955-82b69900-acf2-11eb-98d7-f9949942fc3d.png)
![immagine](https://user-images.githubusercontent.com/56889513/117016011-8f3af180-acf2-11eb-957f-63ecfafd6663.png)

This SQL code was written to check the db and remove duplicate file copies or files but with different dates
Real world data is almost always messy. As a data scientist or a data analyst or even as a developer, if you need to discover facts about data, it is vital to ensure that data is tidy enough for doing that. There is actually a well-rounded definition of tidy data, and you can check out this wiki page to find more resources about it.

In this tutorial, you will be practicing some of the most common data cleaning techniques in SQL. You will create your own dummy dataset, but the techniques can be applied to the real world data (of the tabular form) as well. The contents of this tutorial are as follows:

Different data types and their messy values
Problems that can raise from messy numbers
Cleaning numeric values
Messy strings
Cleaning string values
Messy date values and cleaning them
Duplications and removing them
Lots of things to cover. Let's begin!

Note that you should already be knowing how to write basics SQL queries in PostgreSQL (the RDBMS you will be using in this tutorial). If you need to revise the concepts then following might be some useful resources:

DataCamp's Intro to SQL for Data Science course
Beginner's Guide to PostgreSQL
Different data types, their messy values, and remedies.
In the tabular forms of data, the most common data-types are string, numeric or date-time. You can encounter messy values across all of these types. Let's now take each of these types and see some examples of their respective messy values. Let's start with the numeric type.

Messy numbers
Numbers can be in messy forms in a number of ways. Here, you will be introduced to the most common ones:

Undesired type/Type mismatch: Consider there is a column named age in a dataset you are working with. You see the values that are present in that column are of float type - the sample values are like 23.0, 45.0, 34.0 and so on. In this case, you don't need the age column to be of float type. Isn't it so?

Null values: While this is particularly common with all of the data-types mentioned above, null values here merely means that the values are not available/blank. However, null values can be present in other forms as well. Take the Pima Indian Diabetes dataset for example. The dataset contains zero values for columns like Plasma glucose concentration, Diastolic blood pressure which is practically invalid. If you perform any statistical analysis on the dataset without taking care of these invalid entries, your analysis will not be accurate.

Let's now study the problems that can get raised from these issues and how to deal with them.

Problems with messy numbers and dealing with them
Let's now take a look at the most common problems that you may face if you do not clean the messy data (w.r.t to the above-mentioned types).

1. Data aggregation
Suppose you have null entries for a numeric column and you are calculating summary statistics (like mean, maximum, minimum values) on that column. The results will not get conveyed accurately in this case. Again consider the Pima Indian Diabetes dataset with the invalid zero entries. If you calculated summary statistics on the columns as mentioned before, would you get the right results? Won't the results be erroneous? So, how to address this problem? There are several ways:

- Removing the entries containing missing/null values (not recommended)
- Imputing the null entries with a numeric value (typically with mean or median of the respective column)
