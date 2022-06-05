%牛顿法 

x1_0=0;
x2_0=1;

syms x1
syms x2
y(x1,x2)=(x1-1)^4+x2^2;

[x,f]=newtton(x1_0,x2_0,y)

function [xmin,fmin]=newtton(x1_0,x2_0,y)

k=0;
%容忍度
xita=0.000001
%求梯度
grad_y=gradient(y)
%求雅克比矩阵 即2次梯度
ggrad_y=jacobian(grad_y)
%求逆
ggrad_y_ni=inv(ggrad_y)

%下降方向
dk=ggrad_y_ni*grad_y

x=dk(x1_0,x2_0)
x=double(x)

%第一次更新
x1k=x1_0-x(1)
x2k=x2_0-x(2)

%开始迭代
while(1)

f_grad_y=double(grad_y(x1k,x2k))

%算梯度二范数作为终止条件
ggrad_y_funshu=sqrt((f_grad_y(1))^2+(f_grad_y(2))^2)


if(abs(ggrad_y_funshu)<xita)


    xmin=[x1k,x2k]
    fmin=y(x1k,x2k)
    fmin=eval(fmin)
    k
break
end

dk=ggrad_y_ni*grad_y

x=dk(x1k,x2k)
x=double(x)

%更新
x1k=x1k-x(1)
x2k=x2k-x(2)
k=k+1;

end

end
