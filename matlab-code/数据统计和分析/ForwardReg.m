function Var = ForwardReg(X,Y,alpha)
format long;
sz = size(X);
N = sz(1);
n = sz(2);

Varin = zeros(N,n);
VarLeft = 1:n;
VarAdd = zeros(n,1);
Varleftnum = n;

for i=1:n
    maxFX = 0;
    for j=1:Varleftnum
        XNew = [Varin(:,1:(n-Varleftnum));X(:,VarLeft(j))];
        [Rc, R, F,FX,TX] = LineReg(XNew,Y);
        newFx = TX(length(FX));
        if abs(newFx) > maxFX
            maxFX = abs(newFx);
            Vindex = VarLeft(j);
        end
    end
    if maxFX >= tinv(1-alpha/2,N-i-1)
        if Vindex == VarLeft(1)
            VarLeft(1:Varleftnum-1) = VarLeft(2:Varleftnum);
            Varleftnum = Varleftnum - 1;
        else
            if Vindex == VarLeft(Varleftnum)
                Varleftnum = Varleftnum - 1;
            else
                VarLeft(Vindex:Varleftnum-1) = VarLeft(Vindex:Varleftnum);
                Varleftnum = Varleftnum - 1;
            end
        end
        Varin(:,i) = X(:,Vindex);
        VarAdd(i) = Vindex;
    else
        break;
    end
end
Var = VarAdd;
format short;