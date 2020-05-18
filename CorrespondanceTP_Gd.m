function [P,J] = CorrespondanceTP_Gd(AG,AH)

% Algorithme 2.2: Transformation Polynomial 
% appliqué aux graphes directs (orientés):
% Algorithm: Polynomial Transformation Approach to Directed Graph: 
% (input: AG, AH; output: P, J(P))                                            
%**************************************************************************
% 1: Initialisation: AG et AH sont deux matrices carrées non symétriques:
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
%************************************************************************** 
% 2: Transformation en coefficient par ligne des matrices AG et AH 
% et calculer les matrices CGr and CHr:
for i=1:n 
v=AG(i,:);
x=poly(v);
x=x(2:end);
CGl(i,:)=x; 
end
CGl=abs(CGl) % à afficher
 for i=1:n 
v=AH(i,:);
x=poly(v);
x=x(2:end);
CHl(i,:)=x;
end
CHl=abs(CHl) % à afficher
%************************************************************************** 
% 3: Transformation en coefficient par colonne des matrices AG et AH 
% et calculer les matrices CGc and CHc:
 for i=1:n 
v=AG(:,i);
x=poly(v);
x=x(2:end);
CGc(i,:)=x;
end
CGc=abs(CGc) % à afficher
for i=1:n 
v=AH(:,i);
x=poly(v);
x=x(2:end);
CHc(i,:)=x;
end
CHc=abs(CHc) % à afficher
%**************************************************************************
% 4: Calculer la matrice de distance D à partir CGl, CHl, CGc, CHc :
% D[i,j]={ SOMME [ CGl[i,k] – CHl[j,k] ]^2 }^(1/2)
%       +{ SOMME [ CGc[i,k] – CHc[j,k] ]^2 }^(1/2)
for i=1:n 
 for j=1:n
s1=0;
s2=0;
for k=1:n
s1=s1+[(CGl(i,k)-CHl(j,k))]^2;
s2=s2+[(CGc(i,k)-CHc(j,k))]^2;
D(i,j)=sqrt(s1)+sqrt(s2);
end
end
end
D % à afficher
%**************************************************************************
% 5: Appliquer la méthode hongroise (Hungarian Method) sur la matrice U
% qui donne comme résultat, la matrice de permutation minimale P:
P= hongroise (D);
%P
%**************************************************************************
% 6: Calculer la différence J(P) en utilisant l’expression:
% J(P) = ||P.CGl.(P)T–CHl||^2 + ||P.CGc.(P)T–CHc||^2
X1=[P*CGl*transpose(P)]-CHl;
J1=sqrt(sum(sum(abs(X1).*abs(X1))));
X2=[P*CGc*transpose(P)]-CHc;
J2=sqrt(sum(sum(abs(X2).*abs(X2))));
J=J1+J2;
J
else
input('Erreur inputs');
end
% end function
end



