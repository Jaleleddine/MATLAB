function [P,J] = CorrespondanceDVP_Gd_improved(AG,AH)

% Algorithme 1.2: Décomposition en valeur propres 
% appliqué aux graphes directs (orientés):
% Algorithm: Eigen Decomposition Approach to Undirected Graph:
% (input: AG,AH; output: P, J(P))                                             
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
% 2: Calculer les matrices complexes EG and EH, avec une partie réelle 
% symétrique et une partie complexe antisymétrique:
AGS=(AG+AG')/2;
AGN= (AG-AG')/2;
AGS; % à afficher 
AGN; % à afficher 
EG= AGS+i*AGN % à afficher
AHS=(AH+AH')/2;
AHN=(AH-AH')/2;
AHS; % à afficher 
AHN; % à afficher 
EH= AHS+i*AHN % à afficher
%**************************************************************************
% 3: Décomposition en valeurs propres des matrices EG et EH 
% (Eigen Decomposition):
% EG=WG.DG.(WG)T
[VG,DG]=eig(EG); 
DG=diag(sort(diag(DG),'descend')); 
for k=1:n
WG(:,k)=VG(:,(n+1)-k);
end
DG   % à afficher 
WG   % à afficher 
% EH=WH.DH.(WH)T
[VH,DH]=eig(EH); 
DH=diag(sort(diag(DH),'descend')); 
for k=1:n
WH(:,k)=VH(:,(n+1)-k);
end
DH   % à afficher 
WH   % à afficher 
%**************************************************************************
% 4: Calculer la matrice W à partir WH et WG:
% W=|WH|.(|WG|)T
UG=abs(WG);
UH=abs(WH);
W=UH*transpose(UG); 
W      % à afficher 
%**************************************************************************
% 5: Appliquer la méthode hongroise (Hungarian Method) sur la matrice U
% qui donne comme résultat, la matrice de permutation minimale P:
P= hongroise (W);
%P
%**************************************************************************
% 6: Calculer la différence J(P) en utilisant l’expression:
% J(P) = ||P.AGS.(P)T–AHS||^2 + ||P.AGN.(P)T–AHN||^2
X1=[P*AGS*transpose(P)]-AHS;
J1=sqrt(sum(sum(abs(X1).*abs(X1))));
X2=[P*AGN*transpose(P)]-AHN;
J2=sqrt(sum(sum(abs(X2).*abs(X2))));
J=J1+J2;
J
else
input('Erreur inputs');
end
% end function
end

