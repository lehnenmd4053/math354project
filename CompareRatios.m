function output = CompareRatios(class_name,time_start,time_end)

ratio1 = weight(class_name);
ratio1 = ratio1(1,time_start:time_end);
%ratio2 = ratio_gen2();

[~,I] = min(ratio1);
new_time_scheduled = I + time_start;


if new_time_scheduled > 12
    new_time_scheduled = new_time_scheduled - 13;
    output = fprintf('The best time to schedule the class is %1.0f pm with %1.0f conflicting student schedule. \n', new_time_scheduled, ratio1(1,I));
    
else
    output = fprintf('The best time to schedule the class is  %1.0f pm with %1.0f conflicting student schedule. \n', new_time_scheduled, ratio1(1,I));
end


end