clearvars
close all
lam=[0.01,0.05,0.1,0.5,1,5,10];
iter_max=30;
tol=1e-6;
A=readmatrix("MovRankData.csv");
A=A(:,2:end);
[n,d]=size(A);
k=5; %low rank
X0=rand(n,k)*sqrt(5/k);
Y0=rand(d,k)*sqrt(5/k);
M0=rand(n,d)*5;

hold on
for i=1:length(lam)
    [X,Y,err]=LowRank(A,X0,Y0,iter_max,tol,lam(i));    
    plot(err);
end
title('Low-rank factorization')
xlabel('iteration')
ylabel('norm of error')
legend('$\lambda=0.01$','$\lambda=0.05$','$\lambda=0.1$','$\lambda=0.5$', ...
    '$\lambda=1$','$\lambda=5$','$\lambda=10$','Interpreter','latex');
hold off

figure;
hold on
for i=1:(length(lam)-2)
    [M,err]=NuclearTrick(A,M0,iter_max,tol,lam(i));
    plot(err);
end
title('Nuclear norm trick')
xlabel('iteration')
ylabel('norm of error')
legend('$\lambda=0.01$','$\lambda=0.05$','$\lambda=0.1$','$\lambda=0.5$', ...
    '$\lambda=1$','Interpreter','latex');
hold off

k=5;
[idx,C]=kmeans(M,k);


iter_max=1000;
W0=rand(n,k)*sqrt(5/k);
H0=rand(k,d)*sqrt(5/k);
alpha=[1e-3,5e-4,1e-4,5e-5,1e-5];
figure;
hold on
for i=1:5
    [W,H,err]=PGD(M,W0,H0,alpha(i),iter_max,tol);
    plot(err);
end
[W,H,err]=LeeSeung(M,W0,H0,iter_max,tol);
plot(err);
title('Projected gradient descend with different alpha and Lee Seung')
xlabel('iteration')
ylabel('norm of error')
legend('$\alpha=0.001$','$\alpha=0.005$','$\alpha=0.0001$','$\alpha=0.0005$','$\alpha=0.00001$','LeeSeung','Interpreter','latex');
hold off

