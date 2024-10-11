/* Assign a libname to the directory for easier access */
libname mylib "\Multivariate Project";

ods graphics on;
/* Import the imputed data back to SAS */
proc import datafile='Z:\Downloads\Multivariate Project\heart_data_imputed.csv'
            out=mylib.heart_imputed
            dbms=csv
            replace;
    getnames=yes;
run;

/*____________________H1__________*/

/* Perform factor analysis on the imputed data */
proc factor data=mylib.heart_imputed 
    plots=scree 
    method=principal 
    priors=smc ;
    var age sex trestbps chol fbs thalch exang oldpeak ca CP Slope Thal RestECG;
    title 'Factor Analysis of Patient Data';
run;


ods graphics on;
ods select orthrotfactpat patternplot;
/* Perform factor analysis with Varimax rotation and retain 2 factors */
proc factor data=mylib.heart_imputed 
    plots=all 
    method=principal
    priors=smc n=2
    r=v
	flag=.3
	fuzz=.2;
    var age sex trestbps chol fbs thalch exang oldpeak ca CP Slope Thal RestECG;
    title 'Factor Analysis of Patient Data (Varimax Rotation) ';
run;


/*_________________H2____________________________*/


/* Create a binary variable for heart disease presence */
data mylib.heart_imputed;
    set mylib.heart_imputed;
    heart_disease = (num > 0);
run;


/* Stepwise Discriminant Analysis */
proc stepdisc data=mylib.heart_imputed method=stepwise;
    class heart_disease; /* Binary variable indicating heart disease presence */
    var age sex trestbps chol fbs thalch exang oldpeak ca CP Slope Thal RestECG;
    title 'Stepwise Discriminant Analysis for Heart Disease Presence';
run;

/* Stepwise Discriminant Analysis */
proc stepdisc data=mylib.heart_imputed method=stepwise;
    class heart_disease; /* Binary variable indicating heart disease presence */
    var age sex trestbps chol fbs thalch exang oldpeak ca CP Slope Thal RestECG;
    title 'Stepwise Discriminant Analysis for Heart Disease Presence';
run;


/* Print the results */
proc print data=mylib.stepdisc_results;
    title 'Stepwise Discriminant Analysis Results';
run;


/* Create a binary variable for heart disease presence */
data mylib.heart_imputed;
    set mylib.heart_imputed;
    heart_disease = (num > 0);
run;


/* Perform discriminant analysis */
proc discrim data=mylib.heart_imputed pool=test
	slpool=0.05;
    class heart_disease; /* Binary variable indicating heart disease presence */
    var age sex trestbps chol fbs thalch exang oldpeak ca CP Slope Thal RestECG;
    title 'Discriminant Analysis of Heart Disease Presence';
run;


/* Perform Linear discriminant analysis */
proc discrim data=mylib.heart_imputed pool=yes crossvalidate;
    class heart_disease; /* Binary variable indicating heart disease presence */
    var age sex trestbps chol fbs thalch exang oldpeak ca CP Slope Thal RestECG;
    title 'Discriminant Analysis of Heart Disease Presence';
run;



/*_______________H3_______________________*/


ods graphics on;
/* Perform Canonical Correlation Analysis */
proc cancorr data=mylib.heart_imputed out=canonical_corr_results 
    vprefix=Char wprefix=Clin ncan=4
    vname='Patient Characteristics and Symptoms' wname='Clinical Measurements';
    var CP fbs exang Slope Thal sex age; /* Patient Characteristics and Symptoms */
    with trestbps chol thalch oldpeak ca RestECG; /* Clinical Measurements */
    title 'Canonical Correlation Analysis between Patient Characteristics and Clinical Measurements';
run;


ods graphics on;
/* Perform Canonical Correlation Analysis */
proc cancorr data=mylib.heart_imputed out=canonical_corr_results red
    vprefix=Char wprefix=Clin ncan=4
    vname='Patient Characteristics and Symptoms' wname='Clinical Measurements';
    var CP fbs exang Slope Thal sex age; /* Patient Characteristics and Symptoms */
    with trestbps chol thalch oldpeak ca RestECG; /* Clinical Measurements */
    title 'Canonical Correlation Analysis between Patient Characteristics and Clinical Measurements';
run;


/*________________H4__________________*/

/* Perform Redundancy Analysis */
proc cancorr data=mylib.heart_imputed out=outcan;
    var age sex chol trestbps;
    with num;
    title 'Redundancy Analysis of Heart Disease Variability';
run;

/* Assess Redundancy Analysis Output */
proc print data=outcan;
    title 'Redundancy Analysis Output';
run;


/* Perform Redundancy Analysis */
proc cancorr data=mylib.heart_imputed out=outcan 
    vprefix=Life wprefix=Clin
    vname= 'Lifestyle Factors' wname='Clinical Measurements';
    var cp fbs exang slope thal;
    with age sex trestbps chol thalch oldpeak ca restecg;
    title 'Redundancy Analysis between Lifestyle Factors and Clinical Measurements';
run;





/*___________________H5_________________*/

/* Create a binary variable for heart disease presence */
data mylib.heart_imputed;
    set mylib.heart_imputed;
    heart_disease = (num > 0);
run;

/* Logistic Regression with Original Variables */
proc logistic data=mylib.heart_imputed;
    class heart_disease (param=ref ref='0');
    model heart_disease(event='1') = age sex trestbps chol fbs thalch exang oldpeak ca CP Slope Thal RestECG;
    output out=baseline_pred p=prob_baseline;
run;

/* Evaluate Model Performance for Original Variables */
proc logistic data=baseline_pred;
    model heart_disease(event='1') = prob_baseline;
    roc 'Baseline Model' prob_baseline;
    ods select ROCOverlay;
run;

/* Perform Principal Component Analysis */
proc princomp data=mylib.heart_imputed out=pca_results n=3;
    var age sex trestbps chol fbs thalch exang oldpeak ca CP Slope Thal RestECG;
run;

/* Logistic Regression with Principal Components */
proc logistic data=pca_results;
    class heart_disease (param=ref ref='0');
    model heart_disease(event='1') = prin1 prin2 prin3;
    output out=pca_pred p=prob_pca;
run;

/* Evaluate Model Performance for Principal Components */
proc logistic data=pca_pred;
    model heart_disease(event='1') = prob_pca;
    roc 'PCA Model' prob_pca;
    ods select ROCOverlay;
run;


/*___H6___________________________*/

/* Step 1: Data Preparation */
data mylib.heart_pls;
    set mylib.heart_imputed;
    heart_disease = (num > 0); /* Create binary variable for heart disease presence */
run;

ODS graphics on;

/* Step 2: PLS Regression with Cross-Validation and Additional Plots */
proc pls data=mylib.heart_pls method=pls(algorithm=nipals)
    cv=one cvtest(seed=608789001)
    plot=(vip xyscores xscores parmprofiles dmod xloadingplot xloadingprofiles xweightplot xweightprofiles xyscores yweightplot);
    model heart_disease = age sex trestbps chol fbs thalch exang oldpeak ca CP Slope Thal RestECG;
    output out=pls_out pred=pred_pls;
    title 'PLS Regression for Predicting Heart Disease Presence';

ODS graphics off;
