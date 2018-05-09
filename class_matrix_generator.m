%CLASS_MATRIX_GENERATOR will generate a matrix of 1s and 0s based on the 
%times that a class is scheduled.  The rows represent each section of the 
%popular classes and each column represents the time the class takes place.
%Time is divided into 15 minute intervals with the first column 
%representing 12:00am.  remove_these_classes is the number of classes that 
%contain missing missing information and their index. This function will 
%also output a vector that contains class indicies that need to be removed 
%in other functions.

function [all_class_times_matrix,remove_these_classes] = class_matrix_generator()

%Note: The times in the cells are stored using a 0-1 time stystem making 1=12a and just after midnight
%(12:01)=~0.  So in this system, 12p(noon)=.5; 8a=.3333; etc.

%Generate the hourly numbers using this system
time_vector = -ones(1,96);
for ii = 1:96
    time_vector(1,ii) = (ii/96); %Creates times in terms of the number system used
    time_vector = round(time_vector,2); %rounds to 2 decimal places, makes it easier to identify class start/stop times

end %for

classes_occur_at_these_time = read_popular_classes(); %calls read_popular_classes function to populate class_times matrix
classes_occur_at_these_time = classes_occur_at_these_time(1:341,8:9); %only saves the information from the popular classes matrix that involves time (rows 8 and 9).

[classes_occur_at_these_time,remove_these_classes] = MissingFinder(classes_occur_at_these_time);

%%
%Create a matrix that has 24 columns that represent the 24 hours in a day,
%each row is a clas
all_class_times_matrix = -ones(length(classes_occur_at_these_time), 96);

%When the class_times matrix is populated, its elements consist of strings,
%need to convert them to numbers
classes_occur_at_these_time = str2double(classes_occur_at_these_time);
classes_occur_at_these_time = round(classes_occur_at_these_time,2); %Rounds the numbers in the class_times matrix so that they can be compared
%to the values saved in time_vector

%%
%puts the times of each class into a matrix, 1's represent a class being
%scheduled at that time; 0's mean no class is scheduled
for yy = 1:length(classes_occur_at_these_time)
    jj = 1; %determines the spot Left to Right in the times matrix
    while jj <= 96
        if classes_occur_at_these_time(yy,2) ~= time_vector(1,jj)
            all_class_times_matrix(yy,jj) = 0; %not the start time of class
            jj = jj + 1;
        else
            %start time was found
            classEnd = classes_occur_at_these_time(yy,1); %end time of class
            for tt = 1:length(time_vector)
                endTimeFound = isequal(classEnd,time_vector(1,tt));  %checks what the corresponding end time's index is
                if endTimeFound == 1
                    locationFound = tt; %sets the found index location
                else
                    %This section deals with the rounding issues associated
                    %with finding the end time.  Some of the end times are
                    %rounded to a point where they are not listed in
                    %time_vector, this will find the value the end time
                    %falls in between.
                    for counter = 1:length(time_vector)
                       if (classEnd > time_vector(1,counter)) && (classEnd < time_vector(1,counter+1))
                           locationFound = counter;
                       end
                    end
                end
                
            end
            startingPoint = jj;
            endingPoint = locationFound;
            all_class_times_matrix(yy,startingPoint:endingPoint) = 1; %puts a 1 in the time matrix for every timeslot the class takes place
            jj = endingPoint + 1; %jumps past the class time to set the rest of that row to zeros
        end
    end
end

end %function



