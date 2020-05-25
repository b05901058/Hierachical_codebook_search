function [dummy] = Plot_pattern(weight,size1,size2,pol)
%PLOT_PATTERN Summary of this function goes here
%   Detailed explanation goes here
%   畫出給定weight vector的beam pattern
%   weight: 給定的weight vector
%   size1: Y軸方向的antenna數
%   size2: X軸方向的antenna數
%   pol: 1 for polar coordinate; 0 for cartesian coordinate
sample = 360;    %畫圖時描點的數量
lambda = 0.001;  %波長
rfar = 10000;    %source的距離
normalize = 0;   % 1 是把最大的gain normalize成1; 0 不做

theta = 0:pi*2/sample:pi*2;
lambda = lambda / 2;
[x,y] = meshgrid((1:size2)*lambda,(1:size1)*lambda);
x = x - mean(x);
y = y - mean(y);
cartesianx = cos(theta)*rfar;
cartesiany = sin(theta)*rfar;
weight = reshape(weight,size1,size2);
gain = zeros(size(theta));
for j = 1:size1
    for k = 1:size2
        distance = sqrt( (cartesianx-x(j,k)).^2 + (cartesiany-y(j,k)).^2 );
        gain = gain + exp(i*distance*pi/lambda)*weight(j,k);
    end
end
gain = abs(gain);
if normalize
    gain = gain./max(gain);
end
if pol
    polar(theta,gain);
else
    plot(theta,gain);
end
end

