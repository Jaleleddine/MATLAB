for i=21:70

%n
AG=i*rand(10);

%AG=(AG*AG')/15;
AG=AG-diag(diag(AG));

%n
AG=[ceil(AG(1,:)/10);ceil(AG(2,:)/10);ceil(AG(3,:)/10);ceil(AG(4,:)/10);ceil(AG(5,:)/10);ceil(AG(6,:)/10);ceil(AG(7,:)/10);ceil(AG(8,:)/10);ceil(AG(9,:)/10);ceil(AG(10,:)/10)];

%e,n
AH=AG+0.2*ones(10)

tic
[P,J] = CorrespondancePL(AG,AH);
format short
v(i)=toc;
end
%v
for j=1:50
w(j)=v(j+20);
end
%w
Mean=mean(w)
Std=std(w)
length(w)
x=1:length(w);
plot(x,w)