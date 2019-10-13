function [r,m]=mulDamp(F,x0,h,u,v,eps)
format long;
if nargin==5
    eps=1.0e-6;
end

FI = transpose(F)*F/2;
n = length(x0);
x0 = transpose(x0);
m=1;
tol=1;

while tol>eps
    j = 0;
    fx = subs(F,findsym(F),x0);
    J = zeros(n,n);
    for i=1:n
        x1 = x0;
        x1(i) = x1(i)+h;
        afx = subs(F,findsym(F),x1);
        J(:,i) = (afx-fx)/h;
    end
    
    FIx = subs(FI,findsym(FI),x0);
    for i=1:n
        x2 = x0;
        x2(i) = x2(i)+h;
        gradFI(i,1) = (subs(FI,findsym(FI),x2)-FIx)/h;
    end

    s=0;
    while s==0
        A = transpose(J)*J+u*eye(n,n);
        p = -A\gradFI;
        r = x0 + p;
        FIr = subs(FI,findsym(FI),r);  
        if FIr<FIx
            if j == 0
                u = u/v;
                j = 1;
            else                              
                s=1;
            end
        else
            u = u*v;
            j = 1;
            if norm(r-x0)<eps
                s=1;
            end
        end
    end 
    x0 = r;
    tol = norm(p);
    m=m+1;
    if(m>100000)                                              %迭代步数控制
        disp('迭代步数太多，可能不收敛！');
        return;
    end
end
format short;