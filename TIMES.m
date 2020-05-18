for i=21:70
%n
AG=i*rand(10);
AG=(AG*AG')/15;
AG=AG-diag(diag(AG));
%n
AG=[ceil(AG(1,:)/10);ceil(AG(2,:)/10);ceil(AG(3,:)/10);ceil(AG(4,:)/10);ceil(AG(5,:)/10);ceil(AG(6,:)/10);ceil(AG(7,:)/10);ceil(AG(8,:)/10);ceil(AG(9,:)/10);ceil(AG(10,:)/10)];
%e,n
AH=AG+0.10*ones(10)
tic
[P,J] = CorrespondanceDVP_Gind(AG,AH);
format short
v1(i)=toc;
tic
[P,J] = CorrespondanceTP_Gind(AG,AH);
format short
v2(i)=toc;
tic
[P,J] = CorrespondancePL(AG,AH);
format short
v3(i)=toc;
end

for j=1:50
w1(j)=v1(j+20);
end
for j=1:50
w2(j)=v2(j+20);
end
for j=1:50
w3(j)=v3(j+20);
end

Mean1=mean(w1)
Std1=std(w1)
Mean2=mean(w2)
Std2=std(w2)
Mean3=mean(w3)
Std3=std(w3)
x=1:length(w1);
hold on
grid on
plot(x,w1,'green','LineWidth',2.7)
plot(x,w2,'red','LineWidth',2.7)
plot(x,w3,'blue','LineWidth',2.7)
ylim([0 0.2])
ylabel('temps (ms)','FontSize', 10)
xlabel('couple de graphes','FontSize', 10)
legend({'Décomposition VP','Transformation P','Programmation L'},'Location','northeast',...    %Légende du tracé avec le texte à afficher se trouvant entre {}
      'FontSize',10,'FontWeight','bold')
hold off
hold off
