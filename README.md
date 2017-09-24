# Course-Project--Cleaning-Data
The code in run_analysis.R first read the test and training data and store them as data frame.
Then read the features, activity and subject data for further label.
Use the Label data table to label the set data table.
Merge the test and train table, named data.
create a idnex variable by search the mean and standard deviation in the feature table.
Extract the table 'data2' from table 'data' using the index.
Name the variable names using the names selected from features by index.
Label the activity of table 'data2' using Label table and 'activity' table
Label the data2 using subject table
then remove the duplicated value
creat a sub data table containing the mean value for activities.
