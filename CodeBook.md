run_analysis.R retrieves, cleans and sorts a Human Activity dataset curated by the University of California - Irvine Machine Learning Repository. More information on the dataset is found in the README file, which also contains links to the repository and the dataset itself.

The variables created directly from the data set files are:

* features - a list of the data variables measured during the experiment and those variables' numerical codes
* act_lables - the list of activitys performed and each activity's numerical code
* X_train - training data
* y_train - trainng labels
* X_test - test data
* y_test - test labels
* subject_train - numerical identifiers of subjects in training set
* subject_test - numerical identifiers of subjects in the test set

Those variables were then used to create:

* train - a merged data set contianing the training data, labels and subjects
* test - a merged data set containing the test data, labels and subjects
* train_test - the combined 'train' and 'test' sets
* MeanStd - locations of the mean and standard deviation information with 'train_test'
* valuesOnly - data frame containing only the mean and standard deviation information
* tidy_data - a cleaned up version of valuesOnly


