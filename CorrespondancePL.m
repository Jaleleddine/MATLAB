function [P,J] = CorrespondancePL(AG,AH)

% Algorithme 3: Programmation Lin�aire:
% Algorithm: Linear Programming Approach: 
% (input: AG, AH; output: P, J(P))                                            
%**************************************************************************
% 1: Initialisation: AG et AH sont deux matrices carr�es:
% AG=input('Matrix AG :  ')
% AH=input('Matrix AH :  ')
[n1,m1]=size(AG);
[n2,m2]=size(AH);
if (n1>n2)
y=n1-n2;
AH=[AH zeros(n2,y)];
AH=[AH ; zeros(y,n1)];
end
if (n1<n2)
y=n2-n1;
AG=[AG zeros(n1,y)];
AG=[AG ; zeros(y,n2)];
end
[n,m]=size(AG);
if (n==m) && (isequal(size(AG),size(AH)))
N=n^2;
%**************************************************************************
% 2: Lin�arisation de probl�me:
% 2.a: Calculer la matrice AGH(N,N)=AGG(N,N)-AHH(N,N)  ,avec N=n^2
% R=AG.P�P.AH  et  minP ||AGH.VEC(P)||=minP ||VEC(R)||
AGG=[AG zeros(n,n)];
for i=3:n
AGG=[AGG zeros(n,n)];
end
for i=1:(n-1)
k=zeros(n,n*i);
k=[k AG];
k=[k zeros(n,N-(n*(i+1)))];
AGG=[AGG ; k];
end
AHH=AH(1,1)*eye(n,n);
for i=2:n
AHH=[AHH AH(i,1)*eye(n,n)]; 
end  
for j=2:n
k=AH(1,j)*eye(n,n);
for i=2:n
k=[k AH(i,j)*eye(n,n)];
end
AHH=[AHH ; k];
end
AGH=AGG-AHH;
AGH  % � afficher
% 2.b: Calculer la matrice B de taille (2n,n^2) avec: B.p=e 
for i=1:n 
for j=1:N
if(i==mod(j,n))||(j==i)
B(i,j)=1;
else
B(i,j)=0;
end
end
end
for i=2:n 
for j=2:N
if(B(i-1,j-1)==1)
B(i,j)=1;
end
end
end
B=[B;ones(n,N)*0.1];
B % � afficher
%**************************************************************************
% 3: R�soudre le nouveau probl�me lin�aire obtenu (Simplexe) :
% min p,S,T SOMME (Sm+Tm) ,avec m=1..N
% Sous contraintes
% AGH.p+S�T=0
% B.p=e 
% P>=0,S>=0,T>=0
% O� Sm, et Tm deux vecteurs de taille (N, 1)
% p =VEC (P) vecteur de taille (N, 1)
% VEC(P)={p11,p21,...,pn1,p12,p22,...,pn2,....pnn}T
c=[zeros(1,N) ones(1,N) ones(1,N)];
A=[AGH eye(N) eye(N)*(-1)];
A=[A; B zeros(2*n,N) zeros(2*n,N)];
b=[zeros(1,N) ones(1,2*n)];
x = linprog(c,[ ],[ ],A,b,zeros(size(c)),[ ]) % � afficher
v=zeros(1,N);
for i=1:N 
v(i)=x(i);
end
p=v;
X= vec2mat(v,n);
Pr=X';
Pr % � afficher
P=zeros(n);
for i=1:n
[VM,Ir]=max(Pr,[],1);
[MM,Ic]=max(VM',[],1);
c=Ic;
r=Ir(c);
P(r,c)=1;
Pr(r,1:n)=0;
Pr(1:n,c)=0;
end
P % � afficher
%**************************************************************************
%4: Calculer la diff�rence J(P) en utilisant l�expression:
%J(P) = ||P.AG.(P)T�AH||^2
X=[P*AG*transpose(P)]-AH;
J=sqrt(sum(sum(abs(X).*abs(X))));
J
else
input('Erreur inputs');
end
%end function
end
