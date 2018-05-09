%This function recieves an input from "read_popular_classes" and reads the
%file "Class Size for Course Demand".  It compares what is in the input
%vector to what is in the file and will save the information from the file
%in a new vector called "new_class_list".  This is the list of all classes
%in the file "Class Size for Course Demand" and in the vector
%class_name_vector.
%
%The input vector the list of classes needed that need to be saved in a new
%vector

function output = newtestcase(class_name_vector)

filename = 'Class Size for Course Demand.xlsx';
[num, txt] = xlsread(filename);
[~, width_num] = size(num); %records number of columns in the number matrix
[~, width_txt] = size(txt); %records number of colums in the txt matrix
total_num_classes = length(txt(:,2)); %This is just a shortcut variable so one doesn't need to find the length of the txt matrix every time
new_class_list_s = strings(total_num_classes,width_txt); %matrix of all of the popular class information from the large list, only string elements (initialization)
new_class_list_num = -ones(total_num_classes,width_num); %matrix of all of the popular class information from the large list, only number elements (initialization)
class_number = 1; %Keeps track of what row to store a matching class in


%%
%Populates a new vector of class sections if the class name is in the top
%classes from the input vector. All the saved sections are put in
%new_class_list along with the section, seat count and various other
%information

for ii = 2:total_num_classes %Large list class index
    for jj = 1:length(class_name_vector) %check each wanted class against a single class from large list to see if they match
        foundAmatchingClass = isequal(class_name_vector(jj,1),txt(ii,2)); %compares the input and what is in the 'txt' matrix at the given location.
        %If true, returns a 1, if
        %false gives a 0
        if foundAmatchingClass == 1
            new_class_list_s(class_number,:) = txt(ii,:); %assigns the class to a new overall list if found on original list
            new_class_list_num(class_number,:) = num(ii - 1,:); 
            class_number = class_number + 1; %sets up the next class so it is stored in the correct location
        end %if
    end %for jj
end %for ii


output = [new_class_list_num, new_class_list_s];

end %fxn