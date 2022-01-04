function ret=Select(individuals,sizepop)
% 本函数对每一代种群中的染色体进行选择，以进行后面的交叉和变异
% individuals input  : 种群信息
% sizepop     input  : 种群规模
% ret         output : 经过选择后的种群

% 选择操作即为决定整个遗传算法种群走向的关键性步骤，遗传算法的选择操作
% 通常以较大的概率保留父代优良个体到子代中，以此使得种群往适应度值最佳的方向进化，

% 通俗的讲就是：有若干个备选方案，而且每个方案都有自己的潜力分值，但是在选择的时候并不完全按照分值的高低来选
% 而是有一定的概率接受，分值高的接受概率高，分值较低接受的概率也低。

%根据个体适应度值进行排序
fitness1=10./individuals.fitness;%10为系数，取倒数得到新的数组fitness1，其值越大个体被选中的概率就越大
%.*或者./表示对矩阵里每个元素都执行同样操作
sumfitness=sum(fitness1);
sumf=fitness1./sumfitness;%每个个体遗传到下一代的概率，1行sizepop列

index=[]; %仅仅是一个角标，当做记号即可
%采用轮盘赌法选择新个体
for i=1:sizepop   %转sizepop次轮盘，%共选出sizepop个个体保留至下代
    pick=rand;    %产生随机数赋给pick
    while pick==0    %若随机数是0，则重新产生随机数
        pick=rand;        
    end
    for j=1:sizepop    %循环每个个体，找出此次的rank落在哪个个体的区间
        pick=pick-sumf(j);   %寻找rank落在哪个个体所在的区间，个体被选中的概率越大，其所占区间越大     
        if pick<0        %说明个体j的概率比较大（适应度值较小）
            index=[index j];        %1行sizepop列的矩阵，存放被选中的个体标记    
            break;  %寻找落入的区间，此次转轮盘选中了染色体i，注意：在转sizepop次轮盘的过程中，有可能会重复选择某些染色体
        end
    end
end

%新的种群
individuals.chrom=individuals.chrom(index,:);
individuals.fitness=individuals.fitness(index);
ret=individuals;
 