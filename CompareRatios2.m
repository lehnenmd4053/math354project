function output = CompareRatios2(class_name,time_start,time_end)

%Takes into account the number of student conflicts for students that need
%to take this course and also how many classes are already scheduled at
%that time.  Change the weight of the ratios b changing the multiplyer
%infront of ratio1 and ratio2 on lines 16 and 17.

ratio1 = weight(class_name);  %Calls weight function
ratio1 = ratio1(1,time_start:time_end);
class_schedule = testing();
ratio2 = sum(class_schedule);
ratio2 = ratio2(1,time_start:time_end);

%add in weighting for ratio1 and ratio2, needs to be adjusted to what we
%decide
ratio1_weight = 1 * ratio1;
ratio2 = 1 * ratio2;

total_ratio = ratio1_weight + ratio2;
[~,I] = min(total_ratio);
new_time_scheduled = I + time_start - 1;

hour = fix(new_time_scheduled/4);
minute = rem(new_time_scheduled,4);
if minute == 1
    minute = 15;
elseif minute == 2
    minute = 30;
elseif minute == 3
    minute = 45;
end


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


% if new_time_scheduled > 12
%     new_time_scheduled = new_time_scheduled - 13;
%     hours = new_time_scheduled / 4;
% minutes = rem(new_time_scheduled,4);
%     output = fprintf('The best time to schedule the class is %1.0f:%1.0f pm with %1.0f conflicting student schedule. \n', hours,minutes, ratio1(1,I));
%     
% else
%     hours = new_time_scheduled / 4;
% minutes = rem(new_time_scheduled,4);
%     output = fprintf('The best time to schedule the class is  %1.0f pm with %1.0f conflicting student schedule. \n', hours,minutes, ratio1(1,I));
% end


end