function S=S_index(chr,num,x)
l=length(chr);
l_gr=l-num-1;
d2x=zeros(1,num);
count_c=zeros(1,l_gr);
dd2x=zeros(num,l_gr);
b=zeros(1,num);
s=zeros(1,num);
sum_s=zeros(1,l_gr);
xx=zeros(num,2);
flag=0;
%compute: number of elememnts in each class. sum of intra class distance
%for each element and sum of extra distance for each elements.

parfor i=1:num
    xx(i,:)=x{1,i}(1,:);
end

for i=1:l_gr
    [~,~,v]=find(chr(1,1:num)==i);
    count_c(1,i)=sum(v);
    if count_c(1,i)==0
        flag=1;
    end
end
for i=1:num
    [~,iy,~]=find(chr(1,1:num)==chr(1,i));
    d2x1=((xx(i,1)-xx(iy,1)));
    d2x2=((xx(i,2)-xx(iy,2)));
    d2x(1,i)=sum(d2x1.*d2x1+d2x2.*d2x2);
end

for i=1:num
    for j=1:l_gr
        if j~=chr(1,i)
            [~,iy,~]=find(chr(1,1:num)==j);
            d2x1=((xx(i,1)-xx(iy,1)));
            d2x2=((xx(i,2)-xx(iy,2)));
            dd2x(i,j)=sum(d2x1.*d2x1+d2x2.*d2x2);
        end
    end
end

%% normalize distances
for i=1:l_gr
     [~,iy,~]=find(chr(1,1:num)==i);
     d2x(1,iy)=d2x(1,iy)/count_c(1,i);
     dd2x(:,i)=dd2x(:,i)/count_c(1,i);
    [ix,~,~]=find(dd2x(1:num,i)==0);
    dd2x(ix,i)=max(max(dd2x));
end

%compute b and s for each element
b(1,:)=min(dd2x.');
s(1,:)=(b(1,:)-d2x(1,:))./max([b(1,:);d2x(1,:)]);

%determine sum of s in each class
for i=1:num
    sum_s(1,chr(1,i))=sum_s(1,chr(1,i))+s(1,i);
end

%normalize sum_s
sum_s=sum_s./count_c;

%finaly determine S-index
if l<=num+3 || l>=num+11 || flag==1
    S=-1;
else
    S=(1/l_gr)*sum(sum_s);
end
end