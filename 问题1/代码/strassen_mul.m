clear;clc
A=[1 3;7 5];%测试数据
B=[6 8;4 2];%测试数据
C1=A*B%标准数据结果
C1=strassen(A,B)%strassen结果

A=[45 12 32 12 ;52 32 10 54;20 43 20 1;15 96 03 4];%测试数据
B=[96 25 34 62 ;38 10 5  41;13 62 2 17;10 62 19 27];%测试数据
C2=A*B%标准数据结果
C2=strassen(A,B)%strassen结果

function [C] = strassen(A,B)
%strassen算法，输入的size==2^n
n=length(A);
if n==1 
    C=A*B;%单个长度，就直接计算
else
    %步骤二的计算公式
    S1=B(1:n/2,n/2+1:n)-B(n/2+1:n,n/2+1:n);
    S2=A(1:n/2,1:n/2)+A(1:n/2,n/2+1:n);
    S3=A(n/2+1:n,1:n/2)+A(n/2+1:n,n/2+1:n);
    S4=B(n/2+1:n,1:n/2)-B(1:n/2,1:n/2);
    S5=A(1:n/2,1:n/2)+A(n/2+1:n,n/2+1:n);
    S6=B(1:n/2,1:n/2)+B(n/2+1:n,n/2+1:n);
    S7=A(1:n/2,n/2+1:n)-A(n/2+1:n,n/2+1:n);
    S8=B(n/2+1:n,1:n/2)+B(n/2+1:n,n/2+1:n);
    S9=A(1:n/2,1:n/2)-A(n/2+1:n,1:n/2);
    S10=B(1:n/2,1:n/2)+B(1:n/2,n/2+1:n);
    %步骤三的递归公式
    P1=strassen(A(1:n/2,1:n/2),S1);
    P2=strassen(S2,B(n/2+1:n,n/2+1:n));
    P3=strassen(S3,B(1:n/2,1:n/2));
    P4=strassen(A(n/2+1:n,n/2+1:n),S4);
    P5=strassen(S5,S6);
    P6=strassen(S7,S8);
    P7=strassen(S9,S10);
    %步骤四的结果相加
    C(1:n/2,1:n/2)=P5+P4-P2+P6;
    C(1:n/2,n/2+1:n)=P1+P2;
    C(n/2+1:n,1:n/2)=P3+P4;
    C(n/2+1:n,n/2+1:n)=P5+P1-P3-P7;
end
end