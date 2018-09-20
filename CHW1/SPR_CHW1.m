%CHW1 Statistical Pattern Recognition
%vahid asbaghi
function [mm,sss,msighat,sigs,x]=SPR_CHW1(it,N,sigma,m)
%%
%generate N samples for sigma and m given by normal distributive.
%this function do purely without use of matlab normal distributive function
%%
sigmahat=zeros(2,2,10);
mhat=zeros(10,2);
n=length(sigma(:,1));
I=[1,0;0,1];
s=N/10;
%it=10;
%diagnolization
[Phi,Lam]=eig(sigma);
A=Lam^(-0.5)*Phi';

%generate N number with normal distribution whithout use of matlab function
for tt=1:it
    ii=-5:1/s:5;
    rr=0:0.001:1;
    ii1=ii(randperm(length(ii)));
    ii2=ii(randperm(length(ii)));
    j=1;
    y=zeros(N,2);
    while j<=N
        jj=j;
        for i=1:N
            rr=rr(randperm(length(rr)));
            p=rr(randi([1 length(rr)]));
            if j==N+1
                break;
            end
            if p<exp((-1/2)*ii1(i)^2)
                y(j,1)= ii1(i);
                j=j+1;
            end
        end
    end
    j=1;
    while j<=N
        jj=j;
        for i=1:N
            rr=rr(randperm(length(rr)));
            p=rr(randi([1 length(rr)]));
            if j==N+1
                break;
            end
            if p<exp((-1/2)*ii2(i)^2)
                y(j,2)= ii2(i);
                j=j+1;
            end
        end
    end
    
    %AA=(A)^(-1);
    x=Phi*Lam^(0.5)*y';
    %x=AA*y';
    x(1,:)=x(1,:)+m(1);
    x(2,:)=x(2,:)+m(2);
    x=x';
    
    xt=zeros(N,2);
    mhat(tt,:)=sum(x(:,1:2))./N;
    xt(:,2)=x(:,2)-mhat(tt,2);
    xt(:,1)=x(:,1)-mhat(tt,1);
    sigmahat(:,:,tt)=(xt'*xt)./(N-1);
end
figure;
    subplot(2,2,1); scatter(x(:,2),exp((-1/2)*(x(:,2)-m(2)).^2));
    title('x2 distribution');
    subplot(2,2,2); scatter(x(:,1),exp((-1/2)*(x(:,1)-m(1)).^2));
    title('x1 distribution');
    subplot(2,2,3); scatter(1:N,x(:,2),'*',...
        'MarkerEdgeColor','r');
    title('x2 distribution about mean');
    subplot(2,2,4); scatter(1:N,x(:,1),'*',...
        'MarkerEdgeColor','r');
    title('x1 distribution about mean');
    
mm(1)=sum(mhat(:,1))/it;
mm(2)=sum(mhat(:,2))/it;
for e=1:it
em(e,:)=mhat(e,:)-mm;
end
sss(1)=(em(:,1)'*em(:,1))/it;
sss(2)=(em(:,2)'*em(:,2))/it;

msighat(1,1)=sum(sigmahat(1,1,1:it))/it;
msighat(1,2)=sum(sigmahat(1,2,1:it))/it;
msighat(2,1)=sum(sigmahat(2,1,1:it))/it;
msighat(2,2)=sum(sigmahat(2,2,1:it))/it;
for h=1:it
ex(:,:,h)=sigmahat(:,:,h)-msighat;
end
ex1(1,1:it)=ex(1,1,:);
ex1(2,1:it)=ex(1,2,:);
ex1(3,1:it)=ex(2,1,:);
ex1(4,1:it)=ex(2,2,:);
sigs(1,1)=(ex1(1,:)*ex1(1,:)')./(it);
sigs(1,2)=(ex1(2,:)*ex1(2,:)')./(it);
sigs(1,3)=(ex1(3,:)*ex1(3,:)')./(it);
sigs(1,4)=(ex1(4,:)*ex1(4,:)')./(it);
end
