function abnomogram(varargin)
% ABNOMOGRAM - Check the Acid-Base status of a blood sample. 
% This function executes the analysis of the Acid-Base status of a blood
% sample given the pH and the pCO2 (in mmHg). The function plots a nomogram
% with 13, differently coloured, zones. The zone in which your data fall 
% represents the Acid-Base status of your blood sample. By itself, the
% function plots a nomogram for a normal sample.
% 
% Syntax: 	ABNONOGRAM(pH,pCO2)
%      
%     Inputs:
%           pH - Blood sample pH. This is a scalar value.
%           pC02 - Blood sample pCO2. This is a scalar value.
%     Outputs:
%           - Nomogram plot
% 
%      Example: 
%      abnomogram will show a nomogram for a normal sample
%      abnomogram(7.5,45) will show a nomogram with your data into the metabolic alkalosis zone
%
%           Created by Giuseppe Cardillo
%           giuseppe.cardillo-edta@poste.it
%
% To cite this file, this would be an appropriate format:
% Cardillo G. (2008) ABnomogram: check the acid-base status of a blood
% sample. 
% http://www.mathworks.com/matlabcentral/fileexchange/20571

%Input error handling
defaultpH=7.4;
defaultpCO2=40.5;
validation = @(x) isnumeric(x) && isscalar(x) && isreal (x) && isfinite(x) && (x > 0);
p = inputParser;
addOptional(p,'x',defaultpH,validation);
addOptional(p,'y',defaultpCO2,validation);
parse(p,varargin{:});
x=p.Results.x; y=p.Results.y;
clear p default* validation

x=10^(-x+9); %transform pH in nM units
Z=zeros(1,14); %Zone vector preallocation
%Set the colors of the 13 zones
C=[0 255 0; 255 0 0; 255 0 255; 255 255 0; 0 0 255; 0 255 255;...
    122 15 227; 249 136 25; 255 219 21; 203 255 21; 21 153 255;...
    255 128 255; 177 47 133]./255; 
