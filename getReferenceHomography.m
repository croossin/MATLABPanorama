function [returnHomography] = getReferenceHomography(H_list, count)
%GETREFERENCEHOMOGRAPHY Summary of this function goes here
%   Detailed explanation goes here

tempHomography = H_list{1};
if count == 1
   returnHomography = tempHomography;
   return
end

for i = 2: count
    tempHomography = tempHomography * H_list{i};
end
returnHomography = tempHomography;
end

