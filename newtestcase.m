
%This function recieves an input from "read_popular_classes" and reads the
%file "Class Size for Course Demand".  It compares what is in the input
%vector to what is in the file and will save the information from the file
%in a new vector called "new_class_list".  This is the list of all classes
%in the file "Class Size for Course Demand" and in the vector
%class_name_vector.

function output = newtestcase(class_name_vector)

filename = 'Class Size for Course Demand.xlsx';
[num, txt] = xlsread(filename);
[~, width_num] = size(num);
[~, width_txt] = size(txt); %determines how many columns are needed to store all of the information in the new matrix
total_num_classes = length(txt(:,2));
new_class_list_s = strings(total_num_classes,width_txt); %vector of all of the popular classes from the large list (initialization)
new_class_list_num = -ones(total_num_classes,width_num);
class_number = 1;


for ii = 2:total_num_classes
    for jj = 1:length(class_name_vector) %check each wanted class against a single class from large list to see if they match
        boolean = isequal(class_name_vector(jj,1),txt(ii,2)); %compares the input and what is in the 'txt' matrix at the given location.
        %If true, returns a 1, if
        %false gives a 0
        if boolean == 1
            new_class_list_s(class_number,:) = txt(ii,:); %assigns the class to a new overall list if found on original list
            new_class_list_num(class_number,:) = num(ii - 1,:);
            class_number = class_number + 1; %sets up the next class so it is stored in the correct location
        end %if
    end %for jj
end %for ii


output = [new_class_list_num, new_class_list_s];

end %fcn
