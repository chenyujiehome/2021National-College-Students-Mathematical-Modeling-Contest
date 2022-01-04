
%% 该代码为基于遗传算法神经网络的预测代码
% 清空环境变量
function [output_test,test_simu_1,test_simu]=yichuansuanfa_bp(input,output,inputnum,hiddennum,outputnum,nn)
%input 为数据输入  行为样本个数，列为有多少个因变量
%output一样
%inputnum,hiddennum,outputnum，分别为输入层，隐藏层，输出层节点个数
%n为前多少组数据作为训练集，那么剩下的作为测试集
% 
%% 网络结构建立
%读取数据
% load data input output
% 
% %节点个数
% inputnum=2;
% hiddennum=5;
% outputnum=1;
input_train=input(1:nn,:)';%取1到1900行的数据来训练
input_test=input(nn+1:end,:)';%取1901到2000行的数据来测试
output_train=output(1:nn,:)';
output_test=output(nn+1:end,:)';
%选连样本输入输出数据归一化
[inputn,inputps]=mapminmax(input_train);%归一化到[-1,1]之间，inputps用来作下一次同样的归一化
[outputn,outputps]=mapminmax(output_train);
%构建网络
net=newff(inputn,outputn,hiddennum);%单隐含层，5个隐含层神经元
%% 未经优化的bp算法
net.trainParam.epochs=100;
net.trainParam.lr=0.1;
net.trainParam.goal=0.00001;
%网络训练
[net,per2]=train(net,inputn,outputn);
%% BP网络预测
%数据归一化
inputn_test_1=mapminmax('apply',input_test,inputps);
an_1=sim(net,inputn_test_1);
test_simu_1=mapminmax('reverse',an_1,outputps);
error_1=test_simu_1-output_test;
% figure(2)
% plot((output_test-test_simu_1)./test_simu_1,'-*');
% title('神经网络预测误差百分比')
% figure(3)
% plot(error_1,'-*')
% title('BP网络预测误差','fontsize',12)
% ylabel('误差','fontsize',12)
% xlabel('样本','fontsize',12)
%% 遗传算法参数初始化
maxgen=20;                          %进化代数，即迭代次数
sizepop=10;                         %种群规模
pcross=0.2;                       %交叉概率选择，0和1之间
pmutation=0.1;                    %变异概率选择，0和1之间

%节点总数：输入隐含层权值、隐含阈值、隐含输出层权值、输出阈值（4个基因组成一条染色体）
numsum=inputnum*hiddennum+hiddennum+hiddennum*outputnum+outputnum;%21个，10,5,5,1

lenchrom=ones(1,numsum);%个体长度，暂时先理解为染色体长度，是1行numsum列的矩阵      
bound=[-3*ones(numsum,1) 3*ones(numsum,1)];    %是numsum行2列的串联矩阵，第1列是-3，第2列是3

%------------------------------------------------------种群初始化--------------------------------------------------------
individuals=struct('fitness',zeros(1,sizepop), 'chrom',[]);  %将种群信息定义为一个结构体：10个个体的适应度值，10条染色体编码信息
avgfitness=[];                      %每一代种群的平均适应度,一维
bestfitness=[];                     %每一代种群的最佳适应度
bestchrom=[];                       %适应度最好的染色体，储存基因信息
%初始化种群
for i=1:sizepop
    %随机产生一个种群
    individuals.chrom(i,:)=Code(lenchrom,bound);    %编码（binary（二进制）和grey的编码结果为一个实数，float的编码结果为一个实数向量）
    x=individuals.chrom(i,:);
    %计算适应度
    individuals.fitness(i)=fun(x,inputnum,hiddennum,outputnum,net,inputn,outputn);   %染色体的适应度
end

FitRecord=[];

%找最好的染色体
[bestfitness, bestindex]=min(individuals.fitness);%bestindex是最小值的索引（位置/某个个体），bestfitness的值为最小适应度值
bestchrom=individuals.chrom(bestindex,:);  %最好的染色体，从10个个体中挑选到的
avgfitness=sum(individuals.fitness)/sizepop; %染色体的平均适应度(所有个体适应度和 / 个体数)
% 记录每一代进化中最好的适应度和平均适应度
trace=[avgfitness bestfitness]; %trace矩阵，1行2列，avgfitness和bestfitness仅仅是数值
 
