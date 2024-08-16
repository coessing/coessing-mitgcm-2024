load InFlow
nx=25; ny=18;
[y,x]=meshgrid(1:ny,1:nx);
for t=0:480:172800
    T=readbin(['T.' myint2str(t,10) '.data'],[nx ny]);
    U=readbin(['U.' myint2str(t,10) '.data'],[nx ny]);
    V=readbin(['V.' myint2str(t,10) '.data'],[nx ny]);
    T(T==0)=nan;
    clf
    pcolorcen(T')
    colormap(jet)
    caxis([27 31.2])
    hold on
    quiver(x',y',U',V','k')
    colorbar('SouthOutside')
    title(datestr(dte(1+t/480)))
    pause
end
