CPATH='.:lib/hamcrest-core-1.3.jar:lib/junit-4.13.2.jar'

rm -rf student-submission
rm -rf grading-area

mkdir grading-area

git clone $1 student-submission
echo 'Finished cloning'

if [ ! -e "student-submission/ListExamples.java" ]; then
    echo "Error: ListExamples.java file is missing in the student's repository."
    exit 1  
fi

cp -r student-submission/* grading-area
echo "Copied student's files to the grading area."

javac -cp "$CPATH" grading-area/GradeServer.java grading-area/ListExamples.java


if [ $? -ne 0 ]; then
    echo "Error: Code compilation failed. Student's code does not compile."
    exit 1  
fi

test_output=$(java -cp "$CPATH" org.junit.runner.JUnitCore TestListExamples.java)


if echo "$test_output" | grep -q "OK"; then
    echo "All tests passed. Student's code is functioning correctly."
else
    echo "Tests failed. Student's code is not functioning correctly."
fi



# Draw a picture/take notes on the directory structure that's set up after
# getting to this point

# Then, add here code to compile and run, and do any post-processing of the
# tests
