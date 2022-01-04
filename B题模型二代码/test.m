function flag=test(code)
%判断阈值和权值是否超界
% lenchrom   input : 染色体长度
% bound      input : 变量的取值范围
% code       output: 染色体的编码值
% x=code; %先解码，x是1行numsum列的矩阵
% flag=1;
f1=isempty(find(code>3, 1));%isempty(A)若A为空，则返回1，否则返回0
f2=isempty(find(code<-3, 1));%find中如果满足条件，则返回元素位置，最后面的1是为了让程序提高寻找效率
%fine(code<-3)能够找出所有满足条件的元素位置，但我们只需要检测code<-3就好了没必要找到全部，因此用find(code<-3,1)
if f1*f2==0     %有基因（权值或者阈值）超界，返回0让程序重新编码
    flag=0;
else
    flag=1;%编码符合条件，返回1跳出编码
end
% if (x(1)<0)&&(x(2)<0)&&(x(3)<0)&&(x(1)>bound(1,2))&&(x(2)>bound(2,2))&&(x(3)>bound(3,2))
%     flag=0;
% end 

