function ret=Code(lenchrom,bound)
%本函数将变量编码成染色体，用于随机初始化一个种群
% lenchrom   input : 染色体长度
% bound      input : 变量的取值范围
% ret        output: 染色体的编码值
flag=0;
while flag==0
    pick=rand(1,length(lenchrom));%length得到一个矩阵里较大的行数或者列数，lenchrom是1行numsum列矩阵故返回numsum，即pick是1行numsum列的随机数矩阵
    %bound(:,1)'为取1行numsum列的值都是-3，bound(:,2)为取numsum行第2列的值都是3，(bound(:,2)-bound(:,1))'得到1行numsum列矩阵为6再与pick逐个元素相乘
    ret=bound(:,1)'+(bound(:,2)-bound(:,1))'.*pick; %线性插值，编码结果以实数向量存入ret中，ret是1行numsum列的矩阵
    flag=test(ret);     %检验染色体的可行性
end
        
