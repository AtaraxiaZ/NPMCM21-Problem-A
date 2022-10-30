function [output,max_input] = MP_v(input, cc, N, M)
cc = cc(:);
x = input(:);
% x = x / sqrt(mean(x .* conj(x)));
max_input = max(abs(x));
x = x / max(abs(x));
x = [x(1:M); x]; %将x的前M个复制到了M的前面，为了产生和input相同数量的输出
len = length(x);

X = [];

for m = 0 : M
    x_buff = x(M-m+1:len-m);
    for n = 0 : N
        X_buff = x_buff .* (abs(x_buff) .^ n);
        X = [X, X_buff];
    end
end

y = X * cc;
% 不能按照y来归一化，因为y的前面7个值都是不正确的值，会非常大，导致y(8)非常小，出错
% y = y/max(abs(y));
output = y;

