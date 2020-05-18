function [P,J] = CorrespondanceDVP_Gind(AG,AH)

% Algorithme 1.1: D�composition en valeur propres 
% appliqu� aux graphes indirects (non orient�s):
% Algorithm: Eigen Decomposition Approach to Undirected Graph:
% (input: AG,AH; output: P, J(P))
%**************************************************************************
% 1: Initialisation: AG et AH sont deux matrices carr�es sym�triques:
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
% 2: D�composition en valeurs propres des matrices AG et AH 
% (Eigen Decomposition):
% AG=UG.DG.(UG)T    (c'est une formule)
[VG,DG]=eig(AG);
DG=diag(sort(diag(DG),'descend'));
for i=1:n
UG(:,i)=VG(:,(n+1)-i);
end
DG     % � afficher (c'est lambda G)
UG     % � afficher 
% AH=UH.DH.(UH)T (c'est une formule)
[VH,DH]=eig(AH);
DH=diag(sort(diag(DH),'descend')); 
for i=1:n
UH(:,i)=VH(:,(n+1)-i);
end
DH   % � afficher  (c'est lambda H)
UH   % � afficher 
%**************************************************************************
% 3: Calculer la matrice U � partir UH et UG:
% U=|UH|.(|UG|)T    (c'est une formule)
U=abs(UH)*transpose(abs(UG));
U % � afficher 
%**************************************************************************
% 4: Appliquer la m�thode hongroise (Hungarian Method) sur la matrice U
% qui donne comme r�sultat, la matrice de permutation minimale P:
P= hongroise (U);
%P
%**************************************************************************
% 5: Calculer la diff�rence J(P) en utilisant l�expression:
% J(P) = ||P.AG.(P)T�AH||^2  (c'est une formule)
X=[P*AG*transpose(P)]-AH;
J=sqrt(sum(sum(abs(X).*abs(X))));
J
else
input('Erreur inputs');
end
% end function
end
