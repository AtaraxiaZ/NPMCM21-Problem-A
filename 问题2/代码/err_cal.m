function [error] = err_cal(W_hat,W)
%��error������������Ҫ�� ������x������x4x384 �ľ���

fenzi = 0;
fenmu = 0;
for j = 1:4
    for k = 1:384
        fenzi = fenzi + (norm(W_hat(:,:,j,k)-W(:,:,j,k),'fro'))^2;
        fenmu = fenmu + (norm(W(:,:,j,k),'fro'))^2;
    end
end

fenzi = fenzi/(384*4);
fenmu = fenmu/(384*4);
error = 10*log10(fenzi/fenmu);

end

