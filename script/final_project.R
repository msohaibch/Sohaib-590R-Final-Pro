#libraries to load.

library(dplyr)
library(renv)
library(tidyverse)
library(here)
library(janitor)
library(gtsummary)
library(broom)
library(flextable)
#load the stroke dataset
stroke <- read_csv(here("data", "raw", "StrockDataset.csv"))

##Cleaning the data where gender=other, only 1 row
stroke <- stroke|>
	filter(is.na(gender) | tolower(gender) != "other")
#bmi to numeric and continous variable
stroke <- stroke %>% mutate(bmi = as.numeric(bmi))


stroke <- stroke |>
	mutate(
		# Gender
		gender = str_trim(gender),
		gender = factor(str_to_title(gender),
										levels = c("Male", "Female"),
										labels= c("Male", "Female")),

		# Hypertension
		hypertension = factor(hypertension,
													levels = c(0, 1),
													labels = c("No", "Yes")),

		# Heart disease
		heart_disease = factor(heart_disease,
													 levels = c(0, 1),
													 labels = c("No", "Yes")),

		# Ever married
		ever_married = factor(ever_married,
													levels = c("No", "Yes"),
													labels = c("No", "Yes")),

		# Work type
		work_type = factor(work_type,
											 levels = c("Private", "Self-employed", "Govt_job", "children", "Never_worked"),
											 labels = c("Private", "Self-employed", "Government Job", "Children", "Never Worked")),

		# Residence type
		residence_type = factor(Residence_type,
														levels = c("Urban", "Rural"),
														labels = c("Urban", "Rural")),

		# Smoking status
		smoking_status = factor(smoking_status,
														levels = c("formerly smoked", "never smoked", "smokes", "Unknown"),
														labels = c("Formerly Smoked", "Never Smoked", "Currently Smokes", "Unknown")),

		# Stroke outcome (0/1)
		stroke = factor(stroke,
										levels = c(0, 1),
										labels = c("No Stroke", "Stroke")),

		# Age groups
		age_group = cut(age,
										breaks = c(0, 20, 40, 60, Inf),
										labels = c("0-19", "20-39", "40-59", "60+"),
										right = FALSE),

		# BMI categories
		bmi_category = case_when(
			is.na(bmi) ~ NA_character_,
			bmi < 18.5 ~ "Underweight",
			bmi < 25   ~ "Normal",
			bmi < 30   ~ "Overweight",
			TRUE       ~ "Obese"
		),
		bmi_cat = factor(bmi_category,
										 levels = c("Underweight", "Normal", "Overweight", "Obese")),

		# Glucose categories
		glucose_category = case_when(
			avg_glucose_level < 100            ~ "Normal",
			avg_glucose_level < 126            ~ "Prediabetic",
			avg_glucose_level >= 126 | is.na(avg_glucose_level) ~ "Diabetic"
		),
		glucose_cat = factor(glucose_category,
												 levels = c("Normal", "Prediabetic", "Diabetic"))
	)


#table1 summary by stroke category

tbl_summary(
	stroke,
	by = stroke,
	include = c(
		age, age_group, bmi, gender, hypertension, heart_disease,
		ever_married, work_type, Residence_type,
		avg_glucose_level, glucose_cat, bmi_cat, smoking_status
	),
	label = list(
		age ~ "Age (years)",
		age_group ~ "Age Group",
		gender ~ "Gender",
		hypertension ~ "Hypertension",
		heart_disease ~ "Heart Disease",
		ever_married ~ "Ever Married",
		work_type ~ "Work Type",
		Residence_type ~ "Residence Type",
		avg_glucose_level ~ "Average Glucose Level (mg/dL)",
		glucose_cat ~ "Glucose Category",
		bmi ~ "Body Mass Index (kg/m²)",
		bmi_cat ~ "BMI Category",
		smoking_status ~ "Smoking Status"
	),
	# ensure BMI is summarized as continuous
	type = list(bmi ~ "continuous"),
	statistic = list(
		bmi ~ "{mean} ({p25}, {p75})"
	),
	digits = list(
		bmi ~ c(1, 1, 1)   # mean, p25, p75 to 1 decimal
	),
	missing_text = "Missing"
) |>
	add_p(
		test = list(
			all_continuous() ~ "t.test",
			all_categorical() ~ "chisq.test"
		),
		include = c(
			age, bmi, age_group, gender, hypertension, heart_disease,
			ever_married, Residence_type, avg_glucose_level, smoking_status
		)
	) |>
	add_overall(col_label = "**Total** N = {N}") |>
	bold_labels() |>
	modify_footnote(update = everything() ~ NA) |>
	modify_header(
		label = "**Variable**",
		p.value = "**P**"
	)






