load InFlow
% dte=datenum(2023,3,4):1/24:datenum(2024,2,29);
nt=length(dte);
% inflow in m^3/s
% InSW=70.69*ones(nt);
% InNW=95.20*ones(nt);

nx=25;
ny=18;
nz=10;

DYG=readbin('../grid/DYG.data',[nx ny]);
Depth=readbin('../grid/Depth.data',[nx ny]);
AreaInSW=DYG(1,2)*Depth(1,2);
AreaInNW=DYG(1,8)*Depth(1,8);
AreaOutSE=DYG(25,3)*Depth(25,3);
AreaOutNE=DYG(25,9)*Depth(25,9)+DYG(25,10)*Depth(25,10);

OBWs=4.13*ones(ny,nz,nt);
OBEs=3.76*ones(ny,nz,nt);
OBWt=27.8*ones(ny,nz,nt);
OBEt=28.0*ones(ny,nz,nt);
OBWu=zeros(ny,nz,nt);
OBEu=zeros(ny,nz,nt);
for t=1:length(nt)
    OBWu(2,:,t)=InSW(t)/AreaInSW;
    OBWu(8,:,t)=InNW(t)/AreaInNW;
    OBEu(:,:,t)=(InSW(t)+InNW(t))/(AreaOutSE+AreaOutNE);
end
writebin('Estuary_25x18_OBWs',OBWs);
writebin('Estuary_25x18_OBWt',OBWt);
writebin('Estuary_25x18_OBWu',OBWu);
writebin('Estuary_25x18_OBEs',OBEs);
writebin('Estuary_25x18_OBEt',OBEt);
writebin('Estuary_25x18_OBEu',OBEu);
