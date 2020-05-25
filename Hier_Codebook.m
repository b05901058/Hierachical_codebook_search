function [AWV] = Hier_Codebook(N,layer,idx)
%CODEBOOK Summary of this function goes here
%   Detailed explanation goes here
%   給出Hierachical codebook的weight vector
%   AWV: weight vector
%   N: antenna的數量
%   layer: codebook的layer
%   idx: 特定layer中，codeword的index


logN = log2(N);
l = logN - layer;
M = 2^floor((l+1)/2); % number of subarray
Ns = N/M; % number of antenna in a subarray
if mod(l,2)
    Na = M/2;
else
    Na = M;
end
x = (0:(Ns-1))'*(-1+(1:2:(2*Na))/Ns);
y = (1:Na)*(Ns-1)/Ns;
x = (x'-y')';
AWV = sqrt(1/Ns)*[exp(x*i*pi), zeros(Ns,(M-Na))];
AWV = reshape(AWV,1,N);
rotate = 0:(N-1);
rotate = rotate * 2*(idx-1)/(2^layer);
AWV = AWV.*exp(rotate*i*pi);
end

