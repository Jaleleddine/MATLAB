v1(1)=0;
v2(1)=0;
v3(1)=0;
v4(1)=0;

x(1)=1;

AG=eye(14)*rand(1)*10;%***************AG=(AG*AG')/10; % à commenter en cas de graphes directs
for i=2:10   % changer le pas que ici car j dépend de j
tic
for j=1:i*i*1 % * 5 donne 500 (modifier le 5 en cas de besoin) de même pour les autres j
%%%n
AH=rand(14);
AH=(AH*AH')/10;
AH=AH-diag(diag(AH));%**************
%%%%n
[P,J] = CorrespondanceDVP_Gd(AG,AH);
format short
end
v1(i)=toc+v1(i-1);   % Jusqu'à 10

tic
for j=2:i*i*1% 500 graphes
%%%n
 
%AH=(AH*AH')/10;
AH=AH-diag(diag(AH));
%%%%n
[P,J] = CorrespondanceTP_Gd(AG,AH);
format short
end
v2(i)=toc+v2(i-1);

tic
for j=2:i*i*1
%%%n
AH=rand(14);
%AH=(AH*AH')/10;
AH=AH-diag(diag(AH));
%%%%n
[P,J] = CorrespondancePL(AG,AH);
format short
end
v3(i)=toc+v3(i-1);
x(i)=i*i*1
tic
for j=2:i*i*1% 500 graphes
%%%n
AH=rand(14);
%AH=(AH*AH')/10;
AH=AH-diag(diag(AH));
%%%%n
 [JZ]= Correspondance_Improved(AG,AH);
format short
end
v4(i)=toc+v4(i-1);

end





hold on
grid on
plot(x,v1,'green','LineWidth',2.7)
plot(x,v2,'red','LineWidth',2.7)
plot(x,v3,'blue','LineWidth',2.7)
plot(x,v4,'m','LineWidth',2.7)
%ylim([0 0.2])
%ylabel('temps (s)','FontSize', 11)
ylabel('time (s)','FontSize', 13)
%xlabel('Nombre de paires (graphes directs)','FontSize', 11)

xlabel('repository size','FontSize', 13)

%legend({'Décomposition VP','Transformation P','Programmation L'},'Location','northwest',...    %Légende du tracé avec le texte à afficher se trouvant entre {}
 %     'FontSize',10,'FontWeight','bold')
  
  legend({'Eigen-decomposition','Symmetric Polynomial transform','Linear programming'},'Location','northwest',...    %Légende du tracé avec le texte à afficher se trouvant entre {}
      'FontSize',10,'FontWeight','bold')

  
  
hold off
hold off