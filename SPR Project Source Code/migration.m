function pop=migration(fitnes,pop,Pe)
[x,y]=size(fitnes);
for i=1:y
    ra2=rand;
    if ra2<Pe
        [~,I]=max(fitnes(:,i));
        t=0;
        while t==0
            ra=randi([1,y]);
            if ra~=i
                t=1;
            end
        end
        ra1=randi([1,x]);
        pop{ra1,ra}=pop{I,i};
    end
end
end