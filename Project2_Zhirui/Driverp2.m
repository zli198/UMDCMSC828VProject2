k=5;
[ind,e]=k_means(M,k);


iter_max=1000;
W0=rand(n,k)*sqrt(5/k);
H0=rand(k,d)*sqrt(5/k);
alpha=[1e-3,5e-3,1e-4,5e-4,1e-5];
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
legend('$\alpha=0.001$','$\alpha=0.005$','$\alpha=0.0001$','$\alpha=0.0005$', ...
    '$\alpha=0.00001$','LeeSeung','Interpreter','latex');
hold off