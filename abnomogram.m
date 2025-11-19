function abnomogram(pH, pCO2)
%ABNOMOGRAM Flenley acid-base nomogram (H+ vs pCO2)
%   ABNOMOGRAM(pH, pCO2) plots the Flenley acid-base nomogram and marks
%   the acid-base status of a blood sample given its pH and pCO2 (mmHg).
%
%   The x-axis represents pCO2 (mmHg), the y-axis represents [H+] in nM
%   (computed from pH as [H+] = 10^(-pH+9)). The coloured regions are an
%   analytical approximation of the original Flenley nomogram bands and
%   correspond to:
%       - Normal band
%       - Primary metabolic acidosis / alkalosis
%       - Acute / chronic respiratory acidosis / alkalosis
%       - Mixed metabolic + respiratory disturbances
%
%   INPUT
%     pH   - Blood pH (scalar, positive). Default: 7.40 if omitted/empty.
%     pCO2 - Blood pCO2 in mmHg (scalar, positive). Default: 40 mmHg.
%
%   OUTPUT
%     No variables are returned. The function creates a figure with the
%     nomogram and overlays the patient data point.
%
%   EXAMPLES
%     % Normal sample (near normal band)
%     abnomogram(7.40, 40.5);
%
%     % Metabolic alkalosis region
%     abnomogram(7.50, 45);
%
%     % Use default “normal” values (pH 7.40, pCO2 40 mmHg)
%     abnomogram;
%
%   NOTE
%     This implementation is intended for teaching and illustration of the
%     Flenley acid-base nomogram. It must NOT be used as a stand-alone
%     diagnostic tool or as a substitute for clinical judgment.
%
%   BACKGROUND
%     The original Flenley nomogram was constructed from in vivo
%     measurements of patients with “pure” acid-base disorders and
%     reported as graphical bands (see Flenley DC, Lancet, 1971). The
%     boundaries used here are a convenient analytical approximation of
%     those bands.
%
%   ------------------------------------------------------------------
%   Author and citation:
%   ------------------------------------------------------------------
%   Created by:  Giuseppe Cardillo
%   E-mail:      giuseppe.cardillo.75@gmail.com
%
%   To cite this file:
%   Cardillo G. (2008). abnomogram.m – Check the acid-base status of a
%   blood sample using a Flenley-style graphical nomogram.
%
%   GitHub repository:
%   https://github.com/dnafinder/abnomogram
%   ------------------------------------------------------------------

% ------------------------- Input handling ----------------------------

% Default values for a “normal” sample
default_pH   = 7.40;
default_pCO2 = 40;

if nargin < 1 || isempty(pH)
    pH = default_pH;
end
if nargin < 2 || isempty(pCO2)
    pCO2 = default_pCO2;
end

% Basic validation of inputs
validateattributes(pH,   {'numeric'}, {'scalar','real','finite','nonnan','positive'});
validateattributes(pCO2, {'numeric'}, {'scalar','real','finite','nonnan','positive'});

% Transform pH to [H+] in nM units: [H+] (nM) = 10^(-pH+9)
H_sample = 10.^(-pH + 9);

% Preallocate zone handle vector (13 colour zones + 1 data point)
Z = gobjects(1, 14);

% ------------------------- Colour palette ---------------------------
% 13 “medical-grade” colours for the different regions, scaled [0,1]:
%   - Normal         → green
%   - Acidosis       → warm reds/oranges
%   - Alkalosis      → cool blues/teals
%   - Mixed patterns → violets / ambers / olive-grey

C = [...
    0.39 0.80 0.36;   % 1  Normal (professional green)
    0.97 0.45 0.38;   % 2  Metabolic Acidosis (coral red)
    0.90 0.25 0.25;   % 3  Acute Respiratory Acidosis (strong red)
    0.70 0.18 0.18;   % 4  Chronic Respiratory Acidosis (deep red)
    0.33 0.70 0.95;   % 5  Metabolic Alkalosis (bright sky blue)
    0.14 0.56 0.85;   % 6  Acute Respiratory Alkalosis (clinical blue)
    0.00 0.47 0.66;   % 7  Chronic Respiratory Alkalosis (teal-blue)
    0.98 0.72 0.25;   % 8  Mixed Metabolic + Respiratory Acidosis (amber)
    0.85 0.55 0.20;   % 9  Mixed Acute + Chronic Respiratory Acidosis (brown-orange)
    0.68 0.72 0.54;   % 10 Mixed Metab Alkalosis + Respiratory Acidosis (olive-grey)
    0.55 0.55 0.85;   % 11 Mixed Metab + Respiratory Alkalosis (indigo)
    0.77 0.45 0.87;   % 12 Mixed Acute + Chronic Respiratory Alkalosis (lavender violet)
    0.84 0.60 0.52];  % 13 Mixed Metab Acidosis + Respiratory Alkalosis (clay rose)

