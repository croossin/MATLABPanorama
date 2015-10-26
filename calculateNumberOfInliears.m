function [ numberOfInliers ] = calculateNumberOfInliears(homography, p1, p2, n)
%CALCULATENUMBEROFINLIEARS Summary of this function goes here
%   Detailed explanation goes here

inlierCount = 0;

%Go through all points determing if they are an inlier or not
for i=1: n
    disp(p1);
    disp(p2);
   q = [p1(i,:),1]*homography;
   distance = getEuclideanDistance(p2(i,:), q(:,:));
   disp(distance);
end

end

