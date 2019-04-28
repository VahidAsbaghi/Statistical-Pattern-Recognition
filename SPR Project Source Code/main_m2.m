function [R,NODC]=main_m2(n_class,num,method,n_island,Pop,Gen,Pe,Pbf,Pbi,Pmf,Pmi,Pcf,Pci)

mu1=[0,2];
mu2=[-1,-1];
mu3=[2,-1];
sigma1=[1^2,0;0,0.8^2];
sigma2=[0.6^2,0;0,0.4^2];
sigma3=[0.3^2,0;0,0.5^2];
figure;
title('samples');
hold on;
x1=samp_gen(sigma1,mu1,num,0.5);
x2=samp_gen(sigma2,mu2,num,0.33);

l1=length(x1);
l2=length(x2);
sum_m=l1+l2;
l3=num-sum_m;
x3=samp_gen(sigma3,mu3,l3,1);

scatter(x3(:,1),x3(:,2),'*','MarkerEdgeColor','b');
scatter(x1(:,1),x1(:,2),'*','MarkerEdgeColor','r');
scatter(x2(:,1),x2(:,2),'*','MarkerEdgeColor','g');

x=cell(1,num);
parfor i=1:l1
x{1,i}=x1(i,:);
end
parfor i=1:l2
x{1,i+l1}=x2(i,:);
end
lt=l1+l2;
parfor i=1:l3
x{1,i+lt}=x3(i,:);
end

input(1,:)=1:num;
for i=1:num
    if input(1,i)<=l1       
        input(2,i)=1;
    elseif input(1,i)<=l1+l2       
        input(2,i)=2;
    else        
        input(2,i)=3;
    end
end


[fitnes,pop,DB]=genetic_m(x,num,method,n_island,Pop,Gen,Pe,Pbf,Pbi,Pmf,Pmi,Pcf,Pci,n_class);
[~,ly]=size(fitnes);
for i=1:ly
    [c(i),I(i)]=max(fitnes(:,i));
end
[~,II]=max(c);
best_ind=pop{I(II),II};
R=show_result(best_ind,x,input,num,n_class);
NODC=length(best_ind)-num-1;