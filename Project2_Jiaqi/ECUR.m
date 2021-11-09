function [C,U,R,err1,err2]=ECUR(M,k,c,r)
    C=exactColumnSelect(M,k,c);
    R=exactColumnSelect(M',k,r);
    R=R';
    U=pinv(C)*M*pinv(R);
    err1=norm(M-C*U*R,'fro');
    err2=norm(svd(M(k+1:end)),'fro');
end


function C=exactColumnSelect(A,k,c)
    [~,~,V]=svd(A,'econ');
    V_k=V(:,1:k);
    p=1/k*sum(V_k.^2,2);
    S=zeros(size(A,2),c);
    D=zeros(c,c);
    for t=1:c
        CD=cumsum(p);
        R=rand;
        it=find(R<CD,1,"first");
        S(it,t)=1;
        D(t,t)=1/(sqrt(c*p(it)));
    end
    C=A*S*D;
end
