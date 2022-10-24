%OMP greedy algorithm for non linear sparse recovery
%this function returns a column vector recovered using OMP alogorithm.
%length(x)=size(A,2);
%N=number of iterations

function x=OMPLN(y,A,myfun,N)
o=[];   %support vectors
xinit=zeros(size(A,2),1);
x=xinit;
l=1; %initialisation for iterations 

while(l<=N && norm(y-log(A*x))>10^-3)
    fun1 = @(x0) myfun(A,x0);  %function handle for ||y-f(x)||
    c=Grad(fun1,x); %calculating the numerical gradient of ||y-f(x)|| to find the correlation
    [m ix]=max(abs(c));%index with the max correlation.
    o=[o;ix];  %support update
    fun2 = @(x0) myfun(A(:,o),x0);
    b=fminunc(fun2,1*rand(length(o),1));%min(||y-f(x)||)
    x = xinit;
    x(o) = b;
    l=l+1;
end

