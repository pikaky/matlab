
% min -4x1-x2
% s.t. -x1+2x2<4
%      '''''


c = [-4 -1 0 0 0]';
b = [4 12 3]';
A = [-1 2 1 0 0;2 3 0 1 0;1 -1 0 0 1]; %引入松弛变量x3 x4 x5
b1=zeros(2,1)

c1=[-4 -1]';
b1 = [4 12 3]';
A1 = [-1 2 ;2 3;1 -1];

%单纯形法
[x,f]=linProg(c,A,b);

%matlab自带
[e,g]=linprog (c1,A1,b1);

function [xstar,fstar] = linProg(c,A,b)
[m,n] = size(A);
x = zeros(n,1); %创建nx1的0矩阵
[B_idx,N_idx] = baseMat(A);         % 初始基向量、非基向量 用其列数表示

while 1

    x_B = ((A(:,B_idx))^-1)*b;      % A(:,B_idx)=B 初始基向量，X_B=B逆b 初始解

    x(B_idx) = x_B;                 % 初始解填充x (xB xN)'

    f = c'*x;                       % 初始目标函数 值

    w = c(B_idx)'*((A(:,B_idx))^-1);% 单纯行乘字 即CBB逆

    z_c = w*A(:,N_idx)-c(N_idx)';   % 求zc-cj = CBB逆Pj -cj 

    [zk_ck,k] = max(z_c);           % 求里面最大的zk-ck 返回第k个 进击向量下标

    k = N_idx(k);   % 进击变量下标 N里的第k个 即为A里对应的进击向量下标

    if zk_ck <= 0                   % 小于等于0 已是最优
        xstar = x;
        fstar = f;
        return                    %返回x，f
    else

        yk = ((A(:,B_idx))^-1)*A(:,k);  % X_B=B逆b-B逆PkXk=b" - yk*Xk
        % yk=B逆Pk (mx1 列向量)

        if all(yk<=0)               % yk < 0 无解
            disp('无解了')
            xstar = x;
            fstar = f;

        else
            yk0_idx = find(yk>0);   % find 寻找非0值 返回的是位置 

            [x(k),r] = min(x_B(yk0_idx)./yk(yk0_idx)); % 求最小 从列向量中 返回最小值(进基变量)和下标
            % min(B逆b 点除 Yik)

            r = B_idx(yk0_idx(r)); % B里的第(yk0_idx(r))个 即为A里的r坐标 出基下标

            x(r) = 0;               % 出基变量

            %交换出基 进基 得新基

            B_idx(r) = k;

            N_idx(k) = r;

        end
    end
end





end

function [B_idx,N_idx] = baseMat(A)
[m,n] = size(A);
combs = combntns(1:1:n,m); %搞个方阵的排列组合 5选3 接下来找一个3x3的线性无关方阵B

for comb = combs'
    B = A(:,comb);
    if abs(det(B)) ~= 0 %行列式不等于0判断线性无关
        B_idx = comb; %B对应的列数
        N_idx = setdiff(1:1:n,B_idx);  %N对应的列数 1:1:n为[1,2,3..n]
        return
    end
end

end