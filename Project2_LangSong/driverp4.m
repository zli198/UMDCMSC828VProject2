clearvars
close all
[M,Mcounts,y,words] = readdata();
[n,d]=size(M);
figure(10)
i1 = find(y==-1);
i2 = find(y==1);
ii = find(M>0);
n1 = length(i1);
n2 = length(i2);
M = full(M);
Mfreq = sum(M,1)/n;
M1freq = sum(M(i1,:),1)/n1;
M2freq = sum(M(i2,:),1)/n2;
IG = abs(M1freq-M2freq).*Mfreq; % information gain
[IGtop,IGidx]=sort(IG,'descend');
topIG=IGidx(1:20);
words(topIG);
k=10;
idx=fscchi2(M,y);
Mnew=M(:,idx(1:1000));
wordsnew=words(idx(1:1000));

[~,~,V]=svd(Mnew,'econ');
V_k=V(:,1:k);
p=1/k*sum(V_k.^2,2);
[ptop,pidx]=sort(p,'descend');
toplev=pidx(1:20);
for i=1:20
    disp(wordsnew{toplev(i)})
end

[~,Y]=pca(Mnew(:,pidx(1:5)));
Y=Y(:,1:2);
plot(Y(y==1,1),Y(y==1,2),'*');
hold on
plot(Y(y==-1,1),Y(y==-1,2),'o');
title('Projection of data to 2D space using PCA with 5 columns')
xlabel('Eigen-feature 1')
xlabel('Eigen-feature 2')
legend('category 2','category 1')