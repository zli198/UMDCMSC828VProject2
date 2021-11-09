function[score] = nsls_full(M, k)
    dim = size(M,2);
    score = nan(dim,1);
    [~,~,V] = svd(M,'econ');
    Vuse = V(:,1:k);
    Vuse = Vuse.^2;
    S = sum(Vuse,2);
    for j=1:dim
        score(j) = 1/k*(S(j));
    end
end