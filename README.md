NEEDLE TO PLOT

Description

This R script processes a confusion matrix based on Needleman-Wunsch alignment results (specifically for ePRV vs retrotransposons) and visualizes the confusion matrix in a custom plot. It utilizes a caret package to calculate confusion matrix statistics and then customizes the output using a function to draw a visually appealing confusion matrix with color gradients.

Key Components of the Script:
Data Import: The script starts by reading a text file (needle_loov_obs_pred.txt), which contains predicted and actual classifications of sequences (either as ePRVs or retrotransposons). These classifications are stored in a data frame.

Caret Library: The caret library is used to generate a confusion matrix from the imported data, where the predicted values are compared against the actual values.

Custom Function (draw_confusion_matrix): This function is designed to plot a confusion matrix using a color gradient to distinguish correct and incorrect classifications. It provides detailed statistics related to the performance of the model, including accuracy, precision, recall, and other classification metrics.

Prepare the Data: Ensure you have a file named needle_loov_obs_pred.txt containing the observed (actual) and predicted classifications for your data in tab-separated format. The file should contain two columns:

Column 1: Actual classifications (e.g., ePRV or retrotransposon)
Column 2: Predicted classifications (e.g., ePRV or retrotransposon)

The script will create a confusion matrix using the imported data and calculate metrics such as accuracy, precision, recall, etc.
The draw_confusion_matrix function will plot a confusion matrix, where the cells are color-coded based on the number of correct or incorrect classifications:
Green shades represent correct classifications.
Red shades represent incorrect classifications.
In addition to the matrix plot, you will see detailed classification statistics, such as sensitivity, specificity, precision, and overall accuracy, displayed below the matrix.

Visual Output: The matrix plot will display the number of True Positives (ePRVs correctly classified), True Negatives (retrotransposons correctly classified), False Positives (retrotransposons classified as ePRVs), and False Negatives (ePRVs classified as retrotransposons).

This script provides an easy way to visualize the performance of Needleman-Wunsch sequence alignment in classifying ePRVs and retrotransposons. With the custom draw_confusion_matrix function, you can generate detailed, colored confusion matrices, making it easier to interpret classification results visually and quantitatively.

######################

HMM TO PLOT

Description
This R script is designed to calculate and visualize the confusion matrix based on HMMER (Hidden Markov Model) results for identifying endogenous pararetroviruses (ePRVs) and retrotransposons in genomic data. It uses the caret package to compute performance metrics such as accuracy, precision, recall, and more. The script also includes a custom plotting function that generates a confusion matrix visualization with color gradients, helping to assess the classification performance of the HMMER tool.

Key Components:
Data Import: The script reads a file (list_for_confussionmatrix_new.txt) containing predicted and actual classifications of sequences. The first column represents the actual (observed) classifications, and the second column represents the predicted classifications. Both columns are stored as factors in a data frame.

Caret Library: The caret package is used to create the confusion matrix, which evaluates how well the classification performed in terms of identifying true positives (ePRVs correctly classified), true negatives (retrotransposons correctly classified), false positives, and false negatives.

Custom Plot Function (draw_confusion_matrix): A custom function is used to draw the confusion matrix. This function:

Uses color gradients to represent correct and incorrect classifications.
Displays both the matrix and detailed performance metrics such as precision, recall, and overall accuracy.
Uses color palettes from RColorBrewer to highlight performance, with green shades indicating correct classifications and red shades indicating errors.

Prepare the Input File: Ensure you have the file list_for_confussionmatrix_new.txt that contains two columns:

Column 1: The observed (true) classifications for sequences (e.g., ePRV or retrotransposon).
Column 2: The predicted classifications by the HMMER algorithm.

Interpretation:
The confusion matrix will display:
True Positives (ePRVs correctly classified)
True Negatives (retrotransposons correctly classified)
False Positives (retrotransposons classified as ePRVs)
False Negatives (ePRVs classified as retrotransposons)
In addition, detailed classification statistics such as precision, recall, and accuracy are shown beneath the matrix.

Visual Output:
The confusion matrix plot will include:
The classifications (ePRV and Retrotransposon) on both axes.
The count of True Positives, True Negatives, False Positives, and False Negatives within the matrix.
Color gradients to visually distinguish between correct and incorrect classifications.
A separate section displaying key performance metrics such as precision, recall, specificity, and overall accuracy.

This script provides an automated way to calculate and visualize the performance of HMMER in classifying ePRVs and retrotransposons. The custom plot function makes it easy to interpret the results, highlighting correct and incorrect predictions with color-coded visual aids and displaying detailed classification statistics.

######################

HMM TO BED

Running the script:
You can now run the script directly from the command line by specifying the input and output file paths:

./script_name.py input_file_path output_file_path

Instructions for Use
Here are the instructions you can provide to users:

Running the Script
Prerequisites:

Ensure Python 3 is installed on your system. You can download it from python.org.
Save the script to a known location on your computer.
Usage:

Open a terminal or command prompt.
Navigate to the directory where the script is located.

Run the script by entering:
./script_name.py /path/to/input.txt /path/to/output.bed

Replace /path/to/input.txt and /path/to/output.bed with the paths to your actual input and output files.
Output:

The script will process the input HMM table and save the output in BED format to the specified output file path.
A confirmation message will display the location of the output file upon completion.
