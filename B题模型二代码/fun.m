function error = fun(x,inputnum,hiddennum,outputnum,net,inputn,outputn)
%该函数用来计算适应度值
%x          input     染色体信息
%inputnum   input     输入层节点数
%outputnum  input     隐含层节点数
%net        input     网络
%inputn     input     训练输入数据
%outputn    input     训练输出数据
%error      output    个体适应度值

%提取
w1=x(1:inputnum*hiddennum);%取到输入层与隐含层连接的权值
B1=x(inputnum*hiddennum+1:inputnum*hiddennum+hiddennum);%隐含层神经元阈值
w2=x(inputnum*hiddennum+hiddennum+1:inputnum*hiddennum+hiddennum+hiddennum*outputnum);%取到隐含层与输出层连接的权值
B2=x(inputnum*hiddennum+hiddennum+hiddennum*outputnum+1:inputnum*hiddennum+hiddennum+hiddennum*outputnum+outputnum);%输出层神经元阈值


%网络进化参数
net.trainParam.epochs=20;%迭代次数
net.trainParam.lr=0.1;%学习率
net.trainParam.goal=0.00001;%最小目标值误差
net.trainParam.show=100;
net.trainParam.showWindow=0;
 
%网络权值赋值
net.iw{1,1}=reshape(w1,hiddennum,inputnum);%将w1由1行inputnum*hiddennum列转为hiddennum行inputnum列的二维矩阵
net.lw{2,1}=reshape(w2,outputnum,hiddennum);%更改矩阵的保存格式
net.b{1}=reshape(B1,hiddennum,1);%1行hiddennum列，为隐含层的神经元阈值
net.b{2}=reshape(B2,outputnum,1);

%网络训练
net=train(net,inputn,outputn);

an=sim(net,inputn);
error=sum(abs(an-outputn));%染色体对应的适应度值

% [m n]=size(inputn);
% A1=tansig(net.iw{1,1}.*inputn+repmat(net.b{1},1,n));   %需与main函数中激活函数相同
% A2=purelin(net.iw{2,1}.*A1+repmat(net.b{2},1,n));      %需与main函数中激活函数相同  
% error=sumsqr(outputn-A2);


