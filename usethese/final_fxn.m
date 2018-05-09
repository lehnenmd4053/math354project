%This function takes a class name, start time, and end time.
%It ensures that the entered class name is on the Top 73 course list
%and lets the user decide if the class starts in the AM or PM and ends
%in the AM or PM. The code decides how many 15 minute intervals the 
%class spans over, and pulls information from CompareRatios2 to
%output the time a new section should be scheduled with the least conflicts,
%depending on other courses commonly taken together.
%
%To use inputs on final function:
%final_fxn('GEOG 178',8,4) will determine the optimal time to schedule
%Geography 178 between 8a and 4p.
%
%The class name must be capitalized and there must be a space between
%the letters and the numbers.  The range of scheduling time must be
%on the hour, so an input such as final_fxn('GEOG 178',8:30,4) will not work.

function class_scheduled_at = final_fxn(name_of_class,start_time,end_time)
%%
%Allows for user input to determine if the scheduling time is for morning
%or afternoon.
prompt = {'Is the class start time A.M.? [Y/N]: ','Is the class end time A.M.? [Y/N]: '};
title = 'AM/PM Determination';
answer = inputdlg(prompt,title);
morning_class = isequal(answer(1,1), {'Y'});

%readjusts the start time to correspond to the 15 minute intervals
if morning_class == 1
    start_time = 4*start_time;
else
    start_time = 4*start_time + 48;
end

%again adjusts the time for the appropriate intervals
morning_end = isequal(answer(2,1), {'Y'});
if morning_end == 1
    end_time = 4*end_time;
else 
    end_time = 4*end_time + 48;
end

%%
%Reads in the file that will be used to determine if the class being
%analyzed is worth analyzing
filename = 'Top 73 Course List.xlsx';
[~, top_classes] = xlsread(filename);
name_of_class = cellstr(name_of_class);
foundClass = 0;
ii = 1;

%%
%While loop checks the class entered agaisnt all of the classes on the Top
%73 course list.  If that class is not found, the function outputs 'not
%analyzed', otherwise it will proceed to run the inner functions.
while (ii<=length(top_classes)) && (foundClass==0)
    foundClass = isequal(name_of_class,top_classes(ii,2));
    ii = ii + 1;
end
if foundClass == 0
    class_scheduled_at = 'not analyzed';
else
    
    class_scheduled_at = CompareRatios2(name_of_class,start_time,end_time); %Calls CompareRatios2 and passes all of the inputs to final_fxn

end
end