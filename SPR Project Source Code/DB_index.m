function DB=DB_index(chr,num,x)
[~,ly]=size(chr);
l_gr=ly-num-1;
counter=zeros(1,l_gr);
sum1=zeros(1,l_gr);
sum2=zeros(1,l_gr);
d2x=zeros(1,l_gr);
mu1=zeros(l_gr,2);
d2mu=zeros(l_gr,l_gr);
m_s=zeros(1,l_gr);
m_sum=zeros(1,l_gr);
DBB=0;
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
       if counter(1,i)==0
           DBB=10^10;
       end
  end

%compute sum of distance each element from own class in each class
for i=1:l_gr
    [~,iy,~]=find(chr(1,1:num)==i);
    d2x1=xx(iy,1)-mu1(i,1);
    d2x2=xx(iy,2)-mu1(i,2);
    d2x(1,i)=sum(d2x1.*d2x1+d2x2.*d2x2);
end

%normalize intra distance
% for i=1:l_gr
% d2x(1,i)=d2x(1,i)/counter(1,i);
% end
%d2x(1,:)=d2x(1,:)./counter(1,:);
%compute distance bitween centroid of two class
for i=1:l_gr
    for j=i+1:l_gr
    d2mu(i,j)=(mu1(i,:)-mu1(j,:))*(mu1(i,:)-mu1(j,:)).';
    d2mu(j,i)=d2mu(i,j);
    end
end
 if d2mu==0
      DBB=10^10;
 end

%compute max value of main relation of db-index for each class
for i=1:l_gr
    for j=1:l_gr
        if (j~=i)
            m_s(1,j)=(d2x(1,i)+d2x(1,j))/(d2mu(i,j));
        end
    end
    m_sum(1,i)=max(m_s);
end

%finally compute db-index
 if ly<=num+2
         DBB=10^10;
 elseif ly>=num+12
     DBB=10^10;
 end
 if DBB~=10^10
    DB=(1/l_gr)*sum(m_sum);
    
 else
      DB=10^10;
 end
end