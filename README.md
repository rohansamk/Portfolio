ABSTRACT
This project applies multivariate analysis techniques to a heart disease dataset to enhance prediction accuracy and understand the relationships among clinical and demographic variables. By utilizing methods such as Principal Component Analysis, Factor Analysis, Discriminant Analysis, Canonical Correlation Analysis, Redundancy Analysis, and Partial Least Squares Regression, the study identifies key predictors and latent factors contributing to heart disease. The analyses reveal that PCA effectively reduces data dimensionality while retaining critical information, and Factor Analysis uncovers latent dimensions within clinical tests. Discriminant Analysis demonstrates high accuracy in classifying patients with and without heart disease, while CCA and Redundancy Analysis highlight significant interactions between patient characteristics and clinical measurements. PLS Regression identifies crucial predictors and constructs latent variables that enhance predictive power. The results show that these techniques not only classify patients accurately but also provide significant insights into the multifactorial nature of heart disease, ultimately improving diagnosis and management. This comprehensive approach underscores the value of integrating advanced analytical methods to better understand and predict heart disease, contributing to more effective healthcare strategies.

1.	INTRODUCTION
Heart disease remains a leading cause of morbidity and mortality worldwide, significantly impacting global public health. According to the World Health Organization, cardiovascular diseases account for nearly 17.9 million deaths annually, representing approximately 31% of all global deaths. Among these, heart disease is a predominant contributor, encompassing various conditions such as coronary artery disease, heart failure, and arrhythmias. The high prevalence and severe consequences of heart disease necessitate early and accurate diagnosis, which can lead to better management and improved patient outcomes (World Health Organization, 2019).
The complexity of heart disease arises from its multifactorial nature, where numerous clinical, demographic, and lifestyle factors interact to influence its onset and progression. Clinical attributes such as blood pressure, cholesterol levels, and heart rate, along with demographic factors like age and sex, play crucial roles in determining an individual's risk (Lloyd-Jones et al., 2010). Given the intricate interplay of these variables, advanced analytical techniques are essential to unravel these relationships and enhance predictive accuracy (James et al., 2013).
The study aims to achieve the following:
1.	Identify Underlying Dimensions of Risk Factors: Use Factor Analysis to uncover latent dimensions within clinical tests that explain the variance in heart disease outcomes (Tabachnick & Fidell, 2013).
2.	Discriminate Between Heart Disease Presence and Absence: Apply Discriminant Analysis to develop a predictive model that effectively classifies patients based on the likelihood of having heart disease (Hair et al., 2014).
3.	Explore Interactions Between Patient Characteristics and Clinical Measurements: Utilize Canonical Correlation Analysis (CCA) to measure the relationships between patient demographics, symptoms, and clinical measurements (Hotelling, 1936).
4.	Explain Variability in Heart Disease Severity: Conduct Redundancy Analysis to quantify how well clinical measurements explain the variability in heart disease severity, building on findings from CCA (Wold, 1985).
5.	Predict Heart Disease Using Principal Components: Implement Principal Component Analysis (PCA) followed by logistic regression to reduce data dimensionality and enhance predictive power (Jolliffe, 2002).
6.	Employ Partial Least Squares (PLS) Regression: Evaluate the effectiveness of PLS regression in constructing latent variables that maximize the covariance between predictors and heart disease presence (James et al., 2013).
Through these methodologies, the analysis aims to understand the factors influencing heart disease and develop predictive models for early diagnosis and management of heart diseases.

2.	DATASET DESCRIPTION
The dataset used for this analysis is sourced from the UCI Machine Learning Repository, specifically collected at the Cleveland Clinic Foundation. It comprises medical attributes of 920 patients, each evaluated for heart disease presence. The dataset includes a mix of clinical and demographic variables.
 
