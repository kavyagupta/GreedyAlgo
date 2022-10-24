%Greedy Analysis Pursuit (GAP) algorithm for non-linear sparse recovery of
%Logarithmic function
%This function returns a column vector recovered using non-linear GAP algorithm

function x = NLGAP_log(y,f,D,N)
[p d]=size(D);
D1=D;
g=@(x)(y-f(x));
myfun=@(x)fun2(g,D,x);
options=optimset('Display','off');  
x=lsqnonlin(myfun,rand(p,1),[],[],options); %initial estimate of x

n1=norm(y-f(x));
Supp=1:p;       %initialize co-support of x

j=1;
while (j<=N && n1>10^(-3))
    a=D*x;
    [r i]=max(abs(a));  %find the largest entry of Dx
    Supp(i)=[];%update co-support by eliminating the index corresponding to largest entry
    D=D1(Supp,:);%update analysis operator
    myfun=@(x)fun2(g,D,x); %function handle for ||y-f(x)||
                           %                    || -Dx  ||
    x=lsqnonlin(myfun,x,[],[],options);%solve non-linear least squares problem to update x
    j=j+1;
    n1=norm(y-f(x));
    
end

function out = fun2(g,D,x)
out=[g(x);-D*x];
end

end