function [P,J] = CorrespondanceTP_Gind(AG,AH)

% Algorithme 2.1: Transformation Polynomial 
% appliqué aux graphes indirects (non orientés):
% Algorithm: Polynomial Transformation Approach to Undirected Graph: 
% (input: AG, AH; output: P, J(P))                                            
%**************************************************************************
% 1: Initialisation: AG et AH sont deux matrices carrées symétriques:
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
if (n==m)&&(isequal(size(AG),size(AH)))&&(isequal(AG,AG'))&&(isequal(AH,AH'))
%**************************************************************************          
% 2: Transformation en coefficient par ligne des matrices AG et AH 
% et calculer les matrices CG and CH:
for i=1:n
v=AG(i,:);
x=poly(v);
x=x(2:end);
CG(i,:)=x;
end
CG=abs(CG);
CG % à afficher
for i=1:n 
v=AH(i,:);
x=poly(v);
x=x(2:end);
CH(i,:)=x;
end
CH=abs(CH);
CH % à afficher
%************************************************************************** 
% 3: Calculer la matrice de distance D à partir CG et CH:
% D[i,j]= {[ SOMME CG[i,k] – CH[j,k] ]^2 }^(1/2)
for i=1:n 
for j=1:n
s=0;
for k=1:n
s=s+[(CG(i,k)-CH(j,k))]^2;
D(i,j)=sqrt(s);
end
end
end
D % à afficher
%**************************************************************************
% 4: Appliquer la méthode hongroise (Hungarian Method) sur la matrice U
% qui donne comme résultat, la matrice de permutation minimale P:
P= hongroise (D);
%P
%**************************************************************************
% 5: Calculer la différence J(P) en utilisant l’expression:
% J(P) = ||P.AG.(P)T–AH||^2
X=[P*AG*transpose(P)]-AH;
J=sqrt(sum(sum(abs(X).*abs(X))));
J
else
input('Erreur inputs');
end
% end function
end
