function [W,H,err]=PGD(A,W,H,alpha,iter_max,tol)
    err=zeros(iter_max,1);
    for j=1:iter_max        
        R=A-W*H;
        W=max(W+alpha*R*H',0);
        H=max(H+alpha*W'*R,0);
        err(j)=norm(A-W*H,'fro');
        if err(j)<tol
            err=err(1:j);
            break;
        end
    end   
end