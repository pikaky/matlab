% 一维 牛顿法


[e,f]=netwon(-8);

% 2*x^2-20
%目标函数
function y=fai(x)

y=2*x^2-20;

end


function [xmin,fmin]=netwon(a)

%目标函数
syms x
y(x)=2*x^2-20;

x0=a;

%容忍值
xita=0.1;

%求一阶导
doty=diff(y);
%求二阶导
ddoty=diff(doty);

%第一次迭代
xk=x0-doty(x0)/ddoty(x0);


while(1)
     if abs(doty(xk))<xita
         xmin=xk;
         fmin=fai(xk);
            break;
     else 
%求一阶导  
doty=diff(y(x));
%求二阶导
ddoty=diff(doty(x));


%迭代
xk=xk-doty(xk)/ddoty(xk);
     end
        
end

end

