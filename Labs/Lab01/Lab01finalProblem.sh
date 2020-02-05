#pare csv file down to just time, prey, and predator columns and create a temporary file
cut -f 2-4 -d , PredPreyData.csv > Lab01finalProblemTEMP.csv
#combine head (number of rows=1) and tail (last 10 lines) of temp file into final file
cat Lab01finalProblemTEMP.csv | (head -n 1; tail) > Lab01finalProblem.csv
#delete temporary file
rm Lab01finalProblemTEMP.csv