function [X,Y,err]=LowRank(A,X,Y,iter_max,tol,lam)
    [n,d]=size(A);
    k=size(X,2);
    nonept=~isnan(A);
    err=zeros(iter_max,1);
    for i=1:iter_max
        for j=1:n
            A_Omega=A(j,nonept(j,:))';
            Y_Omega=Y(nonept(j,:),:);
            X(j,:)=((Y_Omega'*Y_Omega+lam*eye(k))\(Y_Omega'*A_Omega));
        end
        for j=1:d
            A_Omega=A(nonept(:,j),j);
            X_Omega=X(nonept(:,j),:);
            Y(j,:)=((X_Omega'*X_Omega+lam*eye(k))\(X_Omega'*A_Omega))';
        end
        res=A-X*Y';
        err(i)=norm(res(nonept),'fro');
        if err(i)<tol
            err=err(1:i);
            break;
        end
    end
end