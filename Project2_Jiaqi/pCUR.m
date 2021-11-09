function [C,U,R,err1,err2]=pCUR(M,k,c,r,w)
    C=ColumnSelectp(M,k,c,w);
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

function C=ColumnSelectp(A,k,c,w)
    [~,~,V]=svd(A,'econ');
    V_k=V(:,1:k);
    p=1/k*sum(V_k.^2,2);
    th = maxk(p,3);
    id = find(p>=th(end));
    for i = 1:3
        fprintf('%s\n',char(w{id(i)}));
    end
    pr=min(1,c*p);
    uni=rand(size(p));
    C=A(:,(uni<pr));
end
