function H = calcH(p1, p2)
%
% Calculates the 3 x 3 homography matrix based on matching features points
% in two images, called image1 and image2.
% Pre-conditions:
%     `p1` is an n x 2 matrix containing n feature points, where each row
%     holds the coordinates of a feature point in image1, and
%     `p2` is an n x 2 matrix where each row holds the coordinates of a
%     corresponding point in image2.  
% Post-conditions:
%     H is the 3 x 3 homography matrix, such that 
%     p1_homogeneous = H * [p2 ones(size(p2, 1), 1)]'
%     p1_homogeneous contains the transformed homogeneous coordinates of
%     p2 from image2 to image1.

n = size(p1, 1);
if n < 4
    error('Not enough points');
end
H = zeros(3, 3);  % Homography matrix to be returned

%------------- YOUR CODE STARTS HERE -----------------
% 
% The following code computes a homography matrix using all feature points
% of p1 and p2. Modify it to compute a homography matrix using the inliers
% of p1 and p2 as determined by RANSAC.

%Create a 3x3 temporary homgraphy to store the best homography of the 100
%cycles
bestHomography = [0 0 0; 0 0 0; 0 0 0];
mostInliers = 0;

%RANSAC 100 loop
for i=1: 100
   A = zeros(4*3,9);
   b = zeros(4*3,1);
   
   %Grab four random points
   for x=1: 4
        randomNum = randi(n);
        A(3*(x-1)+1,1:3) = [p2(randomNum,:),1];
        A(3*(x-1)+2,4:6) = [p2(randomNum,:),1];
        A(3*(x-1)+3,7:9) = [p2(randomNum,:),1];
        b(3*(x-1)+1:3*(x-1)+3) = [p1(randomNum,:),1];
   end
   y = (A\b)';
   ransacHomography = [y(1:3); y(4:6); y(7:9)];
  
   %computes how many inliers there are in this temphomography
   ransacInlierCount = calculateNumberOfInliers(ransacHomography, p1, p2, n);
   
   %This homography is better than the previous best
   if(ransacInlierCount > mostInliers)   
      bestHomography = ransacHomography;
      mostInliers = ransacInlierCount;
   end
end

%Now have best homography with the 4 random points, find which of n are
%inliers
arrayOfInlierRowValues = getInlierRowValues(bestHomography, p1, p2, n);

%Use only inlier points
for i=1: length(arrayOfInlierRowValues)
     rowValue = arrayOfInlierRowValues(i);
     A(3*(x-1)+1,1:3) = [p2(rowValue,:),1];
     A(3*(x-1)+2,4:6) = [p2(rowValue,:),1];
     A(3*(x-1)+3,7:9) = [p2(rowValue,:),1];
     b(3*(x-1)+1:3*(x-1)+3) = [p1(rowValue,:),1];
end

x = (A\b)';
H = [x(1:3); x(4:6); x(7:9)];

%------------- YOUR CODE ENDS HERE -----------------
