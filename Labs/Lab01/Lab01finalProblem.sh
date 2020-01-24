cut -f 2-4 -d , PredPreyData.csv > Lab01finalProblemTEMP.csv
cat Lab01finalProblemTEMP.csv | (head -n 1; tail) > Lab01finalProblem.csv
rm Lab01finalProblemTEMP.csv