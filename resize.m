%This function simply removes missing data and classes
%we are not analyzing so that those do not enter our
%other functions.

function output = resize(vector1)

[~, text_2] = xlsread('Top 73 Course List.xlsx');
text_2 = text_2(:,2:2);

text_2 = string(text_2);
vector1 = string(vector1);

new_vector = strings;
counter = 1;
for ii = 1:length(text_2)
    for jj = 1:length(vector1)
        sameBool = isequal(text_2(ii,1), vector1(jj,1));
        if (sameBool == 1)
            new_vector(counter, 1) = text_2(ii,1);
            counter = counter + 1;
        end
    end
end


output = new_vector
end %function
