%COSAMP greedy algorithm for non linear sparse recovery
%this function returns a column vector x recovered using cOSAMP alogorithm.
%length(x)=size(A,2);
%N=number of iterations

function x=COSAMPLN(y,A,myfun,N,k)
o=[]; %support vectors
xinit=zeros(size(A,2),1);
x=xinit;
l=1;%initialisation for iterations 

while(l<=N && norm(y-log(A*x))>10^-3)
    fun1 = @(x0) myfun(A,x0); %function handle for ||y-f(x)||
    c=Grad(fun1,x); %calculating the numerical gradient of ||y-f(x)|| to find the correlation
    [m n]=sort(abs(c),'descend');
    ix=n(1:2*k); % select top 2k values with max correlation
    o=[o;ix];    %update support
    fun2 = @(x0) myfun(A(:,o),x0);
    b=fminunc(fun2,1*rand(length(o),1));    %min(||y-f(x)||)
    [p q]=sort(abs(b),'descend');
    oin=q(1:k);  %select top k values
    x1=b(oin);
    o=o(oin);
    x=xinit;
    x(o)=x1;
    l=l+1;
    %r=y-A(:,o)*x1;
end