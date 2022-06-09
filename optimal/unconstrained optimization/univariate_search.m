%坐标循环法 univariate search technique

%初始点
x0=[102;100;77];

[x,f]=technique(x0);

function y=fai(x)

y=(x(1)-4)^4+(x(2)-3)^2+4*(x(3)+5)^4;

end


function [xmin,fmin]=technique(x0)

xita=0.1;
k=0;

z0=x0;
xk=x0;
%一维搜索
zk=search(z0);

%第一轮结束
xk1=zk;

%开始循环
while(1)

    %终止条件：xk+1-xk 的2范数<容忍度
     f= norm(xk1-xk);
     f
    if f<xita
        xmin=xk1;
        fmin=fai(xk1);
        k
        break;
    end

k=k+1;
z0=xk1;
xk=xk1;
%一维搜索
zk=search(z0);

xk1=zk;

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

while(1)

%e1方向试探 第一次试探

if fai(z0+lamuda0*e1)<fai(z0)
       lamuda1=a*lamuda0;

while(1)
            
    if fai(z0+lamuda1*e1)<fai(z0+lamuda0*e1)
        %存一下上次的
        lamuda0=lamuda1;
        %更新
        lamuda1=a*lamuda1;

    else
        lamuda=lamuda1;
        zk=z0+lamuda*e1;
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
if fai(z0-lamuda0*e1)<fai(z0)

       lamuda1=a*lamuda0;

while(1)
            
    if fai(z0-lamuda1*e1)<fai(z0-lamuda0*e1)
         %存一下上次的
        lamuda0=lamuda1;
        lamuda1=a*lamuda1;
    else
        lamuda=lamuda1;
        zk=z0-lamuda*e1;
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
lamuda0;
lamuda0=lamuda0*b;
else
    zk=z0;
    break
end

end


%后面直接写for 循环，进行剩下方向的试探
for i=2:3

e=A(:,i)
%归0
flag=0;
lamuda0=0.01;


while(1)

%e方向试探

if fai(zk+lamuda0*e)<fai(zk)
       lamuda1=a*lamuda0;

while(1)
            
    if fai(zk+lamuda1*e)<fai(zk+lamuda0*e)
         %存一下上次的
        lamuda0=lamuda1;
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

% 负e方向寻找
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
lamuda0;
% 还是找不到 只能缩小lamuda
lamuda0=lamuda0*b;
else
    zk=zk;
    break
end
end

i=i+1;

end

end
