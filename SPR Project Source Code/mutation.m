function [new_chr,other]=mutation(new_chr1,method,num)
new_chr=cell(1,1);
chr_inp=new_chr1{1,1};
l=length(chr_inp);
l1=l-num-1;
cl_cont=zeros(1,l1);
points1=1;
for i=1:num
    cl_cont(1,chr_inp(1,i))=cl_cont(1,chr_inp(1,i))+1;
end
po=round((9*num./(2*cl_cont+10)));
for i=1:l1
points1=[points1 ones(1,po(i))*i];
end
rll=length(points1);
rll1=randperm(rll);
points1=points1(rll1);

if method==1 %class spliting
    ra=randi([1,num]);
    cl_sel=chr_inp(ra);
    new_cl_l=l1+1;
    for k=1:num
        if chr_inp(1,k)==cl_sel
            r1=rand;
            if r1<=0.5
                chr_inp(1,k)=new_cl_l;
            end
        end
    end
    new_chr{1,1}(1,1:l-1)=chr_inp(1,1:l-1);
    new_chr{1,1}(1,l)=new_cl_l;
    new_chr{1,1}(1,l+1)=0;
  other=2;  
else %cluster merging
    if l1~=1
        tt=1;
        ra1=randi([1,rll]);
        cl_sel1=points1(ra1);
        while tt==1
            ra2=randi([1,rll]);
            cl_sel2=points1(ra2);
            if cl_sel2~=cl_sel1
                tt=2;
            end
        end
        cl_sel=min([cl_sel1,cl_sel2]);
        cl_sel_t=max([cl_sel1,cl_sel2]);
        for j=1:num
            if chr_inp(1,j)==cl_sel_t
                chr_inp(1,j)=cl_sel;
            end
        end
        new_chr2=zeros(1,l-1);
        new_chr2(1,1:num)=chr_inp(1,1:num);
        j=num+1;
        jj=j;
        while j<=l-1
            if chr_inp(1,j)~=cl_sel_t
                new_chr2(1,jj)=chr_inp(1,j);
                j=j+1;
                jj=jj+1;
            else
                j=j+1;
            end
        end
        
        for j=num+2:l-2
            if (new_chr2(1,j)~=new_chr2(1,j-1)+1)
                new_chr2(1,j)=new_chr2(1,j)-1;
                for k=1:num
                    if (new_chr2(1,k)==new_chr2(1,j)+1)
                        new_chr2(1,k)=new_chr2(1,j);
                    end
                end
            end
        end
        new_chr{1,1}(1,1:l-1)=new_chr2;
        new_chr{1,1}(1,l-1)=0;
    else
        new_chr{1,1}=chr_inp;
    end
    other=1;
end
end


