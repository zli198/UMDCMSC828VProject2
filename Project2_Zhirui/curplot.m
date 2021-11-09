function [C,U,R] = cur(M,c,r,k)
%CUR decomposition
%   c and r are row and col constants, k is pca value
C = columnselect(M,k,c);
R = columnselect(M',k,r);
R=R';
disp(size(C));
disp(size(R));
U = pinv(C)*M*pinv(R);
end


function [C] = columnselect(M,k,c)
sizej = size(M,2);
[~,~,V]=svd(M,'econ');
pivec = nan(sizej,1);
C = [];
for j=1:sizej
    pivec(j)=nsls(V,k,j);
    if keep(pivec(j),c)
        C = [C,M(:,j)];
    end
end
end

function[boo] = keep(score,c)
prob = min(1,c*score);
boo = false;
if prob==1
    boo= true;
else
    x = rand;
    if x<=prob
        boo = true;
    end
end
end

function[score] = nsls(V,k,j)
    Vuse = V(:,k);
    Vuse = Vuse.*2;
    S = sum(Vuse,2);
    score = 1/k*(S(j));
end