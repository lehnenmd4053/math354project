function output = class_matrix_generator()


%Note: The times in the cells are stored using a 0-1 time stystem making 1=12a and just after midnight
%(12:01)=~0.  So in this system, 12p(noon)=.5; 8a=.3333; etc.

%Generate the hourly numbers using this system
time_vector = -ones(1,24);
for ii = 1:24
    time_vector(1,ii) = (ii/24); %Creates times in terms of the number system used
    time_vector = round(time_vector,3);
    %fprintf('the time is %1.0f which is equivalent to %1.8f.\n', ii, time_vector(1,ii)); %displays times
end %for

class_times = read_popular_classes(); %calls read_popular_classes function to populate class_times matrix
class_times = class_times(1:341,8:9); %only saves the information from the popular classes matrix that involves time (rows 8 and 9).

%finds any missing values in the timeslots and replaces them with 0
%Some popular classes are independent studies/capstones with no times
missing_matrix = ismissing(class_times);
for kk = 1:length(missing_matrix)
    if (missing_matrix(kk,1) == 1)
        class_times(kk,1) = 0;
        class_times(kk,2) = 0;
    end
end

%Create a matrix that has 24 columns that represent the 24 hours in a day,
%each row is a clas
times = -ones(length(class_times), 24);

%When the class_times matrix is populated, its elements consist of strings,
%need to convert them to numbers
class_times = str2double(class_times);
class_times = round(class_times,3); %Rounds the numbers in the class_times matrix so that they can be compared
%to the values saved in time_vector

%puts the times into a matrix
for yy = 1:length(class_times) %runs through all classes
for jj = 1:24
    if (class_times(yy,2) ~= time_vector(1,jj)) %checks the start time of the class
        times(yy,jj) = 0;
    else
        times(yy,jj) = 1;
    end %if
end %for jj
end %for yy

%%%%%%%%%%%%%%%%%%%%%%


%This is the Graphing section of Code, can be omitted and run properly



% h = pcolor(times);
% h.EdgeColor = 'none'; %outputs a pictoral representation
% colormap([43/255 62/255 133/255; 237/255 172/255 26/255]);
% 
% xlabel('Time of Class');
% ylabel('Class');




%%%%%%%%%%%%%%%%%%%%%%%

output= times;


end %function


