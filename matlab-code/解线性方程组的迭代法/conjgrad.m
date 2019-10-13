function [x,n]= conjgrad (A,b,x0)
r1  = b-A*x0;
p  = r1;
n  = 0;
for i=1:rank(A)                    %以下过程可参考算法流程
    if(dot(p,A*p) < 1.0e-50)     %循环结束条件
          break;
    end
    alpha  = dot(r1,r1)/dot(p,A*p);
    x  = x0+ alpha*p;
    r2 = r1- alpha*A*p;
    if(r2 < 1.0e-50)               %循环结束条件
          break;
    end
    belta  = dot(r2,r2)/dot(r1,r1);
    p  = r2+belta*p;
    n  = n + 1;
end
