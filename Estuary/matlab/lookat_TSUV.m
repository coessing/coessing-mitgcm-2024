load InFlow
nx=25; ny=18; nt=length(dte);
[y,x]=meshgrid(1:ny,1:nx);

delta=1440;
for t=1:nt
    S=readbin(['S.' myint2str((t-1)*delta,10) '.data'],[nx ny]);
    T=readbin(['T.' myint2str((t-1)*delta,10) '.data'],[nx ny]);
    U=readbin(['U.' myint2str((t-1)*delta,10) '.data'],[nx ny]);
    V=readbin(['V.' myint2str((t-1)*delta,10) '.data'],[nx ny]);
    T(T==0)=nan;
    S(S==0)=nan;
    figure(1), clf
    pcolorcen(T')
    colormap(jet)
    caxis([27 33])
    hold on
    quiver(x',y',20*U',20*V',0,'k','linewidth',2.5)
    colorbar('SouthOutside')
    title(datestr(dte(t)))
    figure(2), clf
    pcolorcen(S')
    colormap(jet)
    caxis([0 15])
    hold on
    quiver(x',y',20*U',20*V',0,'k','linewidth',2.5)
    colorbar('SouthOutside')
    title(datestr(dte(t)))
    pause(.1)
end
