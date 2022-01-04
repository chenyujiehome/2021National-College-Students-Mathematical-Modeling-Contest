%% 2021年高教社别B题问题1
% 第1步：对附件1的数据进行处理，将催化剂组合与温度等自变量使用数字表示，导入Matlab。
% 第2步：一共21种催化剂组合，我们针对每一种催化剂组合分别研究温度对乙醇转化率、C4 烯烃的选择性的影响，
% 第3步：对附件2的数据进行分析，发现再350度时，随着反应的进行，乙醇转化率逐渐下降，而对C4 烯烃的选择性影响不大。

clc,clear
%% 加载数据、输入参数
load('data_of_202199B.mat')

% 附件1 的数据列标题
% 1 序号
% 2 催化剂组合编号
% 3 装料方式
% 4 Co/SiO2含量
% 5 Co负载量
% 6 HAP含量
% 7 石英砂含量
% 8 Co/SiO2和HAP装料比
% 9 乙醇浓度
% 10 温度
% 11 乙醇转化率(%)
% 12 乙烯选择性(%)
% 13 C4烯烃选择性(%)
% 14 乙醛选择性(%)
% 15 碳数为4-12脂肪醇选择性(%)
% 16 甲基苯甲醛和甲基苯甲醇选择性(%)
% 17 其他生成物的选择性(%)
% 18 C4烯烃收率

% 附件2的数据列标题
% 1 时间(min)
% 2 乙醇转化率(%)
% 3 C4烯烃选择性
% 4 C4烯烃收率

%% 第一步
% 一共21种催化剂组合，我们针对每一种催化剂组合分别研究温度T对乙醇转化率EC(Ethanol conversion)、C4烯烃的选择性COS(C4 olefin selectivity)的影响

for i=1:21
    T{i}=fujian1(fujian1(:,2)==i,10);
    EC{i}=fujian1(fujian1(:,2)==i,11);
    COS{i}=fujian1(fujian1(:,2)==i,13);
    
    %% 回归分析,确定回归类型，leixing=1线性回归，leixing=2二次回归
    
    leixing=1; 
    a1=polyfit(T{i},EC{i},leixing);
    b1=polyfit(T{i},COS{i},leixing);
    leixing=2; 
    a2=polyfit(T{i},EC{i},leixing);
    b2=polyfit(T{i},COS{i},leixing);
    RelationOfTAndEC1{i}=a1;
    RelationOfTAndCOS1{i}=b1;
    RelationOfTAndEC2{i}=a2;
    RelationOfTAndCOS2{i}=b2;
    
    ti=250:5:400;
    
    yEC1=polyval(a1,ti);
    yCOS1=polyval(b1,ti);
    yEC2=polyval(a2,ti);
    yCOS2=polyval(b2,ti);
    
    % 线性回归绘图
    Figure1=figure(1);
    yyaxis left
    plot(T{i},EC{i},'linestyle','-','marker','o','color','b');
    hold on
    plot(ti,yEC1,'linestyle','-.','marker','*','color','c');
    axis([250 400,0,100])
    set(gca,'YTick',[0:10:100]);
    xlabel('温度T(℃)')
    ylabel('乙醇转化率(%)')
    
    yyaxis right
    plot(T{i},COS{i},'linestyle','-','marker','+','color','r');
    hold on
    plot(ti,yCOS1,'linestyle','--','marker','*','color','g');
    axis([250 400,0,100])
    set(gca,'YTick',[0:10:100]);
    ylabel('C4烯烃的选择性(%)')
    
    
    title(['第',num2str(i),'种催化剂组合条件下温度对乙醇转化率与C4烯烃的选择性的线性回归']) % 添加标题
    legend('乙醇转化率','C4烯烃的选择性') %添加图例
    
    % 新建文件夹并保存结果
    folder = '..\cal202199B\问题1第1小问线性回归';
    if ~exist(folder,'dir')
        mkdir(folder)
    end
    filename=['.\问题1第1小问线性回归\第',num2str(i),'种催化剂组合条件下温度对乙醇转化率与C4烯烃的选择性的线性回归.png'];
    saveas(gcf,filename)
    
    close(Figure1);
    
    % 二次回归绘图
    Figure2=figure(1);
    yyaxis left
    plot(T{i},EC{i},'linestyle','-','marker','o','color','b');
    hold on
    plot(ti,yEC2,'linestyle','-.','marker','*','color','c');
    axis([250 400,0,100])
    set(gca,'YTick',[0:10:100]);
    xlabel('温度T(℃)')
    ylabel('乙醇转化率(%)')
    
    yyaxis right
    plot(T{i},COS{i},'linestyle','-','marker','+','color','r');
    hold on
    plot(ti,yCOS2,'linestyle','--','marker','*','color','g');
    axis([250 400,0,100])
    set(gca,'YTick',[0:10:100]);
    ylabel('C4烯烃的选择性(%)')
    
    
    title(['第',num2str(i),'种催化剂组合条件下温度对乙醇转化率与C4烯烃的选择性的二次回归']) % 添加标题
    legend('乙醇转化率','C4烯烃的选择性') %添加图例
    
    % 新建文件夹并保存结果
    folder = '..\cal202199B\问题1第1小问二次回归';
    if ~exist(folder,'dir')
        mkdir(folder)
    end
    filename=['.\问题1第1小问二次回归\第',num2str(i),'种催化剂组合条件下温度对乙醇转化率与C4烯烃的选择性的二次回归.png'];
    saveas(gcf,filename)
    
    close(Figure2);
    %     %%单因素方差分析
    %     A=[T{i},EC{i},COS{i}];
    %     [p, anovatab, stats]=anova1(A);
    %     fa=finv(0.95, anovatab {2, 3},anovatab {3,3}); %计算fa
    %     F=anovatab{2,5}; %F值
    %     if p<=0.01 && F>fa
    %         disp ('非常显著')
    %     elseif p<=0.05 && F>fa
    %         disp('显著')
    %     else
    %         disp('不显著')
    %     end

