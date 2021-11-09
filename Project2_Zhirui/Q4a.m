[M,Mcounts,y,words] = readdata();
IG = infogain(M,y);
TH = maxk(IG,5);
INDEX = find(IG>=TH(end));
for i=1:length(INDEX)
    disp(words{INDEX(i)})
end