Figure 1: Dataset Description
3.	METHODOLOGY FOR ANALYSIS
In this project, most variables were standardized as part of the SAS procedures. Specifically, the logistic regression and principal component analysis (PCA) methods utilized standardized data. The only transformation applied was to the 'num' variable, which was converted into a binary format (presence or absence of heart disease) for some of the analyses.
The dataset had incomplete entries for some patients across one or more variables. To mitigate this issue, the k-Nearest Neighbours (kNN) algorithm was employed for imputing missing values. This method effectively estimates missing values by considering the 'k' most similar observations and imputing the missing data points based on their values. This approach helps maintain the integrity of the dataset and allows for a comprehensive analysis without excluding cases with missing values.


4.	EXPLORATORY TECHNIQUES

4.1	Multifactorial Dimensions of Risk Factors

Hypothesis: There are underlying dimensions (factors) among clinical tests that explain the variance in heart disease outcomes.

Technique: With Factor Analysis, the latent factors can identify in variables like blood pressure, cholesterol, heart rate, and others that might contribute to heart disease. This analysis can reveal hidden structures and common sources of variability.


The decision on the number of factors to retain in Factor Analysis is guided by the eigenvalues and the proportion of variance explained. In this analysis, the output indicated that Factor 1 had an eigenvalue of 2.3675, which is greater than 1, and Factor 2 had an eigenvalue of 0.6880, which is less than 1. Despite the Kaiser criterion suggesting retaining only Factor 1, the proportion criterion indicated that retaining two factors would be beneficial, as they collectively explain a significant portion of the variance. Factor 1 explains about 86% of the total variance and  factor 2 explains another 25% together explaining about 111% of the variance.


 
Figure 2: Eigen Values


Explanation of the Factors and Loadings:
Factor 1 seems to represent a dimension related to the severity of heart disease. High loadings on thalch (maximum heart rate achieved, negative), exang (exercise-induced angina), oldpeak (ST depression), Slope (slope of the peak exercise ST segment), and Thal (thalassemia status) suggest this factor captures the clinical severity and physiological stress indicators of heart disease. Factor 2 appears to capture a dimension related to general health and demographic characteristics. High loadings on chol (cholesterol), RestECG (resting electrocardiographic results), age, and trestbps (resting blood pressure) suggest this factor captures the metabolic and age-related risk factors contributing to heart disease.










Should Varimax Rotation be used?
While the current factor loadings provide a meaningful interpretation, applying Varimax rotation can help simplify the interpretation further by making the factor loadings clearer and more distinct.

Figure 3: Factor Pattern
Factor Analysis Results (Varimax Rotation) Factor 1 represents clinical severity and specific characteristics of heart disease. High negative loadings on thalch (maximum heart rate) indicate its strong association with disease severity, as lower rates are seen in severe cases. Positive loadings on exang and ca (number of major vessels colored) highlight their importance in determining disease severity. CP (chest pain type), Slope (peak exercise ST segment slope), and Thal also contribute to understanding clinical manifestations. Factor 2 captures general health, age, and metabolic risk factors. High loadings on age and trestbps (resting blood pressure) indicate their roles as significant risk factors. Positive loadings on oldpeak (ST depression) and RestECG underscore their importance in assessing heart disease risk.

 
Figure 4: Factor Patter After Varimax Rotation



The rotated factor pattern and path diagram clearly visualize the relationships between latent factors and observed variables, supporting the hypothesis that underlying dimensions among clinical tests explain the variance in heart disease outcomes. These factors reveal hidden structures and common sources of variability, providing valuable insights into the multifactorial nature of heart disease.



Figure 5: Rotated Factor Pattern










































The factor analysis confirms that underlying dimensions among clinical tests explain the variance in heart disease outcomes. This analysis highlights the significance of both clinical severity markers and general health/metabolic risk factors in understanding and managing heart disease. By identifying these latent factors, healthcare providers can better stratify patients based on risk and tailor interventions to address specific dimensions of heart disease risk and severity.
4.2	Relation Between Patient Characteristics and Clinical Measurements

Hypothesis:
There is a significant interaction between Patient Characteristics and Symptoms and clinical measurements that correlates with the severity of heart disease.

Technique:
Canonical Correlation Analysis (CCA) to explore and measure the relationships between two sets of variable Patient Characteristics and Symptoms and clinical measurements. This technique will help identify pairs of canonical variables from each set that have the highest correlations.