end

%% 第二步
% 对附件2的数据进行分析，发现在350度时，随着反应的进行，乙醇转化率逐渐下降，而对C4烯烃的选择性影响不大。
Time=fujian2(:,1);
    EC=fujian2(:,2);
    COS=fujian2(:,3);
    
%% 回归分析,确定回归类型，leixing=1线性回归，leixing=2二次回归
    leixing=1; 
    TimeEC1=polyfit(Time,EC,leixing);
    TimeCOS1=polyfit(Time,COS,leixing);
    leixing=2; 
    TimeEC2=polyfit(Time,EC,leixing);
    TimeCOS2=polyfit(Time,COS,leixing);
    
    time=0:10:280;
    
    yEC1=polyval(TimeEC1,time);
    yCOS1=polyval(TimeCOS1,time);
    yEC2=polyval(TimeEC2,time);
    yCOS2=polyval(TimeCOS2,time);
    
    % 线性回归绘图
    Figure1=figure(1);
    yyaxis left
    plot(Time,EC,'linestyle','-','marker','o','color','b');
    hold on
    plot(time,yEC1,'linestyle','-.','marker','*','color','c');
    axis([0 280,0,100])
    set(gca,'YTick',[0:10:100]);
    xlabel('时间(min）)')
    ylabel('乙醇转化率(%)')
    
    yyaxis right
    plot(Time,COS,'linestyle','-','marker','+','color','r');
    hold on
    plot(time,yCOS1,'linestyle','--','marker','*','color','g');
    axis([0 280,0,100])
    set(gca,'YTick',[0:10:100]);
    ylabel('C4烯烃的选择性(%)')
    
    
    title(['350度条件下乙醇转化率与C4烯烃的选择性随时间变化的线性回归']) % 添加标题
    legend('乙醇转化率','C4烯烃的选择性') %添加图例
    
    % 新建文件夹并保存结果
    folder = '..\cal202199B\问题1第2小问线性回归';
    if ~exist(folder,'dir')
        mkdir(folder)
    end
    filename=['.\问题1第2小问线性回归\350度条件下乙醇转化率与C4烯烃的选择性随时间变化的线性回归.png'];
    saveas(gcf,filename)
    
    close(Figure1);
    
    % 二次回归绘图
    Figure2=figure(1);
    yyaxis left
    plot(Time,EC,'linestyle','-','marker','o','color','b');
    hold on
    plot(time,yEC2,'linestyle','-.','marker','*','color','c');
    axis([0 280,0,100])
    set(gca,'YTick',[0:10:100]);
    xlabel('时间（min）)')
    ylabel('乙醇转化率(%)')
    
    yyaxis right
    plot(Time,COS,'linestyle','-','marker','+','color','r');
    hold on
    plot(time,yCOS2,'linestyle','--','marker','*','color','g');
    axis([0 280,0,100])
    set(gca,'YTick',[0:10:100]);
    ylabel('C4烯烃的选择性(%)')
    
    
    title(['350度条件下乙醇转化率与C4烯烃的选择性随时间变化的线性回归的二次回归']) % 添加标题
    legend('乙醇转化率','C4烯烃的选择性') %添加图例
    
    % 新建文件夹并保存结果
    folder = '..\cal202199B\问题1第2小问二次回归';
    if ~exist(folder,'dir')
        mkdir(folder)
    end
    filename=['.\问题1第2小问二次回归\350度条件下乙醇转化率与C4烯烃的选择性随时间变化的线性回归的二次回归.png'];
    saveas(gcf,filename)

%% 保存数据
save ques1.mat RelationOfTAndEC1 RelationOfTAndCOS1 RelationOfTAndEC2 RelationOfTAndCOS2 TimeEC1 TimeCOS1 TimeEC2 TimeCOS2



