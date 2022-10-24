%demo for Greedy Analysis Pursuit(GAP) for Non-linear sparse recovery of
%Logarithmic function y=log(Ax)
%uses SPARCO
clc;
clear all;
close all;
n=60;       %number of measurements
k=5;        %number of non-zero values in the sparse vector
%generate test vector
z0=zeros(100,1);
p=randperm(100);
z0(p(1:k))=rand(k,1);
opD=opFFT(100); %analysis operator
D=opToMatrix(opD);
x=D'*z0;   %vector x of length 100 such that D*x is sparse with 5 non-zero elements
A=randn(60,100);    %meaurement matrix
y=log(A*x);
%recover test vector using non-linear GAP
f=@(x)log(A*x); %function handle for log(Ax)           
xr=NLGAP_log(y,f,D,k);  %recovered vector from  non-linear GAP algorithm for log function
%compare original and recovered vectors
stem(real(x));hold on;stem(real(xr),'r+');
title('Non-linear GAP for logarithmic function');