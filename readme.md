***Epidemiology 590R R Bootcamp Course Final Project***

This repository contains a fully reproducible analysis for the EPI 590R final project.  
It uses **R**, **Quarto**, and the **{here}** package for robust, portable file paths.

## Repository layout

- `data/` – input data (raw & clean)
- `reports/` – Quarto report + results
- `r/` – R scripts and helper code
- `script/` – working script
- `outputs/` – (tables, figures, derived data)
- `.Rproj` – RStudio project file

> This layout mirrors the current repo folders visible on GitHub. If you rename files, just update the commands in the script or qmd.

## Data

- **Source:** Figshare — *Predicting Stroke Risk Dataset*  
  https://figshare.com/articles/dataset/_b_Predicting_Stroke_Risk_Dataset_b_/28668398  
  Variables include demographics (e.g., `age`, `gender`, `ever_married`, `work_type`, `residence_type`), clinical/labs (`hypertension`, `heart_disease`, `avg_glucose_level`, `bmi`), lifestyle (`smoking_status`), and binary outcome `stroke` (No/Yes).

- **Local processing:** The analysis performs light cleaning (type coercions, factor labels) and derives `age_group` via a custom function to support descriptive summaries and modeling.

##How to start

1) **Open** the project in RStudio (or your R environment) at the repository root.

2) **Install packages** (first time only) in Final_project.r script file. 

3) Run the Final 590r Sohaib.qmd file and render the qmd and it will give the output.



***open to any suggestion, corrections or improvements. 

