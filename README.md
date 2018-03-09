# abnomogram
ABNOMOGRAM - Check the Acid-Base status of a blood samples.<br/>
This function executes the analysis of the Acid-Base status of a blood
sample given the pH and the pCO2 (in mmHg). The function plots a nomogram
with 13, differently coloured, zones. The zone in which your data fall 
represents the Acid-Base status of your blood sample. By itself, the
function plots a nomogram for a normal sample.

Syntax: 	ABNONOGRAM(pH,pCO2)
     
    Inputs:
          pH - Blood sample pH. This is a scalar value.
          pC02 - Blood sample pCO2. This is a scalar value.
    Outputs:
          - Nomogram plot

     Example: 
     abnomogram(7.4,40.5) will show a nomogram for a normal sample
     abnomogram(7.5,45) will show a nomogram with your data into the metabolic alkalosis zone

          Created by Giuseppe Cardillo
          giuseppe.cardillo-edta@poste.it

To cite this file, this would be an appropriate format:
Cardillo G. (2008) ABnomogram: check the acid-base status of a blood
sample. 
http://www.mathworks.com/matlabcentral/fileexchange/20571
