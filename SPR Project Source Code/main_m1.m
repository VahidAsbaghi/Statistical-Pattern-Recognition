function  [R,NODC]=main_m1(n_class,num,method,n_island,Pop,Gen,Pe,Pbf,Pbi,Pmf,Pmi,Pcf,Pci)

prob=1/n_class;

mu1=[1,-1];
mu2=[-1.5,0];
mu3=[0,1];
mu4=[-1,1];
mu5=[2,-1];
mu6=[-2,-1];
mu7=[-0.5,2];
mu8=[-1,-1];
mu9=[1.5,0];
sigma1=[0.2^2,0;0,0.2^2];
figure;
title('samples');
hold on;
x1=samp_gen(sigma1,mu1,num,prob);
x2=samp_gen(sigma1,mu2,num,prob);
x3=samp_gen(sigma1,mu3,num,prob);
x4=samp_gen(sigma1,mu4,num,prob);
x5=samp_gen(sigma1,mu5,num,prob);
x6=samp_gen(sigma1,mu6,num,prob);
x7=samp_gen(sigma1,mu7,num,prob);
x8=samp_gen(sigma1,mu8,num,prob);
l1=length(x1);
l2=length(x2);
l3=length(x3);
l4=length(x4);
l5=length(x5);
l6=length(x6);
l7=length(x7);
l8=length(x8);
sum_m=l1+l2+l3+l4+l5+l6+l7+l8;
l9=num-sum_m;
x9=samp_gen(sigma1,mu9,l9,1);

scatter(x7(:,1),x7(:,2),'*','MarkerEdgeColor','k');
scatter(x6(:,1),x6(:,2),'*','MarkerEdgeColor','y');
scatter(x5(:,1),x5(:,2),'*','MarkerEdgeColor','m');
scatter(x4(:,1),x4(:,2),'*','MarkerEdgeColor','c');
scatter(x3(:,1),x3(:,2),'*','MarkerEdgeColor','b');
scatter(x1(:,1),x1(:,2),'*','MarkerEdgeColor','r');
scatter(x2(:,1),x2(:,2),'*','MarkerEdgeColor','g');
gcf=scatter(x8(:,1),x8(:,2),'*');
set(gcf,'MarkerEdgeColor',[1,0.4,0.6]);
gcf=scatter(x9(:,1),x9(:,2),'*');
set(gcf,'MarkerEdgeColor',[0.3,0.3,0.3]);

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
lt=lt+l3;
parfor i=1:l4
x{1,i+lt}=x4(i,:);
end
lt=lt+l4;
parfor i=1:l5
x{1,i+lt}=x5(i,:);
end
lt=lt+l5;
parfor i=1:l6
x{1,i+lt}=x6(i,:);
end
lt=lt+l6;
parfor i=1:l7
x{1,i+lt}=x7(i,:);
end
lt=lt+l7;
parfor i=1:l8
x{1,i+lt}=x8(i,:);
end
lt=lt+l8;
parfor i=1:l9
x{1,i+lt}=x9(i,:);
end

input(1,:)=1:num;
for i=1:num
    if input(1,i)<=l1       
        input(2,i)=1;
    elseif input(1,i)<=l1+l2       
        input(2,i)=2;
    elseif input(1,i)<=l1+l2+l3        
        input(2,i)=3;
    elseif input(1,i)<=l1+l2+l3+l4        
        input(2,i)=4;
    elseif input(1,i)<=l1+l2+l3+l4+l5
        input(2,i)=5;
    elseif input(1,i)<=l1+l2+l3+l4+l5+l6
        input(2,i)=6;
    elseif input(1,i)<=l1+l2+l3+l4+l5+l6+l7
        input(2,i)=7;
    elseif input(1,i)<=l1+l2+l3+l4+l5+l6+l7+l8
        input(2,i)=8;
    else
        input(2,i)=9;
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