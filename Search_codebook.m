function [AWV_gnb,AWV_ue,id_gnb,id_ue] = Search_codebook(H,N_ue,N_gnb)
%SEARCH_CODEBOOK Summary of this function goes here
%   Detailed explanation goes here
%   用Hierachical search找出能最大化gain的codeword pair
%   AWV_gnb: gNB的codeword(weight vector)
%   AWV_ue: UE的codeword(weight vector)
%   id_gnb: gNB search的過程中的codeword index
%   id_ue: UE search的過程中的codeword index
%   H: channel matrix
%   N_ue: UE的antenna數量
%   N_gnb: gNB的antenna數量

    log_gnb = log2(N_gnb);
    log_ue = log2(N_ue);
    iteration = max(log_gnb,log_ue);
    AWV_gnb = Hier_Codebook(N_gnb,0,1);
    AWV_ue = Hier_Codebook(N_ue,0,1);
    idx_gnb = 1;
    idx_ue = 1;
    id_gnb = [];
    id_ue = [];
    for j = 1:iteration
        if log_gnb >= j
            % fix ue, find gnb
            A = Hier_Codebook(N_gnb,j,idx_gnb*2-1);
            B = Hier_Codebook(N_gnb,j,idx_gnb*2);
            if abs(AWV_ue*H*A') > abs(AWV_ue*H*B')
                AWV_gnb = A;
                idx_gnb = idx_gnb*2-1;
            else
                AWV_gnb = B;
                idx_gnb = idx_gnb*2;
            end
            id_gnb = [id_gnb,idx_gnb];
        end
        if log_ue >= j
            % fix gnb, find ue
            A = Hier_Codebook(N_ue,j,idx_ue*2-1);
            B = Hier_Codebook(N_ue,j,idx_ue*2);
            if abs(A*H*AWV_gnb') > abs(B*H*AWV_gnb')
                AWV_ue = A;
                idx_ue = idx_ue*2-1;
            else
                AWV_ue = B;
                idx_ue = idx_ue*2;
            end
            id_ue = [id_ue,idx_ue];
        end
        
    end
end

