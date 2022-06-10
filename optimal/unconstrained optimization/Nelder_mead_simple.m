%Nelder-mead 单纯形法

tic
%选择4个初始点
x0_1=[48;38;259];
x0_2=[37;319;17];
x0_3=[39;171;29];
x0_4=[64;152;74];

[x,f,k]=NMSP(x0_1,x0_2,x0_3,x0_4);

%计算时间
timett=toc;

function y=fai(x)

y=(x(1)-4)^4+(x(2)-3)^2+4*(x(3)+5)^4;

end

function [xmin,fmin,k]=NMSP(x0_1,x0_2,x0_3,x0_4)

A=[x0_1,x0_2,x0_3,x0_4];
%目标函数为3维 单纯形为4维

%容忍度
xita=0.001;
k=0;

%冒泡排序一下 并赋值xs1，xs2，xs3，xs4 越前面代表越小
A=maopao(A);
xs1=A(:,1);xs2=A(:,2);xs3=A(:,3);xs4=A(:,4);


%没想好switch怎么写 用while if 代替一下 效果差不多
while(1)

%计算重心点
xm=(1/3)*(xs1+xs2+xs3);

%探测点求取(取p=2，yita=0.5)
x1=xs4+2*(xm-xs4);
x2=xs4+2.5*(xm-xs4);
x3=xs4+1.5*(xm-xs4);

%分情况讨论 开始对单纯形进行各种变形

while(1)

%情况1
if fai(x1)<fai(xs1)
    if fai(x1)<=fai(x2)
        xs4=xs3;xs3=xs2;xs2=xs1;xs1=x1;
        break;
    else
        xs4=xs3;xs3=xs2;xs2=xs1;xs1=x2;
        break;
    end

end

%情况2
if fai(x1)>=fai(xs1) && fai(x1)<fai(xs2)
     xs4=xs3;xs3=xs2;xs2=x1;xs1=xs1;
     break;
end

%情况3
if fai(x1)>=fai(xs2) && fai(x1)<fai(xs3)
     xs4=xs3;xs3=x1;xs2=xs2;xs1=xs1;
     break;

end

%情况4
if fai(x1)>=fai(xs3) && fai(x1)<fai(xs4)
     xs4=x1;xs3=xs3;xs2=xs2;xs1=xs1;
     break;
end


%情况5 x1无下降
if fai(x1)>=fai(xs4)

    %考虑x3的情况
    %情况1

    if fai(x3)<fai(xs1)
        xs4=xs3;xs3=xs2;xs2=xs1;xs1=x3;
        break;
    end
    
    %情况2
    if fai(x3)>=fai(xs1) && fai(x3)<fai(xs2)
     xs4=xs3;xs3=xs2;xs2=x3;xs1=xs1;
     break;
    end
    
    %情况3
    if fai(x3)>=fai(xs2) && fai(x3)<fai(xs3)
     xs4=xs3;xs3=x3;xs2=xs2;xs1=xs1;
     break;

    end

    %情况4
    if fai(x3)>=fai(xs3) && fai(x3)<fai(xs4)
     xs4=x3;xs3=xs3;xs2=xs2;xs1=xs1;
     break;
    end
    
    %情况5 x1,x3都没有下降，只能收缩单纯形了 收缩率deta=0.5
    if fai(x3)>=fai(xs4)

    xm2=xs1+0.5*(xs2-xs1);
    xm3=xs1+0.5*(xs3-xs1);
    xm4=xs1+0.5*(xs4-xs1);

    xs1=xs1;xs2=xm2;xs3=xm3;xs4=xm4;
    A=[xs1,xs2,xs3,xs4];
    
    %重新排序
    A=maopao(A);
    xs1=A(:,1);xs2=A(:,2);xs3=A(:,3);xs4=A(:,4);
    break;
    end
end

end
%终止条件判断
f1=sqrt(0.5*((fai(xm)-fai(xs1))^2)+((fai(xs4)-fai(xs1))^2));
f2=0.5*(norm(xm-xs1,1)+norm(xs4-xs1,1));
k=k+1;
if f2<=xita && f1<=xita

    xmin=xm;
    fmin=fai(xm);

break
end

end

end


%冒泡排序
function N=maopao(N)
    for i=1:length(N)
    for j=2:length(N)-i+1
    if fai(N(:,j-1))>fai(N(:,j))
        temp=N(:,j-1);
        N(:,j-1)=N(:,j);
        N(:,j)=temp;
    end
    end
    end
end

