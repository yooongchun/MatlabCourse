City = rand(20,2).*randi([1,100],20,2);
Ite = 200;
Ant_num = 40;
Alpha = 0.7;
Beta = 0.9;
Rho = 0.3;
Q = 100;
[R_best,L_best,L_ave,Shortest_Route,Shortest_Length]=ACATSP(City,Ite,Ant_num,Alpha,Beta,Rho,Q)