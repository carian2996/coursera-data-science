README
==========

**First, and very important, set your working directory**
*IMPORTANT: You don't have to download the data, the code will handle that.*

The run_analysis.R script should download (if doesn't exit the data) the necessary data, unzip the folder and load the data in the working directory.

If the you already download the folder, just rename with "data.zip".

The folder data.zip and the script should be in your working directory in order to the script works properly...

	- Run the script in R. (Use the source function or simply run the code from the console)
	- The code will execute the actions to download the data in your working directory
	- The code will execute the actions to unzip the data in your working directory

Now that you have the resources to work...

	- The code will execute the merge from the test and the train data
	- Merge the labels and the variable names
	- Search the variables with only two types of measurements means and standard deviations
	- Rename the activities and the variable names

Finally

	- Create a new set of data and will calculate the mean of each variable, of each subject and activity
	- Write a .txt file in you working directory.

ICR
