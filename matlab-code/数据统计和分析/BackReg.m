function Var = BackReg(X,Y,alpha)
format long;
sz = size(X);
N = sz(1);
n = sz(2);

Varin = X;
VarLeft = zeros(n,1);
VarAdd = 1:n;
VarInnum = n;

for i=1:n
    [RegCoff,R,F,FX,TX]= MultiLineReg(Varin(:,1:VarInnum),Y);
    [minFX,Vindex] = min(FX);
    if minFX <= fcdf(alpha,1,N-i-n)
        if Vindex == VarAdd(1)
            VarAdd(1:VarInnum-1) = VarAdd(2:VarInnum);
            Varin(:,1:VarInnum-1) = Varin(:,2:VarInnum);
            VarInnum = VarInnum - 1;
        else
            if Vindex == VarAdd(VarInnum)
                VarInnum = VarInnum - 1;
            else
                VarAdd(Vindex:VarInnum-1) = VarAdd(Vindex:VarInnum);
                Varin(:,Vindex:VarInnum-1) = Varin(:,Vindex:VarInnum);
                VarInnum = VarInnum - 1;
            end
        end
    else
        break;
    end        
end
Var = VarAdd;
format short;