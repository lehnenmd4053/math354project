function out = final_fxn(name_of_class,start_time,end_time)

filename = 'Top 73 Course List.xlsx';
[~, top_classes] = xlsread(filename);
name_of_class = cellstr(name_of_class);
foundClass = 0;
ii = 1;
while (ii<=length(top_classes)) && (foundClass==0)
    foundClass = isequal(name_of_class,top_classes(ii,2));
    ii = ii + 1;
end
if foundClass == 0
    out = 'not analyzed';
else
    
    class_scheduled_at = CompareRatios2(name_of_class,start_time,end_time);
    out = class_scheduled_at;

end
end