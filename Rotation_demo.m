N_gnb = 128;
N_ue = 128;
channel = 'A';
speed = 1;
rlim = 10;
videoname = "demo.avi";

log_gnb = log2(N_gnb);
log_ue = log2(N_ue);

v = VideoWriter(videoname);
open(v);

for theta = 0:speed:360
    H = channel_matrix(N_ue,N_gnb,channel,theta);
    [~,~,id_gnb,id_ue] = Search_codebook(H,N_ue,N_gnb);
    subplot(1,2,1);
    polar(0,rlim);
    hold on;
    for j = log_gnb:-1:1
        Plot_pattern(Hier_Codebook(N_gnb,j,id_gnb(j)),1,N_gnb,1);
        hold on;
    end
    title("gNB"); 
    hold off;
    
    subplot(1,2,2);
    polar(0,rlim);
    hold on;
    for j = log_ue:-1:1
        Plot_pattern(Hier_Codebook(N_ue,j,id_ue(j)),1,N_ue,1);
        hold on;
    end
    title("UE");
    hold off;
    
    frame = getframe(gcf);
    writeVideo(v,frame);
end
close(v);