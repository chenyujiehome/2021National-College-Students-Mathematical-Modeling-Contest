file="/Users/chen/Downloads/CUMCM2021Probelms/B/附件2.xlsx";
data=xlsread(file);
[r1_2,p1_2]=corrcoef(data(:,:));
writematrix(r1_2)
writematrix(p1_2)
[r1_22,p1_22]=partialcorr(data(:,2:8),data(:,2:8),data(:,1));
writematrix(r1_22)
writematrix(p1_22)