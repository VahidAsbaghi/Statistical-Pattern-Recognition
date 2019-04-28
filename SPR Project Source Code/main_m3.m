function [R,NODC]=main_m3(n_class,num,method,n_island,Pop,Gen,Pe,Pbf,Pbi,Pmf,Pmi,Pcf,Pci)
prob=1/n_class;
mu=zeros(2,n_class);
ra=randperm(2*n_class);
ra1=randperm(2*n_class);
sigma=[0.3^2,0;0,0.3^2];
xx=cell(n_class,1);
input=zeros(2,num);
input(1,:)=1:num;
for i=1:n_class
    mu(1,i)=ra(i)/2;
    mu(2,i)=ra1(i)/3;
end
t=0;
x=cell(1,num);
a1=0;
a2=0;
a3=0;
figure;
hold on;
for i=1:n_class-1
    xx{i,1}=samp_gen(sigma,mu(:,i),num,prob);
    gcf=scatter(xx{i,1}(:,1),xx{i,1}(:,2),'*');
    set(gcf,'MarkerEdgeColor',[a1,a2,a3]);
    a1=rand;
    a2=rand;
    a3=rand;
    l=length(xx{i,1});
    for j=1:l
    x{1,j+t}=xx{i,1}(j,:);
    end
    input(2,t+1:t+l)=i;
    t=t+l;    
end
ll=num-t;
xx{n_class,1}=samp_gen(sigma,mu(:,n_class),ll,1);
scatter(xx{n_class,1}(:,1),xx{n_class,1}(:,2),'*');
set(gcf,'MarkerEdgeColor',[a1,a2,a3]);
for i=1:ll
    x{1,i+t}=xx{n_class,1}(i,:);
end
input(2,t+1:num)=n_class;

[fitnes,pop,DB]=genetic_m(x,num,method,n_island,Pop,Gen,Pe,Pbf,Pbi,Pmf,Pmi,Pcf,Pci,n_class);
[~,ly]=size(fitnes);
for i=1:ly
    [c(i),I(i)]=max(fitnes(:,i));
end
[~,II]=max(c);
best_ind=pop{I(II),II};
R=show_result(best_ind,x,input,num,n_class);
NODC=length(best_ind)-num-1;
end
    


