%SPR-CHW2-vahid asbaghi
function [mm,pwmax]=bayes_c(x1,x2,N)
%%
%function bayes writed for last quastion number of homework
%this function plot bayes error with respect to chang of p(w1)
%this function compute errors by calling clas.m function
%%
j=1;
for pw1=0:0.001:1
    pw2=1-pw1;
    bound=log(pw1/pw2);
    cl=clas(x1,x2,bound);
    er1=0;
    er2=0;
    for i=1:N
        if cl(i,1)~=1
            er1=er1+1;
        end
        if cl(i,2)~=2
            er2=er2+1;
        end
    end
    er(j)=er1+er2;
    j=j+1;
end
figure;
plot(0:0.001:1,er);
xlabel('P(w1)')
ylabel('Bayes Classifier Error');
title('Bayes Error Curve');
[mm,I]=max(er);
pwmax=(I-1)*0.001;
end