function [index,element] = k_means(X,k)
% Perform k means algorithm for given data X
%   k is the desired number of clusters
%   X is data matrix, where rows corresponding to points.
dim=size(X,2);
n = size(X,1);
init = randperm(n,k);
centroids = nan(k,dim);
for i=1:k
    centroids(i,:)=X(init(i),:);
end
centroids_old=centroids;
distmat = nan(n,k);
for j=1:n
    for h=1:k
        distmat(j,h)=dist(X(j,:),centroids(h,:));
    end
end
mins = min(distmat, [], 2);
labels = nan(n,1);
for i=1:n
    disti = distmat(i,:);
    labels(i) = find(disti==mins(i));
end
for j=1:k
    cluster = X(labels==j,:);
    centroids(j,:) = findcenter(cluster);
end
iters = 1;
while norm(centroids-centroids_old) > 0.01 && iters<100000
    iters=iters+1;
    if mod(iters,1000)==0
        msg = ["Current iter:", iters];
        disp(msg)
    end
    centroids_old=centroids;
    for j=1:n
        for h=1:k
            distmat(j,h)=dist(X(j,:),centroids(h,:));
        end
    end
    mins = min(distmat, [], 2);
    for i=1:n
        disti = distmat(i,:);
        possiblelabs = find(disti==mins(i));
        labels(i) = possiblelabs(1);
    end
    for j=1:k
        cluster = X(labels==j,:);
        centroids(j,:) = findcenter(cluster);
    end

end
index = labels;
element = cell(k,1);
for j=1:k
    cluster = X(labels==j,:);
    element{j} = cluster;
end
end


function [d] = dist(x,y)
    d = sqrt(sum((x-y).^2));
end

function [c] = findcenter(X)
    S = sum(X,1);
    c = S.^(1/(size(X,1)));
end