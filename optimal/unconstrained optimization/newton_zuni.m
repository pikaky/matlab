% 阻尼牛顿法

%一定条件下的一些函数能找到全局最优

%目标函数
syms x1
syms x2
syms x3
y(x1,x2,x3)=(x1-4)^4+(x2-3)^2+4*(x3+5)^4;

%初始点
a=[4,2,-1] ;

[f,x]=speedent(1,22,100,y);

function [fmin,xmin]=speedent(x1_0,x2_0,x3_0,b)

%容忍度
xita=0.01;

%初始梯度 并求值
grad_y=gradient(b);
%求雅克比矩阵 即2次梯度
ggrad_y=jacobian(grad_y);
%求逆
ggrad_y_ni=inv(ggrad_y)

%下降方向
dk=ggrad_y_ni*grad_y
%计算下降方向
f_grady=dk(x1_0,x2_0,x3_0)

%新目标函数 负梯度上
syms a

f1=f_grady(1);
f2=f_grady(2);
f3=f_grady(3);

f1=double(f1);
f2=double(f2);
f3=double(f3);

f(a)=(x1_0-f1*a-4)^4+(x2_0-f2*a-3)^2+4*(x3_0-f3*a+5)^4;

%设定好初始两点，得到初始步长aefa_0 利用黄金切割法
aefa_0=gold(-10,10,f);

%更新所有参数 
xk1=x1_0-aefa_0*f1;
xk2=x2_0-aefa_0*f2;
xk3=x3_0-aefa_0*f3;

%迭代开始
while(1)
    
f_grady=dk(xk1,xk2,xk3);

%新目标函数 
f1=f_grady(1);
f2=f_grady(2);
f3=f_grady(3);

f1=double(f1);
f2=double(f2);
f3=double(f3);

f(a)=(xk1-f1*a-4)^4+(xk2-f2*a-3)^2+4*(xk3-f3*a+5)^4;

%设定好初始两点，得到步长aefa
aefa=gold(-10,10,f);

%二范数判断dk大小
fanshu_f_grady=sqrt(f1^2+f2^2+f3^2);
disp(fanshu_f_grady)

    if fanshu_f_grady<xita
       xmin=[xk1,xk2,xk3];
       fmin=b(xk1,xk2,xk3);
       fmin=double(fmin);
    break

    else
%更新所有参数 
xk1=xk1-aefa*f1;
xk2=xk2-aefa*f2;
xk3=xk3-aefa*f3;
    end

end


end





function aefa=gold(a,b,f)

k=0;

tao=(sqrt(5)-1)/2;

xgm=0.01;    %容忍度

%初始试探点选择
ak=a;

bk=b;

lamudak=ak+(1-tao)*(bk-ak);  %拉姆达 k

muk=ak+tao*(bk-ak);   %谬k



while(1)


    if f(lamudak)<f(muk)
    
    bk=muk;

    muk=lamudak;
    lamudak=ak+(1-tao)*(bk-ak);

    k=k+1;

    else

    ak=lamudak;    %左端=拉姆达 k
    

    lamudak=muk;   %拉姆达 k+1 = 谬k
    muk=ak+tao*(bk-ak); %新的谬 k+1 = ~
    
    k=k+1;
    end

    if abs(bk-ak)<xgm
        aefa=(ak+bk)/2;
        break;
    end


end


end