%% 迭代求解最佳初始阀值和权值
% 进化开始
for i=1:maxgen
    % 选择
    individuals=Select(individuals,sizepop); 
%     avgfitness=sum(individuals.fitness)/sizepop;%种群的平均适应度值
    %交叉
    individuals.chrom=Cross(pcross,lenchrom,individuals.chrom,sizepop);
    % 变异
    individuals.chrom=Mutation(pmutation,lenchrom,individuals.chrom,sizepop,i,maxgen,bound);
    
    % 计算适应度 
    for j=1:sizepop
        x=individuals.chrom(j,:); %个体信息
        individuals.fitness(j)=fun(x,inputnum,hiddennum,outputnum,net,inputn,outputn);  %计算每个个体的适应度值 
    end
    
    %找到最小和最大适应度的染色体及它们在种群中的位置
    [newbestfitness,newbestindex]=min(individuals.fitness);%最佳适应度值
    [worestfitness,worestindex]=max(individuals.fitness);
    % 最优个体更新
    if bestfitness>newbestfitness
        bestfitness=newbestfitness;
        bestchrom=individuals.chrom(newbestindex,:);
    end
    individuals.chrom(worestindex,:)=bestchrom;%取代掉最差的，相当于淘汰
    individuals.fitness(worestindex)=bestfitness;
    
    avgfitness=sum(individuals.fitness)/sizepop;
    
    trace=[trace;avgfitness bestfitness]; %记录每一代进化中最好的适应度和平均适应度
    FitRecord=[FitRecord;individuals.fitness];%记录每一代进化中种群所有个体的适应度值
end

%% 遗传算法结果分析 
figure
[r, c]=size(trace);
plot([1:r]',trace(:,2),'b--');
title(['适应度曲线  ' '终止代数＝' num2str(maxgen)]);
xlabel('进化代数');ylabel('适应度');
legend('平均适应度','最佳适应度');
disp('适应度                   变量');

%% 把最优初始阀值权值赋予网络预测
% %用遗传算法优化的BP网络进行值预测
w1=x(1:inputnum*hiddennum);
B1=x(inputnum*hiddennum+1:inputnum*hiddennum+hiddennum);
w2=x(inputnum*hiddennum+hiddennum+1:inputnum*hiddennum+hiddennum+hiddennum*outputnum);
B2=x(inputnum*hiddennum+hiddennum+hiddennum*outputnum+1:inputnum*hiddennum+hiddennum+hiddennum*outputnum+outputnum);

net.iw{1,1}=reshape(w1,hiddennum,inputnum);
net.lw{2,1}=reshape(w2,outputnum,hiddennum);
net.b{1}=reshape(B1,hiddennum,1);
net.b{2}=reshape(B2,outputnum,1);

%% BP网络训练
%网络进化参数
net.trainParam.epochs=100;
net.trainParam.lr=0.1;
net.trainParam.goal=0.00001;

%网络训练
[net,per2]=train(net,inputn,outputn);

%% BP网络预测
%数据归一化
inputn_test=mapminmax('apply',input_test,inputps);
an=sim(net,inputn_test);
test_simu=mapminmax('reverse',an,outputps);
error=test_simu-output_test;

figure
plot((output_test-test_simu_1)./test_simu_1,'-*');
hold on
plot((output_test-test_simu)./test_simu,'-*');
title('神经网络预测误差百分比')
legend('优化后','优化前')

figure
plot(error_1,'-*')
hold on
plot(error,'-*')
legend('优化前','优化后')
title('BP网络预测误差','fontsize',12)
ylabel('误差','fontsize',12)
xlabel('样本','fontsize',12)

%测试集预测效果
figure
plot(output_test,'b-o')
hold on
plot(test_simu_1,'r-*')
plot(test_simu,'k-.')
title('测试集预测效果','fontsize',12)
ylabel('误差','fontsize',12)
xlabel('样本','fontsize',12)
legend('测试集数据','优化前数据','优化后数据')
save('net_11','net')
end




