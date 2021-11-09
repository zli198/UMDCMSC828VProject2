function [C,U,R,err1,err2]=CUR(M,k,c,r)
    C=ColumnSelect(M,k,c);
    R=ColumnSelect(M',k,r);
    R=R';
    U=pinv(C)*M*pinv(R);
    err1=norm(M-C*U*R,'fro');
    s_M = svd(M,'econ');
    err2=norm(s_M(k+1:end));
end

function C=ColumnSelect(A,k,c)
    [~,~,V]=svd(A,'econ');
    V_k=V(:,1:k);
    p=1/k*sum(V_k.^2,2);
    pr=min(1,c*p);
    uni=rand(size(p));
    C=A(:,(uni<pr));
end


