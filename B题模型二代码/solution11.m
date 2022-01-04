clc;clear
data=xlsread('附件1-处理后数据','性能数据表');
data1=data(:,[1,2]);
data2=data(:,[1,4]);
xxx=data1(1:5,1);
yyy=data1(1:5,2);
%% 在此之前，考虑线性、多项式、三角函数的关系
figure
subplot(2,2,1)
[fitresult, gof] = createFit_zhishu(xxx, yyy)
title('指数拟合')
subplot(2,2,2)
[fitresult2, gof2] = createFit_xianxing(xxx, yyy)
title('线性拟合')
subplot(2,2,3)
[fitresult3, gof3] = createFit_duoxiangshi(xxx, yyy)
title('3次多项式拟合')
subplot(2,2,4)
[fitresult4, gof4] = createFit_sanjiao(xxx, yyy)
title('三角函数拟合')
%% 探究乙醇转化率与温度的关系

TT_x=cell(21,1);
TT_y=cell(21,1);
TT_x{1}=data1(1:5,1);TT_y{1}=data1(1:5,2);
TT_x{2}=data1(6:10,1);TT_y{2}=data1(6:10,2);
TT_x{3}=data1(11:17,1);TT_y{3}=data1(11:17,2);
TT_x{4}=data1(18:23,1);TT_y{4}=data1(18:23,2);
TT_x{5}=data1(24:29,1);TT_y{5}=data1(24:29,2);
TT_x{6}=data1(30:34,1);TT_y{6}=data1(30:34,2);
TT_x{7}=data1(35:39,1);TT_y{7}=data1(35:39,2);
TT_x{8}=data1(40:44,1);TT_y{8}=data1(40:44,2);
TT_x{9}=data1(45:49,1);TT_y{9}=data1(45:49,2);
TT_x{10}=data1(50:54,1);TT_y{10}=data1(50:54,2);
TT_x{11}=data1(55:59,1);TT_y{11}=data1(55:59,2);
TT_x{12}=data1(60:64,1);TT_y{12}=data1(60:64,2);
TT_x{13}=data1(65:69,1);TT_y{13}=data1(65:69,2);
TT_x{14}=data1(70:74,1);TT_y{14}=data1(70:74,2);
TT_x{15}=data1(75:79,1);TT_y{15}=data1(75:79,2);
TT_x{16}=data1(80:84,1);TT_y{16}=data1(80:84,2);
TT_x{17}=data1(85:90,1);TT_y{17}=data1(85:90,2);
TT_x{18}=data1(91:96,1);TT_y{18}=data1(91:96,2);
TT_x{19}=data1(97:102,1);TT_y{19}=data1(97:102,2);
TT_x{20}=data1(103:108,1);TT_y{20}=data1(103:108,2);
TT_x{21}=data1(109:114,1);TT_y{21}=data1(109:114,2);
for i=1:21
     xxx=TT_x{i};
     yyy=TT_y{i};
   [fitresult, gof] = createFit(xxx, yyy)
end

%% 探究、C4 烯烃的选择性与温度的关系
TT_x2=cell(21,1);
TT_y2=cell(21,1);
TT_x2{1}=data2(1:5,1);TT_y2{1}=data2(1:5,2);
TT_x2{2}=data2(6:10,1);TT_y2{2}=data2(6:10,2);
TT_x2{3}=data2(11:17,1);TT_y2{3}=data2(11:17,2);
TT_x2{4}=data2(18:23,1);TT_y2{4}=data2(18:23,2);
TT_x2{5}=data2(24:29,1);TT_y2{5}=data2(24:29,2);
TT_x2{6}=data2(30:34,1);TT_y2{6}=data2(30:34,2);
TT_x2{7}=data2(35:39,1);TT_y2{7}=data2(35:39,2);
TT_x2{8}=data2(40:44,1);TT_y2{8}=data2(40:44,2);
TT_x2{9}=data2(45:49,1);TT_y2{9}=data2(45:49,2);
TT_x2{10}=data2(50:54,1);TT_y2{10}=data2(50:54,2);
TT_x2{11}=data2(55:59,1);TT_y2{11}=data2(55:59,2);
TT_x2{12}=data2(60:64,1);TT_y2{12}=data2(60:64,2);
TT_x2{13}=data2(65:69,1);TT_y2{13}=data2(65:69,2);
TT_x2{14}=data2(70:74,1);TT_y2{14}=data2(70:74,2);
TT_x2{15}=data2(75:79,1);TT_y2{15}=data2(75:79,2);
TT_x2{16}=data2(80:84,1);TT_y2{16}=data2(80:84,2);
TT_x2{17}=data2(85:90,1);TT_y2{17}=data2(85:90,2);
TT_x2{18}=data2(91:96,1);TT_y2{18}=data2(91:96,2);
TT_x2{19}=data2(97:102,1);TT_y2{19}=data2(97:102,2);
TT_x2{20}=data2(103:108,1);TT_y2{20}=data2(103:108,2);
TT_x2{21}=data2(109:114,1);TT_y2{21}=data2(109:114,2);

for i=1:21
     xxx2=TT_x2{i};
     yyy2=TT_y2{i};
   [fitresult, gof] = createFit2(xxx2, yyy2)
end

%% 并对附件 2 中 350 度时给定的催化剂组合在一次实验不同时间的测试结果进行分析。
data33=xlsread('附件2');
xx=data33(:,1);
figure
hold on 
for j=1:7
    yy=data33(:,j+1);
    plot(xx,yy,'+-');
end
legend('乙醇转化率(%)','乙烯选择性','C4烯烃选择性','乙醛选择性','碳数为4-12脂肪醇','甲基苯甲醛和甲基苯甲醇','其他','Location', 'best')
xlabel('温度')
ylabel('数值')
disp('自定义评价指标值如下：')
for j=1:7
    yy=data33(:,j+1);
sum((yy(2:end)-yy(1:(end-1)))./yy(1:(end-1)))
end




