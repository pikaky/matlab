%question min f(x)=2x^2-x-1
 

[x,f]=gold(-1,1)

function [xmin,fmin]=gold(a,b)

k=0;

tao=(sqrt(5)-1)/2;

xgm=0.001;    %容忍度

%初始试探点选择
ak=a;

bk=b;

lamudak=ak+(1-tao)*(bk-ak);  %拉姆达 k

muk=ak+tao*(bk-ak);   %谬k



while(1)


    if fai(lamudak)<fai(muk)
    
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
        xmin=(ak+bk)/2;
        fmin=fai(xmin);
        break;
    end


end


end



function y=fai(x)

y=2*x*x-x-1;

end


