y = [2.0341 0.0421;2.1344 0.9500;2.0015 0.0370];
b=bar(y)
legend({'Moyenne','�cart type'},'Location','northeast',...    %L�gende du trac� avec le texte � afficher se trouvant entre {}
      'FontSize',10,'FontWeight','bold')
  set(gca,'xticklabel',{'DVP','TP','PL'},'FontWeight','bold')