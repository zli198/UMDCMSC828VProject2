clearvars
close all
[M,Mcounts,y,words] = readdata();
[n,d]=size(M);


for k=[2, 8, 15, 20]
    score = nsls_full(M, k);
    figure(k)
    hold on
    plot(score, '.')
    ylabel("Leverage Score")
    xlabel("Index")
    t = ['Column Leverage Score Plot for k=', num2str(k)];
    title(t)
    hold off
end

for k=[2, 8, 15, 20]
    score = nsls_full(M', k);
    figure(k+20)
    hold on
    plot(score, '.')
    ylabel("Leverage Score")
    xlabel("Index")
    t = ['Row Leverage Score Plot for k=', num2str(k)];
    title(t)
    hold off
end