figure('Position',[0 0 1280 960]);
hold on
%Normal 
pCO2=[37 37 44 44];
H=[35.50 44.70 44.70 35.50];
Z(1)=fill(pCO2,H,C(1,:),'EdgeColor',C(1,:));
%Metabolic Acidosis
pCO2=[9 18.07 18.07 9];
H=[-1.98855.*pCO2(1:2)+93.11307 100 100];
Z(2)=fill(pCO2,H,C(2,:),'EdgeColor',C(2,:));
pCO2=[18.08 26.81 26.81 18.08];
H=[-1.98855.*pCO2(1:2)+93.11307 -1.90016.*pCO2(3:4)+115.00586];
fill(pCO2,H,C(2,:),'EdgeColor',C(2,:));
pCO2=[26.82 36.99 36.99 26.82];
H=[-1.90016.*pCO2(1:2)+115.00586 39.8 39.8];
fill(pCO2,H,C(2,:),'EdgeColor',C(2,:));
%Acute Respiratory Acidosis
pCO2=[44.01 100 100 44.01];
H=[0.75036.*pCO2(1:2)+5.94429 0.77929.*pCO2(3:4)+10.41143];
Z(3)=fill(pCO2,H,C(3,:),'EdgeColor',C(3,:));
%Chronic Respiratory Acidosis
pCO2=[44.01 57.83 57.83 44.01];
H=[0.28482.*pCO2(1:2)+23.66786 0.76645.*pCO2(3:4)+5.17621];
Z(4)=fill(pCO2,H,C(4,:),'EdgeColor',C(4,:));
pCO2=[57.84 100 100 57.84];
H=[0.28482.*pCO2(1:2)+23.66786 0.36827.*pCO2(3:4)+28.20287];
fill(pCO2,H,C(4,:),'EdgeColor',C(4,:));
%Metabolic Alkalosis
pCO2=[37 44 44 37];
H=[-0.37272.*pCO2(1:2)+42.93068 35.49 35.49];
Z(5)=fill(pCO2,H,C(5,:),'EdgeColor',C(5,:));
pCO2=[44.01 48.18 48.18 44.01];
H=[-0.37272.*pCO2(1:2)+42.93068 0.36516.*pCO2(3:4)+20.13317];
fill(pCO2,H,C(5,:),'EdgeColor',C(5,:));
pCO2=[48.19 51.80 51.80 48.19];
H=[-0.37272.*pCO2(1:2)+42.93068 -0.25989.*pCO2(3:4)+50.25395];
fill(pCO2,H,C(5,:),'EdgeColor',C(5,:));
pCO2=[51.81 62.35 62.35 51.81];
H=[0 0 -0.25989.*pCO2(3:4)+50.25395];
fill(pCO2,H,C(5,:),'EdgeColor',C(5,:));
%Acute Respiratory Alkalosis
pCO2=[9 36.99 36.99 9];
H=[0.77332.*pCO2(1:2)+6.8872 0.7068.*pCO2(3:4)+13.64852];
Z(6)=fill(pCO2,H,C(6,:),'EdgeColor',C(6,:));
%Chronic Respiratory Alkalosis
pCO2=[9 26.50 26.50 9];
H=[0.44379.*pCO2(1:2)+20.70493 0.13015.*pCO2(3:4)+34.98438];
Z(7)=fill(pCO2,H,C(7,:),'EdgeColor',C(7,:));
pCO2=[26.51 36.99 36.99 26.51];
H=[0.69876.*pCO2(1:2)+13.94585 0.13015.*pCO2(3:4)+34.98438];
fill(pCO2,H,C(7,:),'EdgeColor',C(7,:));
%Mixed Metabolic and Respiratory Acidosis
pCO2=[18.08 36.99 36.99 18.07];
H=[-1.90016.*pCO2(1:2)+115.00586 100 100];
Z(8)=fill(pCO2,H,C(8,:),'EdgeColor',C(8,:));
pCO2=[37 44 44 37];
H=[44.71 44.71 100 100];
fill(pCO2,H,C(8,:),'EdgeColor',C(8,:));
pCO2=[44.01 100 100 44.01];
H=[0.77929.*pCO2(1:2)+10.41143 100 100];
fill(pCO2,H,C(8,:),'EdgeColor',C(8,:));
%Mixed Acute and Chronic Respiratory Acidosis
pCO2=[57.84 100 100 57.84];
H=[0.75036.*pCO2(1:2)+5.94429 0.36827.*pCO2(3:4)+28.20287];
Z(9)=fill(pCO2,H,C(9,:),'EdgeColor',C(9,:));
%Mixed Metabolic Alkalosis and Respiratory Acidosis
pCO2=[48.20 62.35 62.35 48.20];
H=[-0.25989.*pCO2(1:2)+50.25395 0.28482.*pCO2(3:4)+23.66786];
Z(10)=fill(pCO2,H,C(10,:),'EdgeColor',C(10,:));
pCO2=[62.36 100 100 62.36];
H=[0 0 0.28482.*pCO2(3:4)+23.66786];
fill(pCO2,H,C(10,:),'EdgeColor',C(10,:));
%Mixed Metabolic and Respiratory Alkalosis
pCO2=[9 36.99 36.99 9];
H=[0 0 0.77332.*pCO2(3:4)+6.8872];
Z(11)=fill(pCO2,H,C(11,:),'EdgeColor',C(11,:));
pCO2=[37 51.80 51.80 37];
H=[0 0 -0.37272.*pCO2(3:4)+42.93068];
fill(pCO2,H,C(11,:),'EdgeColor',C(11,:));
%Mixed Acute and Chronic Respiratory Alkalosis
pCO2=[9 26.50 26.50 9];
H=[0.7068.*pCO2(1:2)+13.64852 0.4438.*pCO2(3:4)+20.70493];
Z(12)=fill(pCO2,H,C(12,:),'EdgeColor',C(12,:));
%Mixed Metabolic Acidosis and Respiratory Alkalosis
pCO2=[9 26.80 26.80 9];
H=[0.13015.*pCO2(1:2)+34.98438 -1.98855.*pCO2(3:4)+93.11307];
Z(13)=fill(pCO2,H,C(13,:),'EdgeColor',C(13,:));
pCO2=[26.81 36.99 36.99 26.80];
H=[0.13015.*pCO2(1:2)+34.98438 39.7 39.7];
Z(13)=fill(pCO2,H,C(13,:),'EdgeColor',C(13,:));
%Plot data
Z(14)=plot(y,x,'ko');
plot(y,x,'w*')

%Add labels
title('Nomogram')
xlabel('pCO2 (mmHg)')
ylabel('H^+ (nM)')
legend(Z,'Normal', ...
    'Metabolic Acidosis', 'Acute Respiratory Acidosis', 'Chronic Respiratory Acidosis',...
    'Metabolic Alkalosis', 'Acute Respiratory Alkalosis', 'Chronic Respiratory Alkalosis',...
    'Mixed Metabolic and Respiratory Acidosis', 'Mixed Acute and Chronic Respiratory Acidosis', ...
    'Mixed Metabolic Alkalosis and Respiratory Acidosis', 'Mixed Metabolic and Respiratory Alkalosis', ...
    'Mixed Acute and Chronic Respiratory Alkalosis', 'Mixed Metabolic Acidosis and Respiratory Alkalosis',...
    'Your data','Location','EastOutside')
axis equal
hold off
