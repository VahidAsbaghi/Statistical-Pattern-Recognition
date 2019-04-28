function new_pop=replacem(pop_temp,fit_temp,pop,fitnes,l_island)
elite=0.1;
rand_i=0.1;
l_elit=round(elite*l_island);
l_rand=round(rand_i*l_island);
new_pop=cell(l_island,1);
for i=1:l_elit
    [~,I]=max(fitnes);
    new_pop{i,1}=pop{I,1};
    fitnes(I,1)=min(fitnes)-2;
end
for i=l_elit+1:l_elit+l_rand
    ra=randi([1,l_island]);
    new_pop{i,1}=pop{ra,1};
end
for j=l_rand+l_elit+1:l_island
    [~,I]=max(fit_temp);
    new_pop{j,1}=pop_temp{I,1};
    fit_temp(I,1)=0;
end
    
end