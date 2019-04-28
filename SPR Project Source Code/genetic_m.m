function [fitnes,pop,DB]=genetic_m(x,num,method,n_island,Pop,Gen,Pe,Pbf,Pbi,Pmf,Pmi,Pcf,Pci,n_class)

if n_class>=6
    a=6;
    b=8;
else
    a=2;
    b=8;
end
l=num;

pop_size=Pop;

l_island=round(pop_size/n_island);
pop=cell(l_island,n_island);
pop_temp=cell(l_island,1);
for j=1:n_island
    for i=1:l_island
        k=randi([a,b]);
        pop{i,j}(1,1:l)=randi([1,k],1,l);
        pop{i,j}(1,l+1:l+k)=1:k;
        pop{i,j}(1,l+k+1)=0;
    end
end
fitnes=zeros(l_island,n_island);
DB=zeros(l_island,n_island);
% Pci=0.9;
% Pcf=0.3;
% Pmi=0.1;
% Pmf=0.4;
% Pbi=0.08;
% Pbf=0.04;
% Pe=0.6;

other=1;
% Gen=20;
for j=1:Gen
    Pc=Pci+j*(Pcf-Pci)/Gen;
    Pm=Pmi+j*(Pmf-Pmi)/Gen;
    Pb=Pbi+j*(Pbf-Pbi)/Gen;
    for ii=1:n_island
        [fitnes(:,ii),DB(:,ii),pop(:,ii)]=ranking(pop(:,ii),method,l,x);
        it=1;
        for i=1:l_island
            ra=rand;
            selpop=selection(pop(:,ii),fitnes(:,ii));
            if ra<=Pc
                new_chr1=cros_over(selpop,num);
                t=1;
            else
                new_chr1= selpop(1,1);
                t=1;
            end
            ra1=rand;
            if ra1<=Pm
                if other==1
                    [new_chr1,other]=mutation(new_chr1,1,num);
                elseif other==2
                    [new_chr1,other]=mutation(new_chr1,2,num);
                end
                t=1;
            end            
            ra2=rand;
            if ra2<Pb
                chr_inp=new_chr1{1,1};%new_pop{i,1};
                new_chr12=local_search(chr_inp,num,x,method);
                new_chr1{1,1}=new_chr12;
                t=1;
            end
            if t==1
                pop_temp{it,1}=new_chr1{1,1};
                it=it+1;
            end
        end
        [fitnes_temp,~,pop_temp]=ranking(pop_temp,method,l,x);
        new_pop=replacem(pop_temp,fitnes_temp,pop(:,ii),fitnes(:,ii),l_island);
        
        pop(:,ii)=new_pop;
    end
    for ii=1:n_island
        [fitnes(:,ii),~,pop(:,ii)]=ranking(pop(:,ii),method,l,x);
    end
    
    pop=migration(fitnes,pop,Pe);
end
for ii=1:n_island
    [fitnes(:,ii),~,pop(:,ii)]=ranking(pop(:,ii),method,l,x);
end

