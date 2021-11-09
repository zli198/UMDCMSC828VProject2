clearvars
close all
M = readmatrix("MovRankData.csv");
M(:,1) = [];
%disp(M);
[n,d] = size(M);

%Problem 1
k = 5;
X = rand(n,k);
Y = rand(d,k);
M1=rand(n,d)*5;

lambda = 0.1; 
iter_max = 30; 
tol = 1e-6;

[X,Y,err]=LowRank(M,X,Y,iter_max,tol,lambda);
figure;
plot(err);

[M1,err]=NuclearNorm(M,M1,iter_max,tol,lambda);
%disp(M1);
figure;
plot(err);

%Problem 2

k=5;
[indices,C0]=kmeans(M1,k);
disp(indices');
disp(C0);
[idx,C]=k_means(M1,k);
disp(idx');
disp(C);
%[idice,C1]=Kmeans(M1,5);
%disp(idice');

iter_max=1000;
W0=rand(n,k)*sqrt(5/k);
H0=rand(k,d)*sqrt(5/k);
alpha=[1e-3,5e-4,1e-4,5e-5,1e-5];
figure;
hold on
for i=1:5
    [W,H,err]=PGD(M1,W0,H0,alpha(i),iter_max,tol);
    plot(err.*err);
end
[W,H,err]=LeeSeung(M1,W0,H0,iter_max,tol);
plot(err.*err);
title("Projected gradient descend with different alpha and Lee Seung, k = " + k)
xlabel('iteration')
ylabel('norm of error squared')
legend('$\alpha=0.001$','$\alpha=0.005$','$\alpha=0.0001$','$\alpha=0.0005$','$\alpha=0.00001$','LeeSeung','Interpreter','latex');
hold off