%RATIO_GEN2  This code will generate the ratio of students wanting to take
%a specific class vs. the number of available seats.  The classes that this
%code generates ratios for can be changed by editing the Excel file "Top 
%73 Course List.xlsx".  This function is mainly used to generate graphs for
%the project.


function output = ratio_gen2()
%%
%This is a general way to identify which column of the input file the
%classes and the corresponding section take place; this is to avoid
%hard-code the specific column numbers.
filename = 'Common Course Combinations.xlsx';
[~, common_course_text] = xlsread(filename);
[~, common_course_row_size] = size(common_course_text);
ii = 1;
foundIt = 0;
row_name = {'Class Eau'};
while (ii <= common_course_row_size) && (foundIt == 0)   
    foundIt = isequal(row_name,common_course_text(1,ii));
    jj = ii;
   ii = ii + 1; 
end
class_column = jj;
class_names_vector = common_course_text(:,class_column);
class_names_vector = string(class_names_vector);


%%
%This section removes all classes that are not top courses from the
%common_course_combination file.
[~, top_course_text] = xlsread('Top 73 Course List.xlsx');
top_course_text = top_course_text(:,2:2);
top_course_text = string(top_course_text);
top_classes_are_in_this_vector = strings;
counter = 1;
for ii = 1:length(top_course_text)
    for jj = 1:length(class_names_vector)
        sameBool = isequal(top_course_text(ii,1), class_names_vector(jj,1));
        if (sameBool == 1)
            top_classes_are_in_this_vector(counter, 1) = top_course_text(ii,1);
            counter = counter + 1;
        end
    end
end


%%
%This section will total how many students need to take a class on their
%degree plan, used to generate a ratio later.
[top_course_text_length, ~] = size(top_course_text);
[top_class_vector_length, ~] = size(top_classes_are_in_this_vector);
class_totals = zeros(top_course_text_length,1);

top_classes_are_in_this_vector = sort(top_classes_are_in_this_vector);
top_classes_are_in_this_vector = cellstr(top_classes_are_in_this_vector);
top_course_text = cellstr(top_course_text);
for ii = 1:top_course_text_length
    counter2 = 0;
    for jj = 1:top_class_vector_length
       isSame = isequal(top_classes_are_in_this_vector(jj,1),top_course_text(ii,1));
       if isSame == 1
           counter2 = counter2 + 1;
       end
    end
    class_totals(ii,1) = counter2;
end

%%
%Determines the total number of seats available among all sections of
%class
popular_classes = read_popular_classes();
[popular_class_length,~] = size(popular_classes);
popular_classes = cellstr(popular_classes);
seats_available = zeros;
for ii = 1:top_course_text_length
    counter2 = 0;
    for jj = 1:popular_class_length
       isSame = isequal(popular_classes(jj,23),top_course_text(ii,1));
       if isSame == 1
           addition = str2double(popular_classes(jj,16));
           counter2 = counter2 + addition;
       end
    end
    seats_available(ii,1) = counter2;
end

%%
%Calculates the ratio of students wanting to take a class to the number of
%seats avaiable for each top class
for mm = 1:length(seats_available)
   if (seats_available(mm,1) > 0)
       ratio(mm,1) = class_totals(mm,1) / seats_available(mm,1);
   else
       ratio(mm,1) = 0;
   end
       
end

output = ratio;
end %function