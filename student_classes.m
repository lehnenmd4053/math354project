function student_id_numbers = student_classes()

filename = 'Common Course Combinations.xlsx';
[~,text] = xlsread(filename);

student_id_numbers = strings(length(text),3)
student_id_numbers(:,1) = text(:,11);
student_id_numbers(:,2) = text(:,12);
student_id_numbers(:,3) = text(:,15);

end