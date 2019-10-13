function [A0,A,B]=FZZ(func,T, n)
syms t;
func = subs(sym(func), findsym(sym(func)),sym('t'));
A0=int(sym(func),t,-T/2,T/2)/T;
for(k=1:n)
    A(k)=int(func*cos(2*pi*k*t/T), t,-T/2,T/2)*2/T;
    A(k)=vpa(A(k),4);
    B(k)=int(func*sin(2*pi*k*t/T), t,-T/2,T/2)*2/T;
    B(k)=vpa(B(k),4);
end
    