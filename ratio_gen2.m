function output = ratio_gen2()

filename = 'Common Course Combinations.xlsx';
[num, text] = xlsread(filename);
[column_size, row_size] = size(text);
ii = 1;
foundIt = 0;
row_name = {'Class Eau'};
while (ii <= row_size) && (foundIt == 0)   
    foundIt = isequal(row_name,text(1,ii));
    jj = ii;
   ii = ii + 1; 
end
class_column = jj;
class_names_vector = text(:,class_column);
class_names_vector = string(class_names_vector);

[~, text_2] = xlsread('Top 73 Course List.xlsx');
text_2 = text_2(:,2:2);
text_2 = string(text_2);
new_vector = strings;
counter = 1;
for ii = 1:length(text_2)
    for jj = 1:length(class_names_vector)
        sameBool = isequal(text_2(ii,1), class_names_vector(jj,1));
        if (sameBool == 1)
            new_vector(counter, 1) = text_2(ii,1);
            counter = counter + 1;
        end
    end
end

[text_2_length, ~] = size(text_2);
[new_vector_length, ~] = size(new_vector);
class_totals = zeros(text_2_length,1);

new_vector = sort(new_vector);
new_vector = cellstr(new_vector);
text_2 = cellstr(text_2);
for ii = 1:text_2_length
    counter2 = 0;
    for jj = 1:new_vector_length
       isSame = isequal(new_vector(jj,1),text_2(ii,1));
       if isSame == 1
           counter2 = counter2 + 1;
       end
    end
    class_totals(ii,1) = counter2;
end

%class_totals = num2cell(class_totals);
%class_totals(:,2) = text_2; 

popular_classes = read_popular_classes();
[popular_class_length,~] = size(popular_classes);
popular_classes = cellstr(popular_classes);
seats_available = zeros;
for ii = 1:text_2_length
    counter2 = 0;
    for jj = 1:popular_class_length
       isSame = isequal(popular_classes(jj,23),text_2(ii,1));
       if isSame == 1
           addition = str2double(popular_classes(jj,16));
           counter2 = counter2 + addition;
       end
    end
    seats_available(ii,1) = counter2;
end


for mm = 1:length(seats_available)
   if (seats_available(mm,1) > 0)
       ratio(mm,1) = class_totals(mm,1) / seats_available(mm,1);
   else
       ratio(mm,1) = 0;
   end
       
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% %graphing
% counter = 1;
% for ii = 1:20
%     if ratio(ii,1) > 1
%         graphing_numbers(counter,1) = class_totals(ii,1);
%         graphing_numbers(counter,2) = seats_available(ii,1);
%         %graphing_numbers(counter,3) = graphing_numbers(counter,1) / graphing_numbers(counter,2);
%         counter = counter + 1;
%     end
%        
% end
% hb = bar(graphing_numbers);
% %hb = scatter(linspace(1,length(graphing_numbers),length(graphing_numbers)),graphing_numbers(:,3));
% legend('Number of Students Wanting to Take Class','Number of Seats Available');
% set(gca,'Xticklabel',[]);
% title('Number of Students and Available Seats')
% % set(hb(1),'Color', [43/255 62/255 133/255]);
% % set(hb(2),'Color', [237/255 172/255 26/255]);
% set(hb(1), 'FaceColor', [43/255 62/255 133/255])
% set(hb(2), 'FaceColor', [237/255 172/255 26/255])
% % % hb(1).FaceColor = 'b';
% % % hb(2).FaceColor = 'g';



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

output = ratio;
end %function