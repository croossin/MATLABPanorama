function [ numberOfInliers ] = calculateNumberOfInliers(homography, p1, p2, n)
%# of inliers in homography
%   Detailed explanation goes here

inlierCount = 0;

%Go through all points determing if they are an inlier or not
for i=1: n
   p2homogeneous = [p2(i,:),1];
   q = homography*(p2homogeneous');
   distance = getEuclideanDistance(q(1:2)', p1(i,:));
   %Inlier - increase count
   if distance < 3
      inlierCount = inlierCount + 1; 
   end
end

numberOfInliers = inlierCount;

end