% ------------------------- Figure and axes --------------------------
figure('Color', 'w', 'Position', [100 100 960 720]);
hold on
box on
grid on

% Semi-transparent patches with no edges: visually continuous zones
patchAlpha = 0.72;
edgeCol    = 'none';

% ------------------------- Normal region ----------------------------
pc = [37 37 44 44];
H  = [35.50 44.70 44.70 35.50];
Z(1) = fill(pc, H, C(1,:), 'EdgeColor', edgeCol, 'FaceAlpha', patchAlpha);

% ------------------------- Metabolic Acidosis -----------------------
pc = [9 18.07 18.07 9];
H  = [-1.98855.*pc(1:2)+93.11307 100 100];
Z(2) = fill(pc, H, C(2,:), 'EdgeColor', edgeCol, 'FaceAlpha', patchAlpha);

pc = [18.08 26.81 26.81 18.08];
H  = [-1.98855.*pc(1:2)+93.11307 -1.90016.*pc(3:4)+115.00586];
fill(pc, H, C(2,:), 'EdgeColor', edgeCol, 'FaceAlpha', patchAlpha);

pc = [26.82 36.99 36.99 26.82];
H  = [-1.90016.*pc(1:2)+115.00586 39.8 39.8];
fill(pc, H, C(2,:), 'EdgeColor', edgeCol, 'FaceAlpha', patchAlpha);

% ------------------------- Acute Respiratory Acidosis ---------------
pc = [44.01 100 100 44.01];
H  = [0.75036.*pc(1:2)+5.94429 0.77929.*pc(3:4)+10.41143];
Z(3) = fill(pc, H, C(3,:), 'EdgeColor', edgeCol, 'FaceAlpha', patchAlpha);

% ------------------------- Chronic Respiratory Acidosis -------------
pc = [44.01 57.83 57.83 44.01];
H  = [0.28482.*pc(1:2)+23.66786 0.76645.*pc(3:4)+5.17621];
Z(4) = fill(pc, H, C(4,:), 'EdgeColor', edgeCol, 'FaceAlpha', patchAlpha);

pc = [57.84 100 100 57.84];
H  = [0.28482.*pc(1:2)+23.66786 0.36827.*pc(3:4)+28.20287];
fill(pc, H, C(4,:), 'EdgeColor', edgeCol, 'FaceAlpha', patchAlpha);

% ------------------------- Metabolic Alkalosis (original position) ----------------------
pc = [37 44 44 37];
H  = [-0.37272.*pc(1:2)+42.93068 35.49 35.49];
Z(5) = fill(pc, H, C(5,:), 'EdgeColor', edgeCol, 'FaceAlpha', patchAlpha);

pc = [44.01 48.18 48.18 44.01];
H  = [-0.37272.*pc(1:2)+42.93068 0.36516.*pc(3:4)+20.13317];
fill(pc, H, C(5,:), 'EdgeColor', edgeCol, 'FaceAlpha', patchAlpha);

pc = [48.19 51.80 51.80 48.19];
H  = [-0.37272.*pc(1:2)+42.93068 -0.25989.*pc(3:4)+50.25395];
fill(pc, H, C(5,:), 'EdgeColor', edgeCol, 'FaceAlpha', patchAlpha);

pc = [51.81 62.35 62.35 51.81];
H  = [0 0 -0.25989.*pc(3:4)+50.25395];
fill(pc, H, C(5,:), 'EdgeColor', edgeCol, 'FaceAlpha', patchAlpha);

% ------------------------- Acute Respiratory Alkalosis --------------
pc = [9 36.99 36.99 9];
H  = [0.77332.*pc(1:2)+6.8872 0.7068.*pc(3:4)+13.64852];
Z(6) = fill(pc, H, C(6,:), 'EdgeColor', edgeCol, 'FaceAlpha', patchAlpha);

% ------------------------- Chronic Respiratory Alkalosis ------------
pc = [9 26.50 26.50 9];
H  = [0.44379.*pc(1:2)+20.70493 0.13015.*pc(3:4)+34.98438];
Z(7) = fill(pc, H, C(7,:), 'EdgeColor', edgeCol, 'FaceAlpha', patchAlpha);

pc = [26.51 36.99 36.99 26.51];
H  = [0.69876.*pc(1:2)+13.94585 0.13015.*pc(3:4)+34.98438];
fill(pc, H, C(7,:), 'EdgeColor', edgeCol, 'FaceAlpha', patchAlpha);

% ---------------- Mixed Metabolic and Respiratory Acidosis ----------
pc = [18.08 36.99 36.99 18.07];
H  = [-1.90016.*pc(1:2)+115.00586 100 100];
Z(8) = fill(pc, H, C(8,:), 'EdgeColor', edgeCol, 'FaceAlpha', patchAlpha);

pc = [37 44 44 37];
H  = [44.71 44.71 100 100];
fill(pc, H, C(8,:), 'EdgeColor', edgeCol, 'FaceAlpha', patchAlpha);

