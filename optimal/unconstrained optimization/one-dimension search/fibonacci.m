
[x,f]=Fibonacc(-1,1);

function [xmin,fmin]=Fibonacc(a,b)

ak=a
bk=b
xgm=0.01;
n=1;

while fibo(n)<(b-a)/xgm  %算n
     n=n+1;
end

disp(n);

%初次
lamudak=ak+fibo(n-2)/fibo(n)*(bk-ak);
muk=ak+fibo(n-1)/fibo(n)*(bk-ak);

%迭代
for k=1:n-1

if fai(lamudak)<fai(muk)
ak=ak;
bk=muk;

muk=lamudak;
lamudak=ak+fibo(n-2)/fibo(n)*(bk-ak);

else
ak=lamudak
bk=bk;

lamudak=muk
muk=ak+fibo(n-1)/fibo(n)*(bk-ak);

end

end

%输出结果
xmin=(ak+bk)/2;
fmin=fai(xmin);

end


function y=fai(x) %目标函数

y=2*x*x-x-1;

end



function f=fibo(n)  %用于产生斐波那契数列;

a=(1+sqrt(5))/2;
b=(1-sqrt(5))/2;
c=a.^n-b.^n;
f=c/sqrt(5);

end