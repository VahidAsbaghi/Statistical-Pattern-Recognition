function [fitnes,out11,pop]=ranking(pop,method,num,x)

ll=length(pop);
l_island=ll;
DB=zeros(1,ll);
SSE1=zeros(1,ll);

S=zeros(1,ll);
if method==1 %method 1 is db-index for ranking
    for i=1:ll % for each member of population do compute db-index
        chr=pop{i,1};
        lps=length(chr);
        if chr(1,lps)==0
            DB(1,i)=DB_index(chr,num,x);
        else
            DB(1,i)=chr(1,lps);
        end
    end
    
    fitnes=1./DB.';

    out11=DB;
elseif method==2
    for i=1:ll %compute s-index for each member
        chr=pop{i,1};
        lps=length(chr);
        if chr(1,lps)==0
            S(1,i)=S_index(chr,num,x);
        else
            S(1,i)=chr(1,lps);
        end
    end
        
    fitnes=(S+2);

    out11=S;
else
    for i=1:ll %compute s-index for each member
        chr=pop{i,1};
        lps=length(chr);
        if chr(1,lps)==0
            SSE1(1,i)=SSE_i(chr,num,x);
        else
            SSE1(1,i)=chr(1,lps);
        end
    end
    fitnes=1./(SSE1+1).';
    out11=SSE1;
end

for j=1:l_island
    lps=length(pop{j,1});
    pop{j,1}(1,lps)=out11(1,j);
end

end