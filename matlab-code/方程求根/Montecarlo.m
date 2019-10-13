function root = Montecarlo(f,B,x0,eps)
format long;
if(nargin==3)
    eps=1.0e-4;
end
Fx = subs(sym(f),findsym(sym(f)),x0);

while abs(Fx)>eps
    Fx = subs(sym(f),findsym(sym(f)),x0);
    Fx1 = abs(Fx) + 10;
    while (abs(Fx1) >= abs(Fx))        
        r = 2*B*rand()-B;
        x1 = x0 + r;
        Fx1 = subs(sym(f),findsym(sym(f)),x1);
    end
    x0 = x1;    
end
root = x1;
format short;