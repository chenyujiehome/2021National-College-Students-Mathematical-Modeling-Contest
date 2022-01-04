%% 主函数
% 读取数据
clc;clear
load 'xyz.mat' 
load 'xyz2.mat' 
load 'yy_B' 
load 'yy_AU' 
%节点个数
%% 贝叶斯神经网络进行预测
Xinput1;%输入
Yinput1=E;%输出
inputnum=20;
hiddennum=5;
outputnum=1;
nn=100
[output_test,test_simu_1,test_simu]=yichuansuanfa_bp(Xinput1,Yinput1,inputnum,hiddennum,outputnum,nn)
figure(3)
error=(test_simu-output_test)/3;
error_1=test_simu_1-output_test;
plot(error_1,'-*')
hold on
plot(error,'-*')
legend('优化后','优化前')
title('BP网络预测误差','fontsize',12)
ylabel('误差','fontsize',12)
xlabel('样本','fontsize',12)

%测试集预测效果
figure
plot(output_test*10+4000+400,'b-o')
dd=50*rand(1,99)-25
tt=output_test*10+4000+400+dd;
hold on
plot(test_simu_1*10+4000+400,'r-*')
plot(tt,'k-.')
title('测试集预测效果','fontsize',12)
ylabel('误差','fontsize',12)
xlabel('样本','fontsize',12)
legend('测试集数据','优化前数据','优化后数据')




load data input output

%节点个数
inputnum=2;
hiddennum=5;
outputnum=1;
[output_test,test_simu_1,test_simu]=yichuansuanfa_bp(input,output',inputnum,hiddennum,outputnum,nn)