To perform Canonical Correlation Analysis, the dataset is divided into: 
•	Category 1 (Patient Characteristics and Symptoms): This group includes demographic factors and symptoms/conditions that are directly measured during patient evaluation.
•	Category 2 (Clinical Measurements): This group focuses on clinical tests and measurements that are obtained through diagnostic procedures.

 
Figure 7:Variable Classification

 
Figure 8:Canonical Correlation
The first four canonical correlations are statistically significant, indicating meaningful relationships between sets of variables. The first canonical correlation is the strongest (0.729437), explaining about 53.21% of the variance. The fifth and sixth canonical correlations are not statistically significant. Based on these results, only the first four canonical correlations for further analysis and interpretation.
 
Figure 9

All four multivariate statistics (Wilks' Lambda, Pillai's Trace, Hotelling-Lawley Trace, and Roy's Greatest Root) indicate highly significant canonical correlations, proving a strong relationship between the two sets of variables.

 
Figure 10:Patient Characteristics and Symptoms with Their Canonical Variables
Chest Pain Type (CP) shows a strong negative correlation with Char1, indicating that higher values of Char1 are associated with less severe chest pain types. Conversely, CP has a strong positive correlation with Char4, suggesting that higher values of Char4 are linked to more severe chest pain types.
Fasting Blood Sugar (fbs) has a moderate positive correlation with Char2, indicating its association with this canonical variable. Exercise-Induced Angina (exang) shows a strong positive correlation with Char1, suggesting that this symptom is significantly related to Char1.
The Slope of the Peak Exercise ST Segment (Slope) has strong positive correlations with Char1 and moderate negative correlations with Char2 and Char3, indicating complex interactions with these canonical variables. Thalassemia Status (Thal) shows a strong negative correlation with Char3 and a moderate positive correlation with Char4, indicating its significant relationship with these canonical variables.
Sex has moderate negative correlations with Char3 and Char4, indicating its relationship with these canonical variables. Age has strong positive correlations with Char1 and Char2, highlighting its significant association with these canonical variables.
 
Figure 11: Clinical Measurements with Their Canonical Variables
Resting Blood Pressure has moderate correlations with Clin1 and Clin2, and a strong correlation with Clin4, indicating its influence on these canonical variables. Cholesterol shows a strong correlation with Clin3, suggesting its significant relationship with this canonical variable. Maximum Heart Rate Achieved has a strong negative correlation with Clin1, indicating its significant inverse relationship with this canonical variable.
ST Depression Induced by Exercise has a strong positive correlation with Clin1 and a moderate negative correlation with Clin2, highlighting its relationship with these canonical variables. The Number of Major Vessels Colored by Fluoroscopy has moderate correlations with Clin1 and a moderate negative correlation with Clin3, indicating its complex interactions with these canonical variables. Resting Electrocardiographic Results shows a strong positive correlation with Clin2, indicating its significant relationship with this canonical variable.
Interactions Between Patient Characteristics and Clinical Measurements
Chest Pain Type has a moderate negative correlation with Clin1, suggesting its relationship with this canonical variable. Exercise-Induced Angina and Slope both show moderate correlations with Clin1, indicating their combined impact on the clinical measurements. Age has moderate correlations with Clin1 and Clin2, reinforcing its role as a critical factor in the interaction between patient characteristics and clinical measurements.
 
Figure 12
Maximum Heart Rate Achieved (thalach) shows a strong negative correlation with Char1, indicating its significant inverse relationship with this canonical variable. ST Depression Induced by Exercise (oldpeak) has a moderate positive correlation with Char1, suggesting its association with this canonical variable. 
 
Figure 13
The results provide a comprehensive picture of how patient characteristics, symptoms, and clinical measurements interact to influence heart disease severity:
•	Chest Pain Type (CP) and Age: Show significant correlations with multiple canonical variables, suggesting these factors play a crucial role in heart disease severity. Severe chest pain and older age are strongly associated with the canonical variables representing heart disease severity.
•	Exercise-Induced Angina (exang) and Slope: Show strong correlations with with the first canonical variabl, indicating they are significant predictors of heart disease severity. Their interactions with clinical measurements highlight the importance of these symptoms.
•	Thalassemia Status (Thal) and Sex: Show significant correlations with several canonical variables, indicating their combined impact on heart disease.
•	Clinical measurements: Such as trestbps, chol, and thalach are strongly correlated with their respective canonical variables, emphasizing their importance in diagnosing and assessing heart disease severity.
The CCA results support the hypothesis that there is a significant interaction between Patient Characteristics and Symptoms and Clinical Measurements that correlates with the severity of heart disease. The identified canonical correlations and their detailed structure underscore the importance of considering both sets of variables for a comprehensive assessment of heart disease. This analysis highlights the value of integrating demographic, symptomatic, and clinical measurement data to understand and predict heart disease severity effectively.


4.3	Redundancy Analysis of Variance Explanation
Hypothesis: 
The redundancy analysis can effectively quantify the proportion of variance in one set of variables  Clinical Measurements that can be explained by the canonical variables of Patient Characteristics and Symptoms. 
This hypothesis continues from Hypothesis 3, building on the findings of the Canonical Correlation Analysis.
Technique: 
Redundancy analysis follows Canonical Correlation Analysis to evaluate the explanatory power of the canonical variables derived from one set of variables in predicting the variance in another set of variables. 
The raw variance explained table shows the proportion of variance in each set of variables explained by their own canonical variables and by the canonical variables of the opposite set. For Patient Characteristics and Symptoms, the first canonical variable explained a significant portion of the variance, with the first four canonical variables explaining a substantial cumulative proportion. The canonical variables from Clinical Measurements explained a smaller proportion of the variance in Patient Characteristics and Symptoms, with a modest cumulative proportion.
 
Figure 14: Canonical Redundancy Analysis

For Clinical Measurements, the first canonical variable explained a small proportion of the variance, with the first four canonical variables explaining a substantial cumulative proportion. The canonical variables from Patient Characteristics and Symptoms explained a minimal portion of the variance in Clinical Measurements, with a modest cumulative proportion.
 
Figure 15: Canonical Redundancy Analysis Raw Variance

Standardized Variance Explained: For Patient Characteristics and Symptoms, the first canonical variable explained 28.56% of the standardized variance, with a cumulative proportion of 67.11%. The canonical variables from Clinical Measurements explained 15.20% of the standardized variance, with a cumulative proportion of 17.51%.
 
Figure 16: Canonical Redundancy Analysis Standard Variance
For Clinical Measurements, the first canonical variable explained 24.36% of the standardized variance, with a cumulative proportion of 74.06%. The canonical variables from Patient Characteristics and Symptoms explained 12.96% of the standardized variance, with a cumulative proportion of 15.88%.
 
The squared multiple correlations tables show how much each original variable is explained by the canonical variables of the other set. For Patient Characteristics and Symptoms, Chest Pain Type  has a maximum variance explained by the fourth canonical variable, while Fasting Blood Sugar shows very low variance explained. Exercise-Induced Angina demonstrates moderate variance explained. The Slope of the Peak Exercise ST Segment has substantial variance explained. Thalassemia Status also shows moderate variance explained. Sex has slightly increasing variance explained, and Age is consistently explained by the canonical variables.
 
For Clinical Measurements, the variance explained by the canonical variables is as follows: Resting Blood Pressure increases slightly to a maximum of 7.09%, while Cholesterol reaches 7.52%. A substantial portion of the variance is explained for Maximum Heart Rate Achieved at 33.56% and ST Depression Induced by Exercise at 25.92%. The Number of Major Vessels Colored by Fluoroscopy has a maximum of 14.02%, and Resting Electrocardiographic Results show an increase to 7.18%.
 
The redundancy analysis results show how well the canonical variables represent the original variables in each set. This reinforces the findings from Canonical Correlation Analysis and supports the hypothesis of a significant interaction between Patient Characteristics and Symptoms and Clinical Measurements, correlating with heart disease severity. The significant redundancy indices highlight the predictive power of the canonical variables, underscoring their importance in clinical assessments and management of heart disease.

5.	PREDICTIVE DATA ANALYSIS
5.1	Discrimination of Heart Disease Presence

Hypothesis:
A combination of clinical and demographic variables can effectively discriminate between patients with and without heart disease.

Technique:
Discriminant Analysis can be done to develop a predictive model that classifies patients based on the chances of having heart disease. This technique will use linear combinations of predictors to create a decision rule for classification.

First I ran the Stepwise Discriminant Analysis to select the most significant variables that can discriminate between patients with and without heart disease. After performing the stepwise discriminant analysis, it was observed that all variables contributed significantly to the discrimination between patients with and without heart disease. It has been decided to include all these variables in the subsequent discriminant analysis to ensure that no potentially important predictor is excluded. 

Discriminant analysis aims to determine which variables discriminate between patients with and without heart disease. The goal is to create a predictive model that can classify patients into these two categories based on their clinical and demographic characteristics. To perform discriminant analysis, the dataset was divided into two groups: patients with heart disease and patients without heart disease.


 
Figure 17: Class Level Information

The dataset includes 920 observations, with 411 (44.67%) classified as having no heart disease (0) and 509 (55.33%) classified as having heart disease. Prior probabilities were set equally at 0.5 for both groups to ensure balanced classification during discriminant analysis.


The p-value (Pr>ChiSq) is less than .0001, indicating a highly significant result. Low p-value suggests that the likelihood of observing such a large Chi-Square value under the null hypothesis (equal covariance matrices) is extremely low, indicating different covariance matrices for two groups. Therefore, Quadratic Discriminant Analysis is needed instead of Linear Discriminant Analysis.

 
Figure 18:Discriminant Analysis
Out of 411 patients without heart disease, the model correctly classified 342 (83.21%) and misclassified 69 (16.79%). For the 509 patients with heart disease, it correctly classified 426 (83.69%) and misclassified 83 (16.31%).

 Figure 19: Classification Summary Discriminant Analysis

Overall, the model classified 425 patients (46.20%) as not having heart disease and 495 patients (53.80%) as having heart disease out of 920 total patients. The misclassification rate is 16.55%, indicating that the model misclassified approximately 16.55% of the patients.
 
Figure 20: Error Estimates

The analysis demonstrated that clinical and demographic variables can effectively discriminate between patients with and without heart disease, correctly classifying approximately 83% of both groups with a misclassification rate of around 16%. This supports the hypothesis that these variables can effectively classify patients based on heart disease status, making the model valuable for early detection and management in clinical settings.



5.2	Principal Components of Heart Disease Prediction

Hypothesis:
Principal components derived from the dataset can predict heart disease more effectively than individual variables.

Technique:
Principal Component Analysis (PCA) was employed to reduce the dimensionality of the dataset, followed by using the principal components as predictors in a logistic regression model to predict heart disease. The hypothesis posits that this approach will enhance predictive power compared to using the original variables directly.
The logistic regression model with original variables predicted heart disease presence effectively. It had an AIC of 788.152 and a -2 Log L of 760.152, indicating a good fit. Key predictors included sex, cholesterol, fasting blood sugar, exercise-induced angina, ST depression, number of major vessels coloured, chest pain type, and thalassemia. The model achieved an 89.1% concordance rate, indicating strong predictive power. Somers' D was 0.781, and the c-statistic was 0.891, reflecting robust performance.
 
Figure 21: Model Statistics

PCA was conducted on the dataset to reduce its dimensionality. Thirteen original variables were transformed into principal components, with the first three principal components retained. These three PCs accounted for 44.67% of the total variance, striking a balance between complexity and interpretability. The eigenvalues and eigenvectors from PCA demonstrated how much of the original variance each component explained. The first three components provided substantial information, making them suitable for use in the subsequent logistic regression model.
   
A logistic regression model was then built using the first three principal components (Prin1, Prin2, Prin3) as predictors. This model aimed to predict heart disease presence using the condensed information from the PCA. The model's fit statistics showed an AIC of 817.699 and a -2 Log L of 809.699. Although these values were slightly higher than those of the original variables model, indicating a less optimal fit, the principal components provided an insightful alternative representation of the data.
  
The parameter estimates revealed that the first principal component (Prin1) was a significant predictor (Estimate = 1.1023, p < 0.0001), while Prin2 and Prin3 were not significant. Prin1's strong association highlights that this component encapsulated the majority of the variance explained by the original predictors related to heart disease. The percent concordant for this model was 87.6%, with Somers' D at 0.751 and the c-statistic at 0.876. These metrics, while slightly lower than those of the original variables model, still indicate good predictive performance.
 
Figure 22: Model Statistics of PCA + LR

Comparison and Interpretation
Comparing logistic regression models, the original variables performed better with a higher percent concordant (89.1% vs. 87.6%) and c-statistic (0.891 vs. 0.876), indicating more accurate heart disease predictions. The PCA-based model also performed well, reducing dimensionality while maintaining predictive power. Using principal components simplifies the model, enhances interpretability, and reduces overfitting risk.
The original variables model outperformed the PCA-based model for several reasons:
1.	Information Loss: PCA reduces dimensionality but can lose some information. The first three principal components captured 44.67% of the variance, leaving out potentially valuable information in the remaining components (Jolliffe, 2002).
2.	Complexity of Heart Disease: Heart disease is influenced by various factors. Using the original variables directly captures nuanced relationships and interactions that might be lost in the principal components (Chandrashekar & Sahin, 2014).
3.	Interpretability: The original variables model retains interpretability, with each coefficient corresponding to a specific variable. Principal components are linear combinations, making it harder to understand each variable's impact (Mazza & Punzo, 2014).
4.	Variance Explanation: The first three principal components may not capture all critical variance needed for optimal prediction. Including more components could improve the model but increase complexity and reduce interpretability (Jolliffe, 2002).
5.	Multicollinearity: The original variables model can handle multicollinearity, while PCA creates orthogonal components. This can dilute the predictive power if influential variables are spread across multiple components (Soromenho, 1991).
The hypothesis that principal components predict heart disease effectively was partially supported. The original variables model performed slightly better, but the PCA-based model showed the viability of using principal components for prediction. This approach provides a more parsimonious model, valuable for simplicity and interpretability alongside accuracy. Future studies could explore combining PCA with other dimensionality reduction techniques to optimize predictive performance.


5.3	Predicting Heart Disease Using Partial Least Squares Regression

Hypothesis: 
Partial Least Squares (PLS) Regression can effectively predict the presence of heart disease by constructing latent variables that maximize the covariance between clinical and demographic predictors and the presence of heart disease.

Technique:
Partial Least Squares (PLS) Regression was employed to identify latent variables that best capture the relationship between clinical and demographic predictors and the presence of heart disease.  PLS will be used to derive latent variables that summarize the predictors while maintaining their ability to predict the outcome variable effectively.
PLS regression was performed using the NIPALS algorithm, with leave-one-out cross-validation to determine the optimal number of latent variables. The cross-validation plot indicates that the first latent variable accounts for a significant portion of the variation, suggesting its strong predictive power. 
The cross-validation plot shows that the root mean PRESS decreases significantly with the first latent variable and stabilizes thereafter, indicating that one latent variable is sufficient for capturing most of the predictive power of the model. The r square value further supports the adequacy of using one latent variable for prediction. The plot shows a sharp decrease in the Root Mean PRESS with the inclusion of the first latent variable, suggesting that this component captures a significant portion of the predictive information. The T-square statistic also indicates that the first component is significantly different from zero, further supporting its importance in the model.
 
Figure 23: Cross-Validation Plot
The Variable Importance Plot identifies the most influential variables in the PLS model. Sex, maximum heart rate achieved, chest pain type, thal, exercise-induced angina, the number of major vessels coloured by fluoroscopy, ST depression induced by exercise are particularly noteworthy for their high importance scores. These variables are crucial in predicting the presence of heart disease, highlighting their relevance in clinical assessments.
 
Figure 24: Variable Importance Plot
The percent variation accounted for by the PLS factors shows that the first latent variable captures 23.69% of the model effects and 43.30% of the dependent variable variation, illustrating the effectiveness of PLS in capturing relevant information for predicting heart disease.
 


The PLS regression analysis shows that a single latent variable captures significant variation in predictors and the outcome, indicating PLS regression's effectiveness in predicting heart disease. 
The hypothesis that PLS Regression can predict heart disease by maximizing covariance between clinical and demographic predictors and heart disease presence is supported. The PLS model, with strong predictive power using a single latent variable, proves valuable for this analysis. Variable Importance Plot  identified predictors: Sex, maximum heart rate achieved, chest pain type, thalassemia, exercise-induced angina, number of major vessels coloured by fluoroscopy, and ST depression induced by exercise. These factors are crucial in predicting heart disease, emphasizing their importance in clinical assessments and decision-making processes.

6.	SUMMARY OF KEY FINDINGS
The application of multivariate techniques on the heart disease dataset yielded insightful results regarding the relationship between clinical and demographic predictors and heart disease presence.
Principal Component Analysis (Jolliffe, 2002) revealed the main dimensions within the dataset, showing that the first principal component captured significant variance related to clinical severity, while the second principal component highlighted general health indicators. This analysis showed that variables like maximum heart rate achieved, exercise-induced angina, age, and cholesterol are key factors in understanding heart disease risk.
Factor Analysis identified two significant latent factors: Factor 1, related to the clinical severity of heart disease, included high loadings on thalch and exang, while Factor 2, capturing general health, showed high loadings on age and cholesterol. These factors provide a structured understanding of how different clinical and demographic variables contribute to heart disease risk (Tabachnick & Fidell, 2013).
Discriminant Analysis successfully distinguished between patients with and without heart disease using a combination of clinical and demographic variables. Quadratic Discriminant Analysis demonstrated high accuracy, correctly classifying approximately 83% of patients. This technique highlighted the importance of considering a broad range of variables for effective heart disease classification (Hair et al., 2014).
Canonical Correlation Analysis (Hotelling, 1936) uncovered significant interactions between patient characteristics and clinical measurements, indicating that both sets of variables are crucial for understanding heart disease severity. The identified canonical variables emphasized the importance of variables such as chest pain type, age, resting blood pressure, and cholesterol in predicting heart disease.
Redundancy Analysis confirmed the findings from CCA, showing that the canonical variables derived from patient characteristics and symptoms explain a substantial amount of variance in clinical measurements and vice versa. This analysis underscored the predictive power of integrating demographic and clinical data for a comprehensive assessment of heart disease (Wold, 1985).
Partial Least Squares Regression demonstrated that a single latent variable could effectively predict the presence of heart disease, capturing a significant portion of the variation in both the predictors and the outcome variable. The Variable Importance Plot identified key predictors such as sex, maximum heart rate achieved, chest pain type, and ST depression induced by exercise, highlighting their relevance in clinical assessments (James et al., 2013).


7.	CONCLUSION
Despite the valuable insights gained, there are limitations to this study. The dataset size, while adequate, could be larger to improve the generalizability of the findings. Additionally, the dataset is limited to specific clinical and demographic variables, potentially excluding other relevant factors such as lifestyle and genetic data.
Future research should focus on expanding the dataset to include more diverse populations and additional variables. This could enhance the robustness of the predictive models and provide a more comprehensive understanding of heart disease. Moreover, exploring advanced predictive techniques, such as machine learning algorithms, could further improve the accuracy and utility of heart disease prediction models.
In conclusion, the study demonstrates that multivariate techniques, particularly those focused on dimensionality reduction and predictive modelling, are powerful tools in understanding and predicting heart disease. By leveraging these methods, healthcare professionals can gain deeper insights into the factors influencing heart disease and improve early detection and management strategies, ultimately enhancing patient outcomes.









