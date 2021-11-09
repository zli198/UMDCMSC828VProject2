function [W,H,err]=LeeSeung(A,W,H,iter_max,tol)
    err=zeros(iter_max,1);
    for j=1:iter_max        
        W=W.*(A*H')./(W*(H*H'));
        H=H.*(W'*A)./(W'*W*H);
        err(j)=norm(A-W*H,'fro');
        if err(j)<tol
            err=err(1:j);
            break;
        end
    end   
end