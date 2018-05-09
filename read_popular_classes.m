%This function reads the file "Top 73 Course List" and stores it into a
%vector that is passed to newtestcase.  Once newtestcase runs and sends
%back a new vector, the new vector gets any of its unnecassary cells
%deleted to create the final vector "popular_class_list".


function popular_class_list = read_popular_classes()
filename = 'Top 73 Course List.xlsx';
[~, Top_classes_text] = xlsread(filename); %num information is nulled out because it is not needed
popular_class_list = newtestcase(Top_classes_text(:,2)); %calls newtestcase function to populate list.

jj = 0;
isEmptyLocation = 0;
while (isEmptyLocation == 0)
    isEmptyLocation = isequal(popular_class_list(jj+1,23),""); %Column 23 is the one with the names of the classes stored
    %Line above checks to find where the first empty cell is located
    jj = jj + 1;
end %This while loop finds the index where the vector starts to have empty spaces

%%
%Gets rid of all of the empty locations in the matrix
popular_class_list = popular_class_list(1:(jj-1),:); 
end