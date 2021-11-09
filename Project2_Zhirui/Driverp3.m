clearvars
close all
[M,Mcounts,y,words] = readdata();
[n,d]=size(M);


err1=nan(8,1);
err2=0;
abserr=nan(19,1);


for k=2:20
    flagi = randperm(4,1);
    flagj = randperm(10,1);
    flagr = k*randperm(8,1);
    for i=1:4
        c=2^(i-1)*10;
        ratioerr=zeros(8,1);
        for r=k:k:(8*k)
            for j=1:10
                if i==flagi && j==flagj && r==flagr
                    disp(['k=',num2str(k)])
                    [C,U,R,err1(r/k),err2]=pCUR(M,k,c,r,words);
                    disp('---------------------------------------------')
                else
                    [C,U,R,err1(r/k),err2]=CUR(M,k,c,r);
                end
                ratioerr(r/k)=ratioerr(r/k)+err1(r/k)/err2;
            end
        end
        ratioerr=ratioerr/10;
        figure(i);
        hold on
        plot(ratioerr);
    end
    abserr(k-1)=err2;
end

for k=2:20
    for i=1:4
        r=2^(i-1)*10;
        ratioerr=zeros(8,1);
        for c=k:k:(8*k)
            for j=1:10
                [C,U,R,err1(c/k),err2]=CUR(M,k,c,r);
                ratioerr(c/k)=ratioerr(c/k)+err1(c/k)/err2;
            end
        end
        ratioerr=ratioerr/10;
        figure(i+4);
        hold on
        plot(ratioerr);
    end
end

for l=1:4 
    figure(l);
    title(['CUR,c=',num2srt(2^(l-1)*10)])
    xlabel('r/k')
    ylabel('Mean ratio norm')
    legend('k=2','k=3','k=4','k=5','k=6','k=7','k=8','k=9','k=10','k=11', ...
        'k=12','k=13','k=14','k=15','k=16','k=17','k=18','k=19','k=20');
end

for l=5:8
    figure(l);
    title(['CUR,r=',num2srt(2^(l-5)*10)])
    xlabel('c')
    ylabel('Mean ratio norm')
    legend('k=2','k=3','k=4','k=5','k=6','k=7','k=8','k=9','k=10','k=11', ...
        'k=12','k=13','k=14','k=15','k=16','k=17','k=18','k=19','k=20');
end

figure(9)
plot(abserr)
xlabel('k')
ylabel('$\|M-M_k\|$','Interpreter','latex')