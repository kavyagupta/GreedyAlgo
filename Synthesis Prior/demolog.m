clc;
clear all;
close all;
n=60;                                       %no. of measurements
k=4;                                        %no. of non zeros
x0 = zeros(100,1);
t = randperm(100);
A = rand(n,100);                            %measurement matrix
x0(t(1:k)) = 0.5*rand(k,1)+0.25;                 %spare signal
y =log(A*x0);                               %non linear exponential function f(x)=exp(Ax)
myfun = @(A,x0) norm(y-log(A*x0),2);
%%
%recovered vector from greedy OMP algorithm for non linear function
x1=OMPLN(y,A,myfun,2*k);
%recovered vector from greedy CoSaMP algorithm for non linear function
x2=COSAMPLN(y,A,myfun,2*k,k);
%%
%plot of the signals recovered
stem(x0,'*'); hold on ; stem(x1,'g+');hold on ; 
stem(x2,'r');
title('Greedy algorithm OMP and CoSaMP for Logarithmic');
legend('original','OMP','CoSaMP');
xlabel('position of non-zero in x');
ylabel('value of x');
nmseo=norm(x1-x0)/norm(x0)
nmsec=norm(x2-x0)/norm(x0)

