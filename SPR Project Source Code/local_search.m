function chr_inp1=local_search(chr_inp,num,x,method)
xx=length(chr_inp);
ll=xx-num-1;
chr_out=cell(1,1);
chr_inp(1,xx)=0;
if method==1
    for i=1:num
        chr_out{1,1}=chr_inp;
        [~,DB_t,chr_out]=ranking(chr_out,method,num,x);
        chr_t=chr_inp;
        for j=1:ll
            chr_t(1,i)=j;
            chr_t(1,xx)=0;
            chr_out{1,1}=chr_t;
            [~,DB_t1,chr_out]=ranking(chr_out,method,num,x);
            if DB_t1<DB_t
                DB_t=DB_t1;
                chr_inp=chr_out{1,1};
            end
        end
    end
    
elseif method==2
    ra=randperm(num);
    for i=1:num
        tt=ra(i);
        chr_out{1,1}=chr_inp;
        [~,SSt,chr_out]=ranking(chr_out,method,num,x);
        chr_t=chr_inp;
        for j=1:ll
            chr_t(1,tt)=j;
            chr_t(1,xx)=0;
            chr_out{1,1}=chr_t;
            [~,SSt1,chr_out]=ranking(chr_out,method,num,x);
            if SSt1>SSt
                SSt=SSt1;
                chr_inp=chr_out{1,1};
            end
        end
    end
    
else
    for i=1:num
        chr_out{1,1}=chr_inp;
        [~,SSEt,chr_out]=ranking(chr_out,method,num,x);
        chr_t=chr_inp;
        for j=1:ll
            chr_t(1,i)=j;
            chr_t(1,xx)=0;
            chr_out{1,1}=chr_t;
            [~,SSEt1,chr_out]=ranking(chr_out,method,num,x);
            if SSEt1<SSEt
                SSEt=SSEt1;
                chr_inp=chr_out{1,1};
            end
        end
    end
end
count_e=zeros(1,ll);
for i=1:ll
    [~,~,v]=find(chr_inp(1,1:num)==i);
    count_e(1,i)=sum(v);
    if count_e(1,i)==0
        chr_inp(1,num+i)=-1;        
    end
end
chr_inp1(1,1:num)=chr_inp(1,1:num);
t=1;
for i=1:ll
      [~,iy,~]=find(chr_inp(1,1:num)==i+1);
    if chr_inp(1,num+i)~=-1
        chr_inp1(1,num+t)=chr_inp(1,num+t);
        t=t+1;
    else
        chr_inp1(1,iy)=t;
    end
end

lct=length(chr_inp1);
l_gr1=lct-num;
    
chr_inp1(1,num+1:num+l_gr1)=1:l_gr1;

chr_inp1(1,lct+1)=0;
end