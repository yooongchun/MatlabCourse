function fv = Funval(f,varvec,varval)
var = findsym(f);
if length(var) < 4
    if var(1) == varvec(1)
        fv = subs(f,varvec(1),varval(1));
    else
        fv = subs(f,varvec(2),varval(2));
    end
else
    fv = subs(f,varvec,varval);
end