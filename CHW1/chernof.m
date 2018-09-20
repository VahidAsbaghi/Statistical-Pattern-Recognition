%SPR-CHW2-vahid asbaghi
function [opt_s,cher_err]=chernof(sigma1,m1,sigma2,m2)
%% 
%function chernof.m plot chernof distanse against s value of chernof
%formula and find maximum value of curve and respective 's' value.
k=1;
for s=0:0.001:1
    mu1(k)=(s*(1-s)/2)*(m2-m1)'*(s*sigma1+(1-s)*sigma2)^(-1)*(m2-m1)+0.5*log(det(s*sigma1+(1-s)*sigma2)/((det(sigma1)^s)*(det(sigma2)^(1-s))));
    k=k+1;
end
figure;
plot(0:0.001:1,mu1);
xlabel('s')
ylabel('Chernoff Distance');
title('Chenoff Curve');
[opt_s,I]=max(mu1);
optt=(I-1)*0.001;
cher_err=0.5*exp(-opt_s);
opt_s=optt;
end
    