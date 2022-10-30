function [U,S,V] = rsvd(A,K)

[M,N] = size(A);
P = min(2*K,N);
X = randn(N,P);
Y = A*X;
W1 = orth(Y);
B = W1'*A;
[W2,S,V] = svd(B,'econ');
U = W1*W2;
K=min(K,size(U,2));
U = U(:,1:K);
S = S(1:K,1:K);
V=V(:,1:K);