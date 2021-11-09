%% Initialization
MatTable = MovRankData(:,2:end);
Mat = MatTable{:,:};                %Make the incomplete matrix
Omega = isnan(Mat);                 %Find index set where value is missing
O_ind = abs(Omega - ones(size(Omega))); %this is 0 if nan occurs in Mat
Init = Mat;
Init(Omega)=0;
rank = min(size(Mat));              %Rank
[U,S,V]=svd(Init);                  %SVD
Ut = U(:, 1:rank);                  %Truncated U
St = S(1:rank, :);                  %Truncated singular values
%lambda=0.1;
Ss = St-lambda*eye(size(St));
Ss(Ss<0)=0;
X = Ut*sqrt(Ss);
Y = V*sqrt(Ss);

%% Low rank factorization
lambdalist = [0.01,0.05,0.1,0.5,1,5,10];
errorlist = nan(length(lambdalist),1);
for j=1:length(lambdalist)
    for k=1:100
        Xnew= nan(size(Mat,1),rank);
        Ynew= nan(rank,size(Mat,2));
        for i=1:size(Mat,1)
            Xnew(i,:) = findx(i,Y,Mat,O_ind,lambda);
        end
        X=Xnew;
        for j=1:size(Mat,2)
            Ynew(:,j) = findy(j,X,Mat,O_ind,lambda);
        end
        Y=Ynew;
    end
    Comp_LRF = X*Y;
    errorlist(j) = norm((Init - Comp_LRF).*O_ind, 'fro');
end
figure()
plot(lambdalist, errorlist, "r.")
title('Low-rank factorization')
xlabel('lambda')
ylabel('Norm of error')

%% Nuclear norm trick
M = Init;
errorlist2 = nan(length(lambdalist),1);
for j=1:length(lambdalist)
    for k=1:100
        M = update(M,Mat,lambda);
    end
    Comp_N = M;
    errorlist(j) = norm((Init - Comp_N).*O_ind, 'fro');
end
figure()
plot(lambdalist, errorlist2, "r.")
title('Nuclear norm trick')
xlabel('lambda')
ylabel('Norm of error')

%% Usage
function[xi] = findx(i,Y,A,Ind,lam)
    j = logical(Ind(i,:));
    Yj = Y(:,j);
    Aj = A(i,j);
    xi = Aj*pinv(Yj'*Yj-lam*eye(size(Yj'*Yj)))*Yj';
end

function[yj] = findy(j,X,A,Ind,lam)
    i = logical(Ind(:,j));
    Xi = X(i,:);
    Ai = A(i,j);
    yj = pinv(Xi'*Xi-lam*eye(size(Xi'*Xi)))*Xi'*Ai;
end

function[Mnew] = update(M,A,lam)
    AmMt = A-M;
    AmMt(isnan(AmMt))=0;
    Mat = M+AmMt;
    [U,S,V] = svd(Mat);
    Ss= S-lam*eye(size(S));
    Ss(Ss<0)=0;
    Mnew = U*Ss*V';
end