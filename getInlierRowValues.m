function [valueArray] = getInlierRowValues(homography, p1, p2, n)
%GETINLIERROWVALUES Summary of this function goes here
%   Detailed explanation goes here

tempArray = [];

%Go through all points determing if they are an inlier or not
for i=1: n
   p2Homogenius = [p2(i,:),1];
   q = homography*(p2Homogenius');
   distance = getEuclideanDistance(q(1:2)', p1(i,:));
   %Inlier - add to row value to tempArray
   if distance < 3
       tempArray = [tempArray; i];
   end
   
end

valueArray = tempArray;

end

