function [indices,centroids] = k_means(X,k)
    max_iterations = 100;
    randidx = randperm(size(X,1));
    centroids = X(randidx(1:k), :);
    for i=1:max_iterations
        indices = closest(X, centroids);
        centroids_old = centroids;
        centroids = updateCentroids(X, indices, k);
    end
    err = norm(centroids-centroids_old);
    disp(err);
end
  
function idx = closest(X, centroids)
  m = size(centroids, 1);
  n = size(X,1);
  idx = zeros(n, 1);

  for i=1:n
    index = 1;
    min_dist = sum((X(i,:) - centroids(1,:)).^2);
    for j=2:m
        dist = sum((X(i,:) - centroids(j,:)).^2);
        if(dist < min_dist)
          min_dist = dist;
          index = j;
        end
    end
    %disp(min_dist);
    idx(i) = index;
  end
end

function centroids = updateCentroids(X, idx, k)
  [m,n] = size(X);
  centroids = zeros(k, n);
  
  for i=1:k
    xi = X(idx==i,:);
    ck = size(xi,1);
    centroids(i, :) = (1/ck) * sum(xi,1);
  end
end