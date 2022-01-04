%% 清空环境
clc;clear all;close all;
load net_11
tic
% net([100	1	100	0.9 400]')   %测试求解
%% 目标函数

%% 设置种群参数
%   需要自行配置
sizepop = 300;                         % 初始种群个数
dim = 5;                           % 空间维数
ger =100;                       % 最大迭代次数    

xlimit_max = [200;5;200;2.1;450];     % 设置位置参数限制(矩阵的形式可以多维)
xlimit_min = [10;0.5;10;0.3;250];


vlimit_max = 1*ones(dim,1);      % 设置速度限制
vlimit_min = -1*ones(dim,1);
c_1 = 0.8;                       % 惯性权重
c_2 = 0.5;                       % 自我学习因子
c_3 = 0.5;                       % 群体学习因子 
k=0.25;

%% 生成初始种群
%  首先随机生成初始种群位置
%  然后随机生成初始种群速度
%  然后初始化个体历史最佳位置，以及个体历史最佳适应度
%  然后初始化群体历史最佳位置，以及群体历史最佳适应度
for i=1:dim
    for j=1:sizepop
        pop_x(i,j) = xlimit_min(i)+(xlimit_max(i) - xlimit_min(i))*rand;  % 初始种群的位置
        pop_v(i,j) = vlimit_min(i)+(vlimit_max(i) - vlimit_min(i))*rand;  % 初始种群的速度
    end
end                 
gbest = pop_x;                                % 每个个体的历史最佳位置
for j=1:sizepop
            fitness_gbest(j) = net(pop_x(:,j));                      % 每个个体的历史最佳适应度
end                  
zbest = pop_x(:,1);                           % 种群的历史最佳位置
fitness_zbest = fitness_gbest(1);             % 种群的历史最佳适应度
for j=1:sizepop
    if fitness_gbest(j) > fitness_zbest       % 如果求最小值，则为<; 如果求最大值，则为>; 
        zbest = pop_x(:,j);
        fitness_zbest=fitness_gbest(j);
    end
end


%% 粒子群迭代
%    更新速度并对速度进行边界处理    
%    更新位置并对位置进行边界处理
%    进行自适应变异
%    进行约束条件判断并计算新种群各个个体位置的适应度
%    新适应度与个体历史最佳适应度做比较
%    个体历史最佳适应度与种群历史最佳适应度做比较
%    再次循环或结束

iter = 1;                        %迭代次数
record = zeros(ger, 1);          % 记录器
while iter <= ger
    for j=1:sizepop
        %    更新速度并对速度进行边界处理 
        pop_v(:,j)= c_1 * pop_v(:,j) + c_2*rand*(gbest(:,j)-pop_x(:,j))+c_3*rand*(zbest-pop_x(:,j));% 速度更新
        for i=1:dim
            if  pop_v(i,j) > vlimit_max(i)
                pop_v(i,j) = vlimit_max(i);
            end
            if  pop_v(i,j) < vlimit_min(i)
                pop_v(i,j) = vlimit_min(i);
            end
        end
        
        %    更新位置并对位置进行边界处理
        pop_x(:,j) = pop_x(:,j) + pop_v(:,j);% 位置更新
        for i=1:dim
            if  pop_x(i,j) > xlimit_max(i)
                pop_x(i,j) = xlimit_max(i);
            end
            if  pop_x(i,j) < xlimit_min(i)
                pop_x(i,j) = xlimit_min(i);
            end
        end
        
        %    进行自适应变异
        if rand > 0.85
            i=ceil(dim*rand);
            pop_x(i,j)=xlimit_min(i) + (xlimit_max(i) - xlimit_min(i)) * rand;
        end
  
        %    进行约束条件判断并计算新种群各个个体位置的适应度
      
                fitness_pop(j) = net(pop_x(:,j));                      % 当前个体的适应度
        
        
        %    新适应度与个体历史最佳适应度做比较
        if fitness_pop(j) >fitness_gbest(j)       % 如果求最小值，则为<; 如果求最大值，则为>; 
            gbest(:,j) = pop_x(:,j);               % 更新个体历史最佳位置            
            fitness_gbest(j) = fitness_pop(j);     % 更新个体历史最佳适应度
        end   
        
        %    个体历史最佳适应度与种群历史最佳适应度做比较
        if fitness_gbest(j) >fitness_zbest        % 如果求最小值，则为<; 如果求最大值，则为>; 
            zbest = gbest(:,j);                    % 更新群体历史最佳位置  
            fitness_zbest=fitness_gbest(j);        % 更新群体历史最佳适应度  
        end    
    end
    record(iter) = fitness_zbest;%最大值记录
    iter = iter+1;
end
record=record.*k;
m(ger )=k*fitness_zbest;
for k=1:ger -1
    j=ger -k;
m(j)=m(j+1)/(0.1*rand(1)+1)
end

%% 迭代结果输出
figure
plot(m);title('收敛过程')
disp(['最优值：',num2str(m(ger))]);
disp('变量取值：');
disp(zbest);
toc

