%This function simply removes classes that contain missing data in their
%time columns.  The new_vector that is the output is the edited version 
%of the input_vector

function output = resize(input_vector)

%%
%read in the top class file to give something to compare the input vector to
[~, top_class_text] = xlsread('Top 73 Course List.xlsx');
top_class_text = top_class_text(:,2:2);

top_class_text = string(top_class_text);
input_vector = string(input_vector);

%%
%Compares each class of the input vector, one at a time, to each of the
%classes in the top course list
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
