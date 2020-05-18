y = [1.4135 0.0169; 1.5237 0.6689; 1.4217 0.2326];
b=bar(y)
legend({'Mean','SD'},'Location','northeast',...    %Légende du tracé avec le texte à afficher se trouvant entre {}
      'FontSize',9,'FontWeight','bold')
  set(gca,'xticklabel',{'Eigen Deceomposition','Polynomial Transform','Linear Programming'},'FontWeight','bold')