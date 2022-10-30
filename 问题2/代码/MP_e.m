function [cc, n, yo, MM] = MP_e(input, output, N, M)

x = input(:);   %将输入和输出都变成列向量
y = output(:);
x = x / max(abs(x));   %对输入和输出进行归一化
y = y / max(abs(y));
% x = x / sqrt(mean(x .* conj(x)));
% y = y / sqrt(mean(y .* conj(y)));
len = length(x);


ym = y(M+1:len);  %长度会缩小到len-M，因为前面几个x没有更前面的记忆项了

X = [];
% Nonlinear Memory
% 下面这个两个循环的目的是，将输入x变成扩展乘没一行有(M+1)*(N+1)个值
% 每个值都会乘后面计算得到的cc的一个系数，相当于把每个时间点的阶次和记忆项的组合
% 给列了一行，所以x从列向量变成了矩阵
for m = 0 : M
    x_buff = x(M-m+1:len-m);
    for n = 0 : N
        X_buff = x_buff .* (abs(x_buff) .^ n);
        X = [X, X_buff];  % 因为X_buff都是列向量，所以X是个有(M+1)*(N+1)列，length-M行的矩阵
    end
end
X = [X];
% cc = pinv(X' * X) * X' * ym;
%    case 'pinv'
%下面这句就是LS算法，可见https://app.yinxiang.com/shard/s8/nl/18205071/1513425d-b355-479b-9615-f893b07425e5
      cc = pinv(X' * X + 0.0000 * eye(size(X, 2))) * X' * ym;   %cc是计算一组系数，让其的输出能最接近ym
%    case 'QR'，和pinv一样，都是求逆矩阵
%        [C, R] = qr(sym(X), sym(ym));
%        cc = R \ C;
%        cc = double(cc);
% end
yo = X * cc;  %一个行列为length-M,(N+1)*(M+1)的矩阵，乘上一个行列为(N+1)*(M+1),1的矩阵
% yo = quantize_v(yo, b);
cc = cc(:);   %给出的系数数量会是(N+1)*(M+1)，列向量，而不是N*M，因为0阶和0记忆深度也会有系数
n = NMSE(yo, ym);  %计算出来的yo和ym是一样的维度，虽然ym少了几项（少的数量是记忆的大小），但是yo也少了这么多
MM = X;
