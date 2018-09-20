function tr=kdtree(inp,j)
[x,~]=size(inp);
xx=x;
s=cell(1,200);
inp1=sortrows(inp,j);
N=x;
s{1}=[inp1 ; [j,0,-11]];
i=1;
k=1;
while k<=xx
    k=k+1;
    inp=s{i};
    if ~isempty(inp)
        N=length(inp(:,1))-1;
    end
    if N<=0 || isempty(inp)
        tr(i,:)=[-10,-10,0];
        i=i+1;
        k=k-1;
        continue;
    end
    x=N;
    inp1=0;
    inp1=inp;
    N=round(N/2);
    j=inp(x+1,1);
    if (j==1)
        j=2;
    else
        j=1;
    end
    s{2*i}=[sortrows(inp1(1:N-1,:),j) ; [j,0,-11]];
    s{2*i+1}=[sortrows(inp1(N+1:x,:),j) ; [j,0,-11]];
    tr(i,:)=inp1(N,:);
    i=i+1;
end
end
