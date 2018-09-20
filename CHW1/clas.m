%SPR-CHW2-vahid asbaghi
function cl=clas(x1,x2,bound)
%%
%function clas recieve samples of two clas w1 , w2 then classify them using
%bayes classifier by bound value for ln((pw1)/(pw2))
%%
[xi,yi]=size(x1);
cl=zeros(xi,yi);

for i=1:xi
    if x1(i,1)+x1(i,2)<=bound
        cl(i,1)=1;
    else
        cl(i,1)=2;
    end
    if x2(i,1)+x2(i,2)<=bound
        cl(i,2)=1;
    else
        cl(i,2)=2;
    end
end
end