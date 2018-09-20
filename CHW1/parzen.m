function phat=parzen(N,bound,hn)
a=bound(1);
b=bound(2);
px=1/(b-a);
i=a;
l=1;
while i<=b
    smpl(l)=i;
    l=l+1;
    i=i+0.0001;
end
i=1;
while i<=N
    prand=rand;
    rr=randi([1,length(smpl)]);
    if prand>px
        sel_samp(i)=smpl(rr);
        i=i+1;
    end
end

kr=zeros(N,N);
phat1=zeros(N,N);
for j=1:N
    kr(:,j)=(sel_samp-sel_samp(j))./hn;
    phat1(:,j)=(1/(N*hn))*(1/((2*pi)^0.5))*exp(-0.5*(kr(:,j).^2));    
end
phat=sum(phat1);

[sel_samp_sort,I]=sort(sel_samp);
phat(1:N)=phat(I);
end