N = 256;
layer = 0;

layer = 0;
num = 2^layer;
for j = 1:num
    Plot_pattern(Hier_Codebook(N,layer,j),1,N,1);
    hold on;
end