%This function simply removes classes that contain missing data in their
%time columns.  The new_vector is the edited version of the input_vector.
%
%Input is a vector of strings that contain class names, the output will
%give a vector of strings that contains only the classes from the input
%vector that are in the top class list.
%
%This function is not implemented in the main code.

function output = resize(input_vector)
%%
%Reads in top class file for reference.
[~, top_class_text] = xlsread('Top 73 Course List.xlsx');
top_class_text = top_class_text(:,2:2);

top_class_text = string(top_class_text);
input_vector = string(input_vector);

%%
%compares the input vector to the top classes vector.  Removes class
%sections that are not included on the top class list.
new_vector = strings;
counter = 1;
for ii = 1:length(top_class_text)
    for jj = 1:length(input_vector)
        sameBool = isequal(top_class_text(ii,1), input_vector(jj,1));
        if (sameBool == 1)
            new_vector(counter, 1) = top_class_text(ii,1);
            counter = counter + 1;
        end
    end
end


output = new_vector
end %function