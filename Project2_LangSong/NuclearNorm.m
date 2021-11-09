function [res,err]=NuclearNorm(M,res,iter_max,tol,lambda)
    err=zeros(iter_max,1);
    ept=isnan(M);
    for j=1:iter_max
        res=S_lam(res+P_Omega(M-res,ept),lambda);
        err(j)=norm(P_Omega(M-res,ept),'fro');
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