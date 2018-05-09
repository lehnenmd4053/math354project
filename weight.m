%WEIGHT determines how many students are taking a class at a specific time.
%It will output a matrix that shows the total number of students enrolled
%in a specific class, with each row representing a specific class, and each
%row is the time the class takes place in 15 minute intervals.
%
%The input to this function is a class, using the notation weight('GEOG
%178') as an example.  The class must be in all capitals and the numbers
%separated from the letters.
%
%This function will then find all students that have this class on their
%degree program, and all other classes their degree program tells them to
%take.  From here, the function will total the enrollment of each popular
%class and put them into a matrix.

function output = weight(class_name)
class_name = cellstr(class_name);

filename = 'Common Course Combinations.xlsx';
[CourseCombinationNum, CourseCombinationText] = xlsread(filename);
[~, row_size_course_combination] = size(CourseCombinationText);
ii = 1;
foundIt = 0;

%This section makes finding the column with class names more general,could
%just hard code, but this makes the code more applicable.
row_name = {'Class Eau'};
while (ii <= row_size_course_combination) && (foundIt == 0)   
    foundIt = isequal(row_name,CourseCombinationText(1,ii));
    jj = ii;
   ii = ii + 1; 
end
class_column = jj;
section_column = class_column + 1; %we know the section column is 1 column later from the class column

counter = 1;
for ii = 1:length(CourseCombinationText)
    SameClassAsInput = isequal(class_name,CourseCombinationText(ii,class_column)); %finds the stduent that takes the inputed class
    if SameClassAsInput == 1
        jj = ii;
        student_id = CourseCombinationText(ii,15); %stores that specific student's ID number to be used later, rewritten every loop iteration
        id_didnt_change = 1;
        %The following loop moves backwards to find when the student ID
        %switches to something else.  When it does this, it saves that
        %index
        while (id_didnt_change == 1)
            jj = jj - 1;
            id_didnt_change = isequal(student_id,CourseCombinationText(jj,15));
        end
        
        %%
        %This section records all classes that the student is taking to use
        %them to ensure the student is not double-enrolling in a time.
        %Only records student classes of students who are taking the
        %inputed class
        id_change_found = 1;
        jj = jj + 1;
        while (id_change_found == 1)
            total_student_class_vector(counter,1) = CourseCombinationText(jj,class_column);
            total_student_class_vector(counter,2) = CourseCombinationText(jj,section_column);
            id_change_found = isequal(student_id,CourseCombinationText(jj,15));
            new_num(counter,1) = CourseCombinationNum(jj-1,11);
            jj = jj + 1;
            counter = counter + 1;
        end
        total_student_class_vector = total_student_class_vector(1:end - 1,:); %holds all of the classes
                                                  %and section that the 
                                                  %students will be enrolled in
        new_num = new_num(1:end - 1,:);
        counter = counter - 1;
    end
end

%%
%Some of the sections of classes were not stored as text in Excel, this
%section will find all of those entries and store the correct section
%number using the number matrix created by the xlsread
total_student_class_vector = string(total_student_class_vector);
for ii = 1:length(total_student_class_vector)
    isEmpty = isequal(total_student_class_vector(ii,2),"");
    if isEmpty == 1
        total_student_class_vector(ii,2) = string(new_num(ii,1));
    end
end


%%
%This section removes the classes that students are taking, as defined by
%their degree plan, that are not part of the top course list.
[~, textTopClassesTaken] = xlsread('Top 73 Course List.xlsx');
textTopClassesTaken = textTopClassesTaken(:,2:2);
textTopClassesTaken = string(textTopClassesTaken);
resized_class_vector = strings;
counter = 1;
for ii = 1:length(textTopClassesTaken)
    for jj = 1:length(total_student_class_vector)
        sameBool = isequal(textTopClassesTaken(ii,1), total_student_class_vector(jj,1));
        if (sameBool == 1)
            resized_class_vector(counter, 1) = total_student_class_vector(ii,1);
            resized_class_vector(counter, 2) = total_student_class_vector(ii,2);
            counter = counter + 1;
        end
    end
end
[~,idx] = sort(resized_class_vector(:,1));
sorted_vector = resized_class_vector(idx,:);
sorted_vector = strip(sorted_vector, 'left', '0'); %removes all leading zeros of numbers

[class_matrix,remove_these_classes] = class_matrix_generator();

%%
%Since specific classes were removed from the popular class list in another
%function, we need to remove those same sections from this list of classes.
%This chunk of code will do that by determining the order of the popular
%classes using read_popular_classes() and using remove_these_classes
%generated from class_matrix_generator() to remove the classes a specified
%idecies.
popular_class_list = read_popular_classes();
remove_this_many_from_vector = 0;
for loopCount = 1:length(remove_these_classes)
   for ii = remove_these_classes(loopCount,1):(length(popular_class_list)-1)
      popular_class_list(ii,:) = popular_class_list(ii+1,:);
      
   end
   remove_this_many_from_vector = remove_this_many_from_vector + 1;
end
[popular_length,~] = size(popular_class_list);
new_length = popular_length - remove_this_many_from_vector;
popular_class_list = popular_class_list(1:new_length,:);


%%
%This will count how many total students are enrolled in each class,
%totalling each section together
[popular_class_length,~] = size(popular_class_list);
[class_vector_length,~] = size(sorted_vector);
class_enroll = zeros(popular_class_length,1);
counter = 1;
for ii = 1:popular_class_length
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

%%
%Finds the spot where the classes are scheduled by using the matrix
%generated in tn class_matrix_generator(), removes the 1 that was used as a
%placeholder for the time, then replaces it with the class totals.
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