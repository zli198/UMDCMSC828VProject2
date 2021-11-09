function [X,Y,err]=LowRank(M,X,Y,iter_max,tol,lambda)
    [n,d] = size(M);
    k=size(X,2);
    TF = ~isnan(M);
    %disp(TF);
    err = zeros(iter_max,1);
    %iter = 1;
    for i = 1:iter_max
        for j=1:n
            M_Omega=M(j,TF(j,:))';
            Y_Omega=Y(TF(j,:),:);
            X(j,:)=((Y_Omega'*Y_Omega+lambda*eye(k))\(Y_Omega'*M_Omega));
        end
        for j=1:d
            M_Omega=M(TF(:,j),j);
            X_Omega=X(TF(:,j),:);
            Y(j,:)=((X_Omega'*X_Omega+lambda*eye(k))\(X_Omega'*M_Omega))';
        end
        res=M-X*Y';
        err(i)=norm(res(TF),'fro');
        if err(i)<tol
            err=err(1:i);
            break;
        end
    end
end