function [M,err]=NuclearTrick(A,M,iter_max,tol,lam)
    err=zeros(iter_max,1);
    ept=isnan(A);
    for j=1:iter_max
        M=S_lam(M+P_Omega(A-M,ept),lam);
        err(j)=norm(P_Omega(A-M,ept),'fro');
        if err(j)<tol
            err=err(1:j);
            break;
        end
    end
end

function A=P_Omega(A,ept)
    A(ept)=0;
end

function S=S_lam(A,lam)
    [U,Sigma,V]=svd(A,'econ');
    Sigma_lam=max(Sigma-lam*eye(size(Sigma)),0);
    S=U*Sigma_lam*V';
end