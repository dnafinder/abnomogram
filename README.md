🩸 abnomogram.m — MATLAB Flenley Acid-Base Nomogram (H⁺ vs pCO₂)

abnomogram.m is a MATLAB implementation of the Flenley acid-base nomogram, plotting [H⁺] in nM versus pCO₂ in mmHg and highlighting the acid-base status of a blood sample based on its pH and pCO₂.

The nomogram is divided into 13 coloured regions representing normal, primary metabolic/respiratory acidosis or alkalosis, and various mixed acid-base disorders. A point corresponding to the patient’s data is overlaid on the diagram.

⚠️ This tool is intended for educational and illustrative purposes only and must not be used as a standalone diagnostic tool.

✨ Features

📊 Flenley-style acid-base nomogram (H⁺ vs pCO₂)

🟢 Normal band plus primary:

Metabolic acidosis / alkalosis

Acute respiratory acidosis / alkalosis

Chronic respiratory acidosis / alkalosis

🟣 Additional mixed-disorder regions for combined metabolic + respiratory disturbances

🎯 Patient data point plotted with annotation (pH and pCO₂)

🎨 Medical-grade colour palette with semi-transparent regions and no internal patch edges

📦 Repository

GitHub: https://github.com/dnafinder/abnomogram

🛠 Requirements

MATLAB with basic graphics capabilities

No additional toolboxes required

🚀 Usage

Basic example (near normal):

abnomogram(7.40, 40.5)

Metabolic alkalosis example:

abnomogram(7.50, 45)

Use default “normal” values (pH 7.40 and pCO₂ 40 mmHg):

abnomogram

The function will:

Convert pH to [H⁺] (nM) via [H⁺] = 10^(−pH + 9)

Draw the 13 Flenley-like regions (normal, primary, mixed)

Plot your sample as a coloured marker with a white star

Add a label with “pH = …, pCO₂ = … mmHg” next to the point

🧠 Function Summary

abnomogram(pH, pCO2)

Input:
• pH — scalar, blood pH (default: 7.40 if omitted or empty)
• pCO2 — scalar, pCO₂ in mmHg (default: 40 mmHg if omitted or empty)

Output:
• No variables are returned. The function creates a graphical Flenley nomogram with the sample location highlighted.

📚 Background

The original Flenley nomogram was constructed from in vivo data of patients with “pure” acid-base disorders, and published as graphical bands in the early 1970s (Flenley DC, Lancet 1971). The regions in this implementation are a practical analytical approximation of those bands, designed for teaching and demonstration of acid-base patterns.

📚 Citation

If you use this function in teaching material, lectures, or publications, please cite:

Cardillo G. (2008). abnomogram.m – Check the acid-base status of a blood sample using a Flenley-style graphical nomogram.
GitHub: https://github.com/dnafinder/abnomogram

🔑 License

Please refer to the LICENSE file in this repository for licensing details.

👤 Author

Giuseppe Cardillo
Email: giuseppe.cardillo.75@gmail.com
