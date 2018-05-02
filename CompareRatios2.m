function output = CompareRatios2(class_name,time_start,time_end)

ratio1 = weight(class_name);
ratio1 = ratio1(1,time_start:time_end);
class_schedule = class_matrix_generator();
ratio2 = sum(class_schedule);
ratio2 = ratio2(1,time_start:time_end);

%add in weighting for ratio1 and ratio2, needs to be adjusted to what we
%decide
ratio1_weight = 2 * ratio1;
ratio2 = 1 * ratio2;

total_ratio = ratio1_weight + ratio2;
[~,I] = min(total_ratio);
new_time_scheduled = I + time_start;



if new_time_scheduled > 12
    new_time_scheduled = new_time_scheduled - 13;
    output = fprintf('The best time to schedule the class is %1.0f pm with %1.0f conflicting student schedule. \n', new_time_scheduled, ratio1(1,I));
    
else
    output = fprintf('The best time to schedule the class is  %1.0f pm with %1.0f conflicting student schedule. \n', new_time_scheduled, ratio1(1,I));
end


end