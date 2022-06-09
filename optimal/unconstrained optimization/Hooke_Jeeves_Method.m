%H,J方法 Hooke,Jeeves Method

%初始点
x0=[355;131;255];

[x,f]=technique(x0);

function y=fai(x)

y=(x(1)-4)^4+(x(2)-3)^2+4*(x(3)+5)^4;

end


function [xmin,fmin]=technique(x0)

xita=0.1;
k=0;

zk=x0;
xk=x0;
xk1=x0;


%开始循环
while(1)

    %探测搜索
    zk=xk1;
    zk1=search(zk);
    xk=zk;
    xk1=zk1;

    %终止条件：xk+1-xk 的2范数<容忍度
     f= norm(xk1-xk);
     f
    if f<xita
        xmin=xk1;
        fmin=fai(xk1);
        k
        break;
    end

    %模式搜索
    dp=xk1-xk;
    lamuda=Patternsearch(dp,xk1);

    k=k+1;
    xk=xk1;
    xk1=xk1+lamuda*dp;


end

end



%探测搜索 
function zk=search(z0)

%基础步长
xita=0.005;
lamuda0=0.01;
a=1.1;
b=0.1;
e1=[1;0;0];
e2=[0;1;0];
e3=[0;0;1];
A=[e1,e2,e3];
flag=0;
zk=z0;

%先进行n次探测搜索
for i=1:3

e=A(:,i);

while(1)
%e1方向试探 第一次试探

if fai(zk+lamuda0*e)<fai(zk)
       lamuda1=a*lamuda0;

while(1)
            
    if fai(zk+lamuda1*e)<fai(zk+lamuda0*e)
        %存一下上次的
        lamuda0=lamuda1;
        %更新
        lamuda1=a*lamuda1;

    else
        lamuda=lamuda1;
        zk=zk+lamuda*e;
        flag=1;
        break;
    end

end
end

%跳出大循环
if flag==1
    break

end

% 负e1方向寻找
if fai(zk-lamuda0*e)<fai(zk)

       lamuda1=a*lamuda0;

while(1)
            
    if fai(zk-lamuda1*e)<fai(zk-lamuda0*e)
         %存一下上次的
        lamuda0=lamuda1;
        lamuda1=a*lamuda1;
    else
        lamuda=lamuda1;
        zk=zk-lamuda*e;
        flag=1;
        break;
    end

end
end

%跳出大循环
if flag==1
    break

end

if lamuda0>xita
% 还是找不到 只能缩小lamuda
lamuda0=lamuda0*b;
else
    zk=zk;
    break
end
end

%归0 加1
flag=0;
lamuda0=0.01;
i=i+1;
end
end


function lamuda=Patternsearch(dp,zk)

xita=0.005;
lamuda0=0.01;
a=1.1;
b=0.1;
flag=0;

while(1)
%dp方向试探 

if fai(zk+lamuda0*dp)<fai(zk)
       lamuda1=a*lamuda0;

while(1)
            
    if fai(zk+lamuda1*dp)<fai(zk+lamuda0*dp)
        %存一下上次的
        lamuda0=lamuda1;
        %更新
        lamuda1=a*lamuda1;

    else
        lamuda=lamuda1;
        flag=1;
        break;
    end

end
end

%跳出大循环
if flag==1
    break

end

if lamuda0>xita
% 还是找不到 只能缩小lamuda
lamuda0=lamuda0*b;
else
    lamuda=0;
    break
end


end
end