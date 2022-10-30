function [rou, rou_min] = rou_4_384(W_hat,W)
%计算 任意行x任意列x4x384的矩阵的W的rou


rou = [];
rou_min = [];
for j = 1:4
    for k = 1:384
        [rou_temp rou_min_temp] = rou_cal(W_hat(:,:,j,k),W(:,:,j,k));
        rou = [rou rou_temp];
        rou_min = [rou_min rou_min_temp];
    end
end

end

