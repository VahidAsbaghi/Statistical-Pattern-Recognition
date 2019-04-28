function SSE1=SSE_i(chr,num,x)
[~,ly]=size(chr);
l_gr=ly-num-1;
counter=zeros(1,l_gr);
sum1=zeros(1,l_gr);
sum2=zeros(1,l_gr);
d2x=zeros(1,l_gr);
mu1=zeros(l_gr,2);
d2mu=zeros(l_gr,l_gr);
xx=zeros(num,2);
%cumpute sum and number of class elements

for i=1:num
   xx(i,:)=x{1,i}(1,:);
end

for i=1:l_gr
    [~,iy,v]=find(chr(1,1:num)==i);
    counter(1,i)=sum(v);
    sum1(1,i)=sum(xx(iy,1));
    sum2(1,i)=sum(xx(iy,2));
end
    
%compute mean value of each class
mu1(:,1)=sum1(1,:)./counter(1,:);
mu1(:,2)=sum2(1,:)./counter(1,:);

for i=1:l_gr
    [~,iy,~]=find(chr(1,1:num)==i);
    d2x1=xx(iy,1)-mu1(i,1);
    d2x2=xx(iy,2)-mu1(i,2);
    d2x(1,i)=sum(d2x1.*d2x1+d2x2.*d2x2);
end


d2x=d2x./counter;


%compute distance bitween centroid of two class
for i=1:l_gr
    d2mu(i,i)=0;
    for j=i+1:l_gr
    d2mu(i,j)=(mu1(i,:)-mu1(j,:))*(mu1(i,:)-mu1(j,:)).';
    d2mu(j,i)=0;
    end
end

ST=sum(sum(d2mu));

SSEb=sum(d2x);

SSE1=SSEb/ST;
end
