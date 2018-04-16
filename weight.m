function output = weight(class_name)
class_name = cellstr(class_name);

filename = 'Common Course Combinations.xlsx';
[num, text, everything_else] = xlsread(filename);
[column_size, row_size] = size(text);
ii = 1;
foundIt = 0;
row_name = {'Class Eau'};
while (ii <= row_size) && (foundIt == 0)   
    foundIt = isequal(row_name,text(1,ii));
    jj = ii;
   ii = ii + 1; 
end
class_column = jj;
section_column = class_column + 1;

counter = 1;
for ii = 1:length(text)
    bool = isequal(class_name,text(ii,class_column));
    if bool == 1
        jj = ii;
        student_id = text(ii,15);
        id_didnt_change = 1;
        while (id_didnt_change == 1)
            jj = jj - 1;
            id_didnt_change = isequal(student_id,text(jj,15));
        end
        id_change_found = 1;
        jj = jj + 1;
        while (id_change_found == 1)
            class_vector(counter,1) = text(jj,class_column);
            class_vector(counter,2) = text(jj,section_column);
            id_change_found = isequal(student_id,text(jj,15));
            new_num(counter,1) = num(jj-1,11);
            jj = jj + 1;
            counter = counter + 1;
        end
        class_vector = class_vector(1:end - 1,:);
        new_num = new_num(1:end - 1,:);
        counter = counter - 1;
    end
end

% class_matrix = class_matrix_generator();
% [time_matrix_length, time_matrix_width] = size(class_matrix);
class_vector = string(class_vector);
for ii = 1:length(class_vector)
    isEmpty = isequal(class_vector(ii,2),"");
    if isEmpty == 1
        class_vector(ii,2) = string(new_num(ii,1));
    end
end

[~, text_2] = xlsread('Top 73 Course List.xlsx');
text_2 = text_2(:,2:2);
text_2 = string(text_2);
new_vector = strings;
counter = 1;
for ii = 1:length(text_2)
    for jj = 1:length(class_vector)
        sameBool = isequal(text_2(ii,1), class_vector(jj,1));
        if (sameBool == 1)
            new_vector(counter, 1) = class_vector(ii,1);
            new_vector(counter, 2) = class_vector(ii,2);
            counter = counter + 1;
        end
    end
end
[~,idx] = sort(new_vector(:,1));
sorted_vector = new_vector(idx,:);
sorted_vector = strip(sorted_vector, 'left', '0');

popular_class_list = read_popular_classes();
[pcl_length,~] = size(popular_class_list);
[class_vector_length,~] = size(sorted_vector);
class_enroll = zeros(pcl_length,1);
counter = 1;
for ii = 1:pcl_length
    for jj = 1:class_vector_length
        sameClass = isequal(popular_class_list(ii,23),sorted_vector(jj,1));
        if sameClass == 1
            sameSection = isequal(popular_class_list(ii,1),sorted_vector(jj,2));
            if sameSection == 1
                class_enroll(counter,1) = class_enroll(counter,1) + 1;
                
            end
        end
    end
    counter = counter + 1;
end

class_matrix = class_matrix_generator();
[time_matrix_length, time_matrix_width] = size(class_matrix);

for ii = 1:time_matrix_length
    for jj = 1:time_matrix_width
        foundClassTime = isequal(class_matrix(ii,jj),1);
        if foundClassTime == 1
            class_matrix(ii,jj) = class_matrix(ii,jj) - 1 + class_enroll(ii,1);
        end
    end
end


output = sum(class_matrix);

end