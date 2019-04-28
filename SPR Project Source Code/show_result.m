function R=show_result(best_ind,x,input,num,n_clas)

figure;
hold on;
for i=1:num
    if best_ind(i)==1
        scatter(x{1,i}(1,1),x{1,i}(1,2),'*','MarkerEdgeColor','r');
    elseif best_ind(i)==2
        scatter(x{1,i}(1,1),x{1,i}(1,2),'*','MarkerEdgeColor','g');
    elseif best_ind(i)==3
        scatter(x{1,i}(1,1),x{1,i}(1,2),'*','MarkerEdgeColor','b');
    elseif best_ind(i)==4
        scatter(x{1,i}(1,1),x{1,i}(1,2),'*','MarkerEdgeColor','c');
    elseif best_ind(i)==5
        scatter(x{1,i}(1,1),x{1,i}(1,2),'*','MarkerEdgeColor','m');
    elseif best_ind(i)==6
        scatter(x{1,i}(1,1),x{1,i}(1,2),'*','MarkerEdgeColor','y');
    elseif best_ind(i)==7
        scatter(x{1,i}(1,1),x{1,i}(1,2),'*','MarkerEdgeColor','k');
    elseif best_ind(i)==8
        gcf=scatter(x{1,i}(1,1),x{1,i}(1,2),'*');
        set(gcf,'MarkerEdgeColor',[0.2,1,0.6]);
    elseif best_ind(i)==9
        gcf=scatter(x{1,i}(1,1),x{1,i}(1,2),'*');
        set(gcf,'MarkerEdgeColor',[0.7,0.2,0.3]);
    elseif best_ind(i)==10
        gcf=scatter(x{1,i}(1,1),x{1,i}(1,2),'*');
        set(gcf,'MarkerEdgeColor',[0.5,0.5,1]);
    end
end

l=zeros(1,n_clas);
for j=1:n_clas
    [~,~,v]=find(input(2,:)==j);
    l(1,j)=sum(v);
end
t=0;

for i=1:n_clas
    chr=best_ind(1,t+1:t+l(1,i));
    p=0;
    cl_c=zeros(1,3*n_clas);
    for j=1:l(1,i)
        cl_c(1,chr(1,j))=cl_c(1,chr(1,j))+1;
    end
    t=t+l(1,i);
    [~,I]=max(cl_c);
    [~,iy,~]=find(best_ind(1,1:num)==I);
    [~,iy1,~]=find(best_ind(1,1:num)==i);
    for k=1:i
        if I==k
            p=1;
        end
    end
    if p==0
        best_ind(1,iy)=i;
        best_ind(1,iy1)=I;
    end
end
C=confusionmat(input(2,:),best_ind(1,1:num));
TP=zeros(n_clas,1);
TN=zeros(n_clas,1);
FP=zeros(n_clas,1);
FN=zeros(n_clas,1);
for i=1:n_clas
    TP(i)=(C(i,i));
    FN(i)=sum(C(i,:))-C(i,i);
    FP(i)=sum(C(:,i))-C(i,i);
    TN(i)=num-FN(i)-FP(i)-TP(i);
end
TP1=mean(TP);
TN1=mean(TN);
FP1=mean(FP);
FN1=mean(FN);
R=(TP1+TN1)/(TP1+TN1+FP1+FN1);

end
