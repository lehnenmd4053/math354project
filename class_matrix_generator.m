function output = class_matrix_generator()


%Note: The times in the cells are stored using a 0-1 time stystem making 1=12a and just after midnight
%(12:01)=~0.  So in this system, 12p(noon)=.5; 8a=.3333; etc.

%Generate the hourly numbers using this system
time_vector = -ones(1,24);
for ii = 1:24
    time_vector(1,ii) = (ii/24);
    time_vector = round(time_vector,3);
    fprintf('the time is %1.0f which is equivalent to %1.8f.\n', ii, time_vector(1,ii));
end %for

class_times = read_popular_classes();
class_times = class_times(1:341,8:9) %only saves the information from the popular classes vecotr that involves time.

%finds any missing values in the timeslots and replaces them with 0
missing_matrix = 5*ones(size(class_times));
missing_matrix = ismissing(class_times);
for kk = 1:length(missing_matrix)
    if (missing_matrix(kk,1) == 1)
        class_times(kk,1) = 0;
        class_times(kk,2) = 0;
    end
end
    
times = -ones(length(class_times), 24);
class_times = str2double(class_times);
class_times = round(class_times,3);

%puts the times into a matrix
for yy = 1:length(class_times)
for jj = 1:24
    if (class_times(yy,2) ~= time_vector(1,jj))
        times(yy,jj) = 0;
    else
        times(yy,jj) = 1;
    end %if
end %for jj
end %for yy

h = pcolor(times);
h.EdgeColor = 'none';



end %function


