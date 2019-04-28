function selpop=selection(pop,fitnes)
[xx,~]=size(fitnes);

[~,IX]=sort(fitnes,'descend');
pop=pop(IX,1);
rank=xx:-1:1;
fitnes=2*rank./xx*(xx+1);
    
selpop=cell(1,2);
q=cumsum(fitnes);
t=1;
temp=0;
j=zeros(1,2);
while t<=2
    r=randi([1,100000])/100000;
    if r<q(1) && temp~=1
        j(1,t)=1;
        t=t+1;
        temp=1;
    else
        for k=2:xx
            if r<q(k) && temp~=k
                j(1,t)=k;
                t=t+1;
                temp=k;
                break;
            end
        end
    end
end
selpop{1,1}=pop{j(1,1),1};
selpop{1,2}=pop{j(1,2),1};
end