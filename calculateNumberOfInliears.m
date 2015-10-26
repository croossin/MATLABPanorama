function [ numberOfInliers ] = calculateNumberOfInliears(homography, p1, p2, n)
%CALCULATENUMBEROFINLIEARS Summary of this function goes here
%   Detailed explanation goes here

inlierCount = 0;

%Go through all points determing if they are an inlier or not
for i=1: n
   p1Homogenius = [p1(i,:),1];
   q = homography*(p1Homogenius');
   distance = getEuclideanDistance(q(1:2)', p2(i,:));
   disp(distance);
   if distance < 3
      inlierCount = inlierCount + 1; 
   end
   
end

numberOfInliers = inlierCount;

end

