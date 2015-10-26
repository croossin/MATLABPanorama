function [ numberOfInliers ] = calculateNumberOfInliears(homography, p1, p2, n)
%CALCULATENUMBEROFINLIEARS Summary of this function goes here
%   Detailed explanation goes here

inlierCount = 0;

%Go through all points determing if they are an inlier or not
for i=1: n
    disp([p1(i,:),1]);
   q = homography*[p1(i,:),1];
   disp(q);
   disp(p2(i,:));
   disp(q(:,:));
   distance = getEuclideanDistance(p2(i,:), q(:,:));
   disp(distance);
   if distance > 3
      inlierCount = inlierCount + 1; 
   end
   
end

numberOfInliers = inlierCount;

end

