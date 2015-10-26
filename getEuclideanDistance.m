function [ distance ] = getEuclideanDistance(p1, p2)
%GETEUCLIDEANDISTANCE Summary of this function goes here
%   Detailed explanation goes here

    X = [p1(1,:),p1(:,1);p2(1,:),p2(:,1)];
    distance = pdist(X, 'euclidean');

end

