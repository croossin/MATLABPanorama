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

%RANSAC 100 loop
for i=1: 100
   A = zeros(n*3,9);
   b = zeros(n*3,1);
   
   %Grab four random points
   for x=1: 4
        random = randi([1 n],1,1);
        A(3*(x-1)+1,1:3) = [p2(random,:),1];
        A(3*(x-1)+2,4:6) = [p2(random,:),1];
        A(3*(x-1)+3,7:9) = [p2(random,:),1];
        b(3*(x-1)+1:3*(i-1)+3) = [p1(random,:),1];
   end
   x = (A\b);
   H = [x(1:3); x(4:6); x(7:9)];
   
   %Check homography
end


A = zeros(n*3,9);
b = zeros(n*3,1);
for i=1:n
    A(3*(i-1)+1,1:3) = [p2(i,:),1];
    A(3*(i-1)+2,4:6) = [p2(i,:),1];
    A(3*(i-1)+3,7:9) = [p2(i,:),1];
    b(3*(i-1)+1:3*(i-1)+3) = [p1(i,:),1];
end
x = (A\b)';
H = [x(1:3); x(4:6); x(7:9)];

%------------- YOUR CODE ENDS HERE -----------------
