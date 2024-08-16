load InFlow
load TSobcs
% dte=datenum(2023,3,4):1/24:datenum(2024,2,29);
nt=length(dte);
% inflow in m^3/s
% InSW=70.69*ones(nt);
% InNW=95.20*ones(nt);

SW=interp1(time,salW_s,dte,'makima');
SE=interp1(time,salE_s,dte,'makima');
TW=interp1(time,tempW_s,dte,'makima');
TE=interp1(time,tempE_s,dte,'makima');

nx=25;
ny=18;
nz=10;

% Make sure that ../grid contains most up-to-date
% grid files for integration domain
DYG=readbin('../grid/DYG.data',[nx ny]);
Depth=readbin('../grid/Depth.data',[nx ny]);
AreaInSW=DYG(1,2)*Depth(1,2);
AreaInNW=DYG(1,8)*Depth(1,8);
AreaOutSE=DYG(25,3)*Depth(25,3);
AreaOutNE=DYG(25,9)*Depth(25,9)+DYG(25,10)*Depth(25,10);

OBWs=zeros(ny,nz,nt);
OBEs=zeros(ny,nz,nt);
OBWt=zeros(ny,nz,nt);
OBEt=zeros(ny,nz,nt);
OBWu=zeros(ny,nz,nt);
OBEu=zeros(ny,nz,nt);
for t=1:length(nt)
    OBWu(2,:,t)=InSW(t)/AreaInSW;
    OBWu(8,:,t)=InNW(t)/AreaInNW;
    OBEu(:,:,t)=(InSW(t)+InNW(t))/(AreaOutSE+AreaOutNE);
    OBWs(:,:,t)=SW(t);
    OBEs(:,:,t)=SE(t);
    OBWt(:,:,t)=TW(t);
    OBEt(:,:,t)=TE(t);
end
writebin('Estuary_25x18_OBWs',OBWs);
writebin('Estuary_25x18_OBWt',OBWt);
writebin('Estuary_25x18_OBWu',OBWu);
writebin('Estuary_25x18_OBEs',OBEs);
writebin('Estuary_25x18_OBEt',OBEt);
writebin('Estuary_25x18_OBEu',OBEu);
