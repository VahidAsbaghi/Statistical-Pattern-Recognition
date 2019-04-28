function x=samp_gen(sigma,mu,num,prob)
m=mu;
N=num;
s=N/4;
[Phi,Lam]=eig(sigma);

%generate N number with normal distribution whithout use of matlab function

ii=-2:1/s:2;
rr=0:0.001:1;
ii1=ii(randperm(length(ii)));
ii2=ii(randperm(length(ii)));
j=1;

jj=1;
while jj<=N
    pt=rand;
    jt=jj;
    if pt<=prob
        while jj~=jt+1
            pl=randi([1,N+1]);
            rr=rr(randperm(length(rr)));
            p=rr(randi([1 length(rr)]));
            if p<(1/((2*pi)^0.5))*exp((-1/2)*ii1(pl)^2)
                y(j,1)= ii1(pl);
                j=j+1;
                jj=jj+1;
            end
        end
    else
        jj=jj+1;
    end
end
j=1;
N=length(y);
while j<=N
    for i=1:N
        rr=rr(randperm(length(rr)));
        p=rr(randi([1 length(rr)]));
        if j==N+1
            break;
        end
        if p<(1/((2*pi)^0.5))*exp((-1/2)*ii2(i)^2)
            y(j,2)= ii2(i);
            j=j+1;
        end
    end
end


x=Phi*Lam^(0.5)*y';

x(1,:)=x(1,:)+m(1);
x(2,:)=x(2,:)+m(2);
x=x';

end