pc = [44.01 100 100 44.01];
H  = [0.77929.*pc(1:2)+10.41143 100 100];
fill(pc, H, C(8,:), 'EdgeColor', edgeCol, 'FaceAlpha', patchAlpha);

% -------- Mixed Acute and Chronic Respiratory Acidosis --------------
pc = [57.84 100 100 57.84];
H  = [0.75036.*pc(1:2)+5.94429 0.36827.*pc(3:4)+28.20287];
Z(9) = fill(pc, H, C(9,:), 'EdgeColor', edgeCol, 'FaceAlpha', patchAlpha);

% -- Mixed Metabolic Alkalosis and Respiratory Acidosis --------------
pc = [48.20 62.35 62.35 48.20];
H  = [-0.25989.*pc(1:2)+50.25395 0.28482.*pc(3:4)+23.66786];
Z(10) = fill(pc, H, C(10,:), 'EdgeColor', edgeCol, 'FaceAlpha', patchAlpha);

pc = [62.36 100 100 62.36];
H  = [0 0 0.28482.*pc(3:4)+23.66786];
fill(pc, H, C(10,:), 'EdgeColor', edgeCol, 'FaceAlpha', patchAlpha);

% ---- Mixed Metabolic and Respiratory Alkalosis ---------------------
pc = [9 36.99 36.99 9];
H  = [0 0 0.77332.*pc(3:4)+6.8872];
Z(11) = fill(pc, H, C(11,:), 'EdgeColor', edgeCol, 'FaceAlpha', patchAlpha);

pc = [37 51.80 51.80 37];
H  = [0 0 -0.37272.*pc(3:4)+42.93068];
fill(pc, H, C(11,:), 'EdgeColor', edgeCol, 'FaceAlpha', patchAlpha);

% -- Mixed Acute and Chronic Respiratory Alkalosis -------------------
pc = [9 26.50 26.50 9];
H  = [0.7068.*pc(1:2)+13.64852 0.4438.*pc(3:4)+20.70493];
Z(12) = fill(pc, H, C(12,:), 'EdgeColor', edgeCol, 'FaceAlpha', patchAlpha);

% -- Mixed Metabolic Acidosis and Respiratory Alkalosis --------------
pc = [9 26.80 26.80 9];
H  = [0.13015.*pc(1:2)+34.98438 -1.98855.*pc(3:4)+93.11307];
Z(13) = fill(pc, H, C(13,:), 'EdgeColor', edgeCol, 'FaceAlpha', patchAlpha);

pc = [26.81 36.99 36.99 26.80];
H  = [0.13015.*pc(1:2)+34.98438 39.7 39.7];
fill(pc, H, C(13,:), 'EdgeColor', edgeCol, 'FaceAlpha', patchAlpha);

% ------------------------- Plot user data ---------------------------
Z(14) = plot(pCO2, H_sample, 'o', ...
    'MarkerFaceColor', [0 0.2 0.6], ...
    'MarkerEdgeColor', [0 0.1 0.3], ...
    'MarkerSize', 8);
plot(pCO2, H_sample, 'w*', 'MarkerSize', 6);

% Annotate pH and pCO2 near the point
text(pCO2 + 1, H_sample, ...
    sprintf('  pH = %.2f, pCO_2 = %.1f mmHg', pH, pCO2), ...
    'Color', 'k', 'FontSize', 9, 'Interpreter', 'tex');

% ------------------------- Labels and legend ------------------------
title('Flenley Acid-Base Nomogram (H^+ vs pCO_2)', ...
      'FontSize', 14, 'FontWeight', 'bold');
xlabel('pCO_2 (mmHg)', 'FontSize', 12);
ylabel('[H^+] (nM)',   'FontSize', 12);

set(gca, 'FontSize', 11, ...
         'XLim', [9 100], ...
         'YLim', [0 100], ...
         'LineWidth', 1, ...
         'XColor', [0.2 0.2 0.2], ...
         'YColor', [0.2 0.2 0.2]);

axis equal

legend(Z, ...
    'Normal', ...
    'Metabolic Acidosis', ...
    'Acute Respiratory Acidosis', ...
    'Chronic Respiratory Acidosis', ...
    'Metabolic Alkalosis', ...
    'Acute Respiratory Alkalosis', ...
    'Chronic Respiratory Alkalosis', ...
    'Mixed Metabolic + Respiratory Acidosis', ...
    'Mixed Acute + Chronic Respiratory Acidosis', ...
    'Mixed Metabolic Alkalosis + Respiratory Acidosis', ...
    'Mixed Metabolic + Respiratory Alkalosis', ...
    'Mixed Acute + Chronic Respiratory Alkalosis', ...
    'Mixed Metabolic Acidosis + Respiratory Alkalosis', ...
    'Your data', ...
    'Location', 'EastOutside', ...
    'FontSize', 9);

hold off

end
