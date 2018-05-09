%Takes into account the number of student conflicts for students that need
%to take this course and also how many classes are already scheduled at
%that time.  Change the weight of the ratios by changing the multiplyer
%in front of ratio1 and ratio2 on lines 16 and 17.
%
%To use this funciton, input using the following format:
%
%CompareRatios2('GEOG 178',8,4)
%This will change the class matrix that is generated to only determine the
%optimal time between 8a and 4p.

function output = CompareRatios2(class_name,time_start,time_end)

conflict_weight = weight(class_name);  %Calls weight function
conflict_weight = conflict_weight(1,time_start:time_end);
class_schedule = class_matrix_generator();
schedule_weight = sum(class_schedule);
schedule_weight = schedule_weight(1,time_start:time_end);

%%
%The conflict weight is how much the scheduler wants the total number of
%student conflicts to determine when the class should be scheduled.  the
%schedule weight takes into account how many classes are already scheduled
%at that time, if the scheduler wants to schedule the class at a less busy
%time, increase the weight of line 21 by changing the multiplyer.
conflict_weight = 1 * conflict_weight;
schedule_weight = 1 * schedule_weight;

%%
%This section identifies the index of the smallest value.  This corresponds
%to the smallest number of student conflict which in return is the optimal
%time to schedule the section.
total_ratio = conflict_weight + schedule_weight;
[~,I] = min(total_ratio);
new_time_scheduled = I + time_start - 1;

%%
%Determines the actual hour and minute division of the newly scheduled time.
%This is simply used to make the output time more readable to the user.
hour = fix(new_time_scheduled/4);
minute = rem(new_time_scheduled,4);
if minute == 1
    minute = 15;
elseif minute == 2
    minute = 30;
elseif minute == 3
    minute = 45;
end

%%
%This gives the correct format of the time. ie: if the class is after noon,
%this part will determine that and will add in a.m. or p.m. respectively.
if hour > 12
    hour = hour - 12;
    output = fprintf('The best time to schedule the class is %1.0f:%1.0fpm with a %1.0f conflicting student schedules. \n',hour,minute,total_ratio(1,I));
else
    if hour == 12
        output = fprintf('The best time to schedule the class is %1.0f:%1.0fpm with a %1.0f conflicting student schedules. \n',hour,minute,total_ratio(1,I));
    else
         output = fprintf('The best time to schedule the class is %1.0f:%1.0fam with a %1.0f conflicting student schedules. \n',hour,minute,total_ratio(1,I));
    end
end

end