function ret=Cross(pcross,lenchrom,chrom,sizepop)
%本函数完成交叉操作
% pcorss                input  : 交叉概率
% lenchrom              input  : 染色体的长度
% chrom                 input  : 染色体群
% sizepop               input  : 种群规模
% ret                   output : 交叉后的染色体
 for i=1:sizepop  %每一轮for循环中，可能会进行一次交叉操作，染色体是随机选择的，交叉位置也是随机选择的，%但该轮for循环中是否进行交叉操作则由交叉概率决定（continue控制）
     % 随机选择两个染色体进行交叉
     pick=rand(1,2);   %产生1行2列的随机数矩阵
     while prod(pick)==0   %prod(A)检测矩阵是否有0，有则重新生成随机数
         pick=rand(1,2);
     end
     index=ceil(pick.*sizepop);  %ceil(z)函数将输入z中的元素取整,2.1则取3
     % 交叉概率决定是否进行交叉
     pick=rand;
     while pick==0
         pick=rand;
     end
     if pick>pcross  
         continue;   %如果随机数比交叉概率大，则重新回到for语句，不执行下面的语句
     end
     flag=0;    %随机数比交叉概率小，说明可以交叉
     while flag==0
         % 随机选择交叉位
         pick=rand;
         while pick==0
             pick=rand;
         end
         pos=ceil(pick.*sum(lenchrom)); %随机选择进行交叉的位置，即选择第几个变量进行交叉，注意：两个染色体交叉的位置相同
         pick=rand; %交叉开始
         v1=chrom(index(1),pos);%随机选到index(1)条染色体以及它的位置pos，将其变量值取出
         v2=chrom(index(2),pos);
         chrom(index(1),pos)=pick*v2+(1-pick)*v1;%实数交叉法，交叉公式
         chrom(index(2),pos)=pick*v1+(1-pick)*v2; %交叉结束
         flag1=test(chrom(index(1),:));  %检验染色体1的可行性
         flag2=test(chrom(index(2),:));  %检验染色体2的可行性
         if   flag1*flag2==0   %如果两个染色体不是都可行，则重新交叉
             flag=0;
         else flag=1;
         end   
     end
 end
ret=chrom;