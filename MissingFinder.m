%finds any missing values in the timeslots and replaces them with 0
%Some popular classes are independent studies/capstones with no times
%
%The input to this is a matrix that needs all classes removed that are not
%in the top 74 courses.

function [resized_matrix,class_removed_location] = MissingFinder(matrixtoresize)
%%
%Locates all locations where there are missing values and replaces them
%with zeros.
missing_matrix = ismissing(matrixtoresize);
for kk = 1:length(missing_matrix)
    if (missing_matrix(kk,1) == 1)
        matrixtoresize(kk,1) = 0;
        matrixtoresize(kk,2) = 0;
    end
end
%%
%omit_this_spot initializes a location to store the booleans that determine
%the classes that have missing information (stored in class_times as 0's)
omit_this_spot = -ones(length(matrixtoresize),1);
classes_removed = 0; %keeps track of number of classes removed
for uu = 1:length(matrixtoresize)
    omit_this_spot(uu,1) = isequal(matrixtoresize(uu,1),"0");
    if omit_this_spot(uu,1) == 1
        classes_removed = classes_removed + 1;
        class_removed_locations(classes_removed,1) = uu;
        for yy = uu:(length(matrixtoresize)-1)
            matrixtoresize(yy,1) = matrixtoresize(yy+1,1); %Reindexes the entire
                                                     %by removing the row
                                                     %with missing
                                                     %information
            matrixtoresize(yy,2) = matrixtoresize(yy+1,2);
        end 
    end   
end %while uu
[class_times_length, ~] = size(matrixtoresize);
new_class_times_length = class_times_length - classes_removed; %duplicates
%are created when we reindex at the end of the matrix, this line determines
%what the new size of the matrix should be.
matrixtoresize = matrixtoresize(1:new_class_times_length,:);

resized_matrix = matrixtoresize;
class_removed_location = class_removed_locations;

end