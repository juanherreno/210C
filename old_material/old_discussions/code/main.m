clear all;
close all;

%-------------------------------------------------------
% 1. Baseline Calibration
%-------------------------------------------------------

gamma   = 1;
phi     = 1;
lambda  = 0.02;      
beta    = 0.99;
sg      = 0.2;
rho_g   = 0.8;
phi_pi  = 1.5;
sigma_g = 0.01;
omega   = ( phi * (1-sg) + gamma ) / (1-sg);
phi_ygap   = 0;

save paramfile gamma phi lambda beta sg rho_g phi_pi sigma_g omega phi_ygap;

% Sets we loop over
phiygap_set = [0 0.25];

aux = 1; 

for phi_ygap = phiygap_set
    
    save paramfile gamma phi lambda beta sg rho_g phi_pi sigma_g omega phi_ygap;
	dynare nkm_3eq noclearall nolog nograph; 
	save(strcat(num2str(aux),'.mat'));
     aux = aux + 1;
end


%Store IRFS, SDs and parameters for each model
load('1.mat')
irf1 = oo_.irfs;  %IRFS
load('2.mat')
irf2 = oo_.irfs;  %IRFS


HOR=1:options_.irf;
var={'pi', 'ygap','i','rn', 'g'};
figure
for jj=1:length(var)
    figure(1)
    subplot(3,2,jj)
    line1 = eval(['irf1.' var{1,jj},'_u_g']);
    line2 = eval(['irf2.' var{1,jj},'_u_g']);

    hold on
    plot(HOR,line1,'-r',HOR,line2,'-b');

    legend({'Taylor Rule 1','Taylor Rule 2'},'Location','best', 'Fontsize',5);
    legend('boxoff');
    title([var{1,jj}] );
    
end

close(gcf)  

%L oop over gamma
%%%%%%%%%%%%%%%%%%%%%
gamma_set = [1 0.5];

aux = 1; 

for gamma = gamma_set

    save paramfile gamma phi lambda beta sg rho_g phi_pi sigma_g omega phi_ygap;
	dynare nkm_3eq noclearall nolog nograph; 
	save(strcat(num2str(aux),'.mat'));
     aux = aux + 1;
end


%Store IRFS, SDs and parameters for each model
load('1.mat')
irf1 = oo_.irfs;  %IRFS
load('2.mat')
irf2 = oo_.irfs;  %IRFS


HOR=1:options_.irf;
var={'pi', 'ygap','i','rn', 'g'};
figure
for jj=1:length(var)
    figure(1)
    subplot(3,2,jj)
    line1 = eval(['irf1.' var{1,jj},'_u_g']);
    line2 = eval(['irf2.' var{1,jj},'_u_g']);

    hold on
    plot(HOR,line1,'-r',HOR,line2,'-b');

    legend({'IES=1','IES=2'},'Location','best', 'Fontsize',5);
    legend('boxoff');
    title([var{1,jj}] );
end

close(gcf)  


% Loop over lambda
%%%%%%%%%%%%%%%%%%%%%%
lambda_set = [.02 0.07];

aux = 1; 

for lambda = lambda_set

    save paramfile gamma phi lambda beta sg rho_g phi_pi sigma_g omega phi_ygap;
	dynare nkm_3eq noclearall nolog nograph; 
	save(strcat(num2str(aux),'.mat'));
     aux = aux + 1;
end


%Store IRFS, SDs and parameters for each model
load('1.mat')
irf1 = oo_.irfs;  %IRFS
load('2.mat')
irf2 = oo_.irfs;  %IRFS


HOR=1:options_.irf;
var={'pi', 'ygap','i','rn', 'g'};
figure
for jj=1:length(var)
    figure(1)
    subplot(3,2,jj)
    line1 = eval(['irf1.' var{1,jj},'_u_g']);
    line2 = eval(['irf2.' var{1,jj},'_u_g']);

    hold on
    plot(HOR,line1,'-r',HOR,line2,'-b');

    legend({'Higher Price Stickiness','Lower Price Stickiness'},'Location','best', 'Fontsize',5);
    legend('boxoff');
    title([var{1,jj}] );
end
