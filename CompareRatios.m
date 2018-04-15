function output = CompareRatios(time_start,time_end)

class_matrix = class_matrix_generator();
ratio1 = sum(class_matrix)
ratio1 = ratio1(1,time_start:time_end)
%ratio2 = ratio_gen2();

[~,I] = min(ratio1);
new_time_scheduled = I + time_start;


if new_time_scheduled > 12
    new_time_scheduled = new_time_scheduled - 12;
    output = fprintf('The best time to schedule the class is %1.0f pm.\n', new_time_scheduled);
else
    output = fprintf('The best time to schedule the class is %1.0f. am\n', new_time_scheduled);
end


end