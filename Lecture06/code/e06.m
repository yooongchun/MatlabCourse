options=optimset('largescale','off');
[x,y]=fmincon('fun1',rand(3,1),[],[],[],[],zeros(3,1),[],'fun2', options);
fprintf('x1=%.4f\nx2=%.4f\nx3=%.4f\ny=%.4f\n',x,y);