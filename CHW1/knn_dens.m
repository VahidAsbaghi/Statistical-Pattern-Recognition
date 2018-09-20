function phat=knn_dens(N,K,bound)
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
dist=zeros(N,N);

for j=1:N
    dist(:,j)=abs(sel_samp-sel_samp(j));
end
[dist(:,1:N),IX(:,1:N)]=sort(dist(:,1:N),'ascend');

for i=1:N
    nbr(i)=IX(K+1,i);
    dis_nbr(i)=dist(K+1,i);
    phat(i)=K/(N*2*dis_nbr(i));
end
[sel_samp_sort,I]=sort(sel_samp);
phat(1:N)=phat(I);
end
