function new_chr1=cros_over(selpop,num)
new_chr1=cell(1,1);
chr1=selpop{1,1};
chr2=selpop{1,2};
l1=length(chr1);
l2=length(chr2);
lg1=l1-num-1;
lg2=l2-num-1;
if lg1~=1 && lg2~=1
    ra1=randperm(lg1);
    ra2=randperm(lg2);
    r1=ra1(1:2);
    r2=ra2(1:2);
    r1=sort(r1);
    r2=sort(r2);
    sel1=chr1(num+r1(1):num+r1(2));
    sel2=chr2(num+r2(1):num+r2(2));
    l_s1=length(sel1);
    l_s2=length(sel2);
    new_chr=zeros(1,num+l_s1+l_s2+1);
    for j=1:num
        for l=1:l_s1
            if chr1(j)==sel1(l)
                new_chr(1,j)=chr1(1,j);
            end
        end
    end
    for j=1:num
        for l=1:l_s2
            if chr2(j)==sel2(l)
                if new_chr(1,j)==0
                    new_chr(1,j)=chr2(j)+100;
                end
            end
        end
    end
    new_chr(1,num+1:num+l_s1)=sel1;
    new_chr(1,num+1+l_s1:length(new_chr)-1)=sel2+100;
    
    m_sel=[sel1 sel2+100];
    l_m=length(m_sel);
    
    for j=1:num
        if new_chr(1,j)==0
            new_chr(1,j)=m_sel(randi([1,l_m]));
        end
    end
    
    % for l=1:l_s1
    %     count_e=0;
    %     for j=1:num
    %         if new_chr(1,j)==sel1(l)
    %             count_e=count_e+1;
    %         end
    %     end
    %     if count_e==0
    %         new_chr(1,num+l)=-1;
    %     end
    % end
    count_e=zeros(1,max(m_sel));
    for i=1:num
        count_e(1,new_chr(1,i))=count_e(1,new_chr(1,i))+1;
    end
    
    for i=num+1:num+l_s1+l_s2
        if count_e(1,new_chr(1,i))==0
            az=new_chr(1,i);
            new_chr(1,i)=-1;
        end
    end       
    
    k=1;
    for l=1:l_s1
        t=0;
        for j=1:num
            if new_chr(1,j)==sel1(l)
                new_chr(1,j)=k+50;
                t=1;
            end
        end
        if t==1
            k=k+1;
        end
    end
    
    for l=1:l_s2
        t=0;
        for j=1:num
            if new_chr(1,j)==sel2(l)+100
                new_chr(1,j)=k+50;
                t=1;
            end
        end
        if t==1
            k=k+1;
        end
    end
    k=1;
    for l=1:l_s1
        if new_chr(1,num+l)~=-1
            new_chr(1,num+l)=k+50;
            k=k+1;
        end
    end
    for l=1:l_s2
        if new_chr(1,num+l_s1+l)~=-1
            new_chr(1,num+l_s1+l)=k+50;
            k=k+1;
        end
    end
    
    new_chr1{1,1}(1,1:num)=new_chr(1,1:num)-50;
    k=1;
    for l=1:l_s1+l_s2
        if new_chr(1,num+l)~=-1
            new_chr1{1,1}(1,num+k)=new_chr(1,num+l)-50;
            k=k+1;
        end
    end
    new_chr1{1,1}(1,num+k)=0;
elseif lg1==1
    new_chr1{1,1}=chr2;
elseif lg2==1
    new_chr1{1,1}=chr1;
else
    new_chr1{1,1}=chr1;
end

end