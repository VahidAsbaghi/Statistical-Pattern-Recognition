%SPR-CHW2-vahid asbaghi
function OCC(x1,x2,N)
%%
    %function operation characteristics curve--- plot occ curve with respect
        %to bound changing--- in a loop change bayes boundary and compute 
            %classification error by calling clas.m function
            %%
max1=max(x1(:,1));
max2=max(x2(:,1));
min1=min(x1(:,1));
min2=min(x2(:,1));
j=1;

for i=max(min1,min2):0.01:min(max1,max2)
    err1=0;
    err2=0;
    bound=i;
    cl=clas(x1,x2,bound);
    for i=1:N
        if cl(i,1)~=1
            err1=err1+1;
        end
        if cl(i,2)~=2
            err2=err2+1;
        end
    end
    eps1(j)=err1/N;
    eps2(j)=err2/N;
    j=j+1;
end
s = fitoptions('Method','NonlinearLeastSquares',...
    'Lower',[0,0],...
    'Upper',[1,1],...
    'Startpoint',[0 0]);
f = fittype('a*exp(x-b)^n','problem','n','options',s);
fff= fit(eps1',1-eps2',f,'problem',2);
hold off;
figure;
plot(fff);
xlabel('eps1')
ylabel('1-eps2');
title('Operation Characteristics Curve');
hold on;
scatter((eps1),(1-eps2),'.','MarkerEdgeColor','y');
end