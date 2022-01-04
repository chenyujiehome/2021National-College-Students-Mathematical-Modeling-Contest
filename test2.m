file="/Users/chen/Downloads/CUMCM2021Probelms/B/附件1.xlsx";
data=xlsread(file);
row=[1 6 11 18 24 30 35 40 45 50 55 60  65 70 75 80 85 91 97 103 109 115];
data2=[data(:,1:2) data(:,4)];
rr=[];
pp=[];
ab=[];
for i=1:21
[r,p]=corrcoef(data2(row(i):row(i+1)-1,:));
aa=polyfit(data2(row(i):row(i+1)-1,1),data2(row(i):row(i+1)-1,2),1);
bb=polyfit(data2(row(i):row(i+1)-1,1),data2(row(i):row(i+1)-1,3),1);
ab=[ab;aa bb];
rr=[rr;r];
pp=[pp;p];
end
mm=[]
nn=[]
for i=1:21
    mm=[mm;rr(3*i-2,2:3)];
    nn=[nn;pp(3*i-2,2:3)];
end
writematrix(mm)
writematrix(nn)
writematrix(ab)