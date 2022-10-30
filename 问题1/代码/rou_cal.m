function [rou,rou_min] = rou_cal(W_hat, W);
% W_hat需要是64x2的矩阵才行


[row col] = size(W_hat);
[row1 col1] = size(W);
if row ~=row1 || col~=col1
    error('2个矩阵维度不一致！');
end

if row < col
    W_hat = W_hat.';
    W = W.';
    tmp=col;
    col=row;
    row=tmp;
end


rou = zeros(1,col);
for i = 1:col
    W_tmp = W_hat(:,i)' * W(:,i);
    rou(i) = abs(W_tmp)/(sqrt(W_hat(:,i)'*W_hat(:,i))*sqrt(W(:,i)'*W(:,i)));
end

% 注意这只是在L层面的最小值，在J和K层面的需要调用时用循环再从所有rou_min里找个最小值
rou_min = min(rou);


