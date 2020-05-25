N = 64;
mode = 1; % 1 for polar coordinate; 0 for cartesian coordinate

H = hadamard(N);
F = dftmtx(N);

subplot(1,2,1);
for j = 1:N
    Plot_pattern(F(:,j),1,N,mode);
    hold on;
end
title("Fourier");

subplot(1,2,2);
for j = 1:N
    Plot_pattern(H(:,j),1,N,mode);
    hold on;
end
title("Hadamard");
