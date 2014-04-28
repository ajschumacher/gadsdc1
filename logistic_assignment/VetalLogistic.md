
PREMISE: I have chosen to work with the All State Challenge data as it is part
of my final project.  The final project will attempt to predict all of the
options a person might choose based upon their history and features.  For this
project I will simply try to use logistic regression to predict if an individual
customer chooses a 1 or a 0 for their car insurance option B.  There are several
options but I'm focusing on one of them.


    Loading Libraries below.


    import numpy as np
    import pandas as pd
    from sklearn import linear_model, datasets
    from sklearn.cross_validation import KFold
    import matplotlib.pyplot as plt
    from patsy import dmatrix, dmatrices


    from sklearn.cross_validation import KFold


    %pylab inline

    Populating the interactive namespace from numpy and matplotlib


Loading the datasets:


    train = pd.read_csv('train.csv')
    testset = pd.read_csv('test_v2.csv')


    train = train[train.record_type == 1]

Student has selected a dataset suitable for the assignment (20pts)

The dataset must be large enough to require training a model, but must not be
too large to reproduce its analysis on a single laptop.

ANSWER: This dataset has 665K rows; 97K of which are useable.  It s clearly
large enough to require a tool.


    len(train)




    97009



It must have at least five independent features.
The dataset must be appropriate for a binary classification problem.

ANSWER: This dataset has 24 features.

The student has explained why he/she has chosen this dataset, and problem.

ANSWER: For this particualr dataset I am choosing to see if I can predict if
there are any features that can predict if a customer finally chooses option 1
or 2 for feature B.

Student has run a logistic regression on the dataset (50pts)

COMMENT: Before I start building a logistic regression I want to do some basic
discovery activity to see if I can visualize if any of the feature actually have
an impact on Feature B.

EXPLANATION: As shown below, I want to first see if the dataset is skewed
towards having a lot of B=1 versus B=0.  As shown, the dataset seems to be
nicely dispersed between B=1 and B=0.


    len(train[train.B == 0])




    50824




    len(train[train.B == 1])




    46185



So a few things things I want to check are listed below

Do any of the other purchase factors of a customer have an effect on whether or
not the final purchase for B is a 1 or 0
Does the Risk Factor of a customer have an effect on whether or not the final
purchase for B is a 1 or 0
Does the Car Value of a customer have an effect on whether or not the final
purchase for B is a 1 or 0

I know that sci kit learn can only take numeric values.  So I first want to make
sure that risk_factor is all numbers.After checking the unique values for
risk_factor (as shown below) I have found that there are some 'nan' values.
Starting with risk_factor:


    train.risk_factor.unique()




    array([  3.,   4.,  nan,   2.,   1.])



In this case I decide to simply impute the nan values as 5.  See below.


    train['risk_factor'] = train['risk_factor'].fillna(5)


    Now the unique values are all numbers. See below.


    train.risk_factor.unique()




    array([ 3.,  4.,  5.,  2.,  1.])



In order to check the viability if risk_factor impacts the choice for B I set up
a for loop that calculates an array of values that are the percentage of times a
person chooses B under different risk_values.


    risk_value_set = train.risk_factor.unique()
    risk_value_set.sort()
    risk_value_set




    array([ 1.,  2.,  3.,  4.,  5.])




    BMeansRiskFactor = []
    for i in range(len(risk_value_set)):     
        BMeansRiskFactor.append(train.B[train.
                                     risk_factor == risk_value_set[i]].mean())


    plot(BMeansRiskFactor)




    [<matplotlib.lines.Line2D at 0x1124c2090>]




![png](VetalLogistic_files/VetalLogistic_26_1.png)


Based upon the chart above it seems that risk factor does have some impact on
what a person chooses for option B on their car insurance.  The issue is that
when risk factor is 4 (3.0 on the chart), there seems to be a significant jump
in the chance that a person chooses B=1.


    sample_train_capture = train.ix[sample_train]
    sample_train_capture.head()




<div style="max-height:1000px;max-width:1500px;overflow:auto;">
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>customer_ID</th>
      <th>shopping_pt</th>
      <th>record_type</th>
      <th>day</th>
      <th>time</th>
      <th>state</th>
      <th>location</th>
      <th>group_size</th>
      <th>homeowner</th>
      <th>car_age</th>
      <th>car_value</th>
      <th>risk_factor</th>
      <th>age_oldest</th>
      <th>age_youngest</th>
      <th>married_couple</th>
      <th>C_previous</th>
      <th>duration_previous</th>
      <th>A</th>
      <th>B</th>
      <th>C</th>
      <th></th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>260902</th>
      <td> 10060210</td>
      <td> 10</td>
      <td> 1</td>
      <td> 2</td>
      <td> 14:46</td>
      <td> GA</td>
      <td> 13480</td>
      <td> 2</td>
      <td> 1</td>
      <td>  2</td>
      <td> e</td>
      <td> 4</td>
      <td> 72</td>
      <td> 21</td>
      <td> 0</td>
      <td> 3</td>
      <td> 1</td>
      <td> 1</td>
      <td> 1</td>
      <td> 3</td>
      <td>...</td>
    </tr>
    <tr>
      <th>78124 </th>
      <td> 10018122</td>
      <td>  8</td>
      <td> 1</td>
      <td> 2</td>
      <td> 12:47</td>
      <td> FL</td>
      <td> 15056</td>
      <td> 1</td>
      <td> 0</td>
      <td>  9</td>
      <td> f</td>
      <td> 1</td>
      <td> 32</td>
      <td> 32</td>
      <td> 0</td>
      <td> 3</td>
      <td> 3</td>
      <td> 2</td>
      <td> 1</td>
      <td> 3</td>
      <td>...</td>
    </tr>
    <tr>
      <th>619859</th>
      <td> 10142516</td>
      <td>  9</td>
      <td> 1</td>
      <td> 3</td>
      <td> 17:37</td>
      <td> WI</td>
      <td> 12144</td>
      <td> 1</td>
      <td> 0</td>
      <td> 14</td>
      <td> f</td>
      <td> 4</td>
      <td> 23</td>
      <td> 23</td>
      <td> 0</td>
      <td> 3</td>
      <td> 2</td>
      <td> 0</td>
      <td> 0</td>
      <td> 3</td>
      <td>...</td>
    </tr>
    <tr>
      <th>115687</th>
      <td> 10026878</td>
      <td>  6</td>
      <td> 1</td>
      <td> 1</td>
      <td> 10:49</td>
      <td> CO</td>
      <td> 14912</td>
      <td> 1</td>
      <td> 0</td>
      <td> 18</td>
      <td> e</td>
      <td> 5</td>
      <td> 22</td>
      <td> 22</td>
      <td> 0</td>
      <td> 3</td>
      <td> 1</td>
      <td> 0</td>
      <td> 0</td>
      <td> 1</td>
      <td>...</td>
    </tr>
    <tr>
      <th>84942 </th>
      <td> 10019711</td>
      <td>  7</td>
      <td> 1</td>
      <td> 2</td>
      <td> 15:07</td>
      <td> AL</td>
      <td> 15168</td>
      <td> 1</td>
      <td> 0</td>
      <td> 14</td>
      <td> e</td>
      <td> 3</td>
      <td> 23</td>
      <td> 23</td>
      <td> 0</td>
      <td> 2</td>
      <td> 6</td>
      <td> 0</td>
      <td> 0</td>
      <td> 2</td>
      <td>...</td>
    </tr>
  </tbody>
</table>
<p>5 rows × 25 columns</p>
</div>




    car_value_set = train.car_value.unique()
    car_value_set.sort()
    car_value_set




    array(['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i'], dtype=object)




    train.car_value.value_counts()




    e    32161
    f    25943
    d    16402
    g    14387
    h     4158
    c     3072
    i      502
    b      210
    a      174
    dtype: int64



After looking at the unique values for 'CAR VALUE' I find that there are some
'nan'.  This is a problem because I will need a value for all of my rows.  To
take care of this I'm going to have to impute some values for the 'nan'.


    train['car_value'] = train['car_value'].fillna('j')


    testset['car_value'] = testset['car_value'].fillna('j')

Above you will see that most of the values are in either e or f.  I'm going to
make the somewhat brash decision to impute the 'nan' values to a random letter
based upon the percentage the the letter shows up. See below.


    car_value_set = train.car_value.unique()
    car_value_set.sort()
    car_value_set




    array(['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i'], dtype=object)




    BMeansCarValue = []
    for i in range(len(car_value_set)):     
        BMeansCarValue.append(train.B[train.
                                     car_value == car_value_set[i]].mean())


    plot(BMeansCarValue)




    [<matplotlib.lines.Line2D at 0x10073dad0>]




![png](VetalLogistic_files/VetalLogistic_37_1.png)


Now that I have done some basic discovery on the data I want to setup a
dataframe that includes only the features that I believe are of consequence.  In
thie case the columns of {COL}, {COL}, and {COL}

Sci Kit Learn Logistic regression only takes in numbers for its values.  Whereas
R will automatically create dummy variables, sci kit learn will not do that, to
the best of my knowledge.  Below is the code I used to create all of my dummy
variables.

I also want to see if the other purchase options might be a good predictor for
my option B.  Below is a bunch of repeated code I used to determine the effect
each of the factors might have on my response.


    OptASet = train.A.unique()
    OptASet.sort()
    OptASet




    array([0, 1, 2])




    BMeansOptA = []
    for i in range(len(OptASet)):     
        BMeansOptA.append(train.B[train.
                                     A == OptASet[i]].mean())


    plot(BMeansOptA)




    [<matplotlib.lines.Line2D at 0x10b3c2c50>]




![png](VetalLogistic_files/VetalLogistic_43_1.png)



    OptCSet = train.C.unique()
    OptCSet.sort()
    OptCSet




    array([1, 2, 3, 4])




    BMeansOptC = []
    for i in range(len(OptCSet)):     
        BMeansOptC.append(train.B[train.
                                     C == OptCSet[i]].mean())


    plot(BMeansOptC)




    [<matplotlib.lines.Line2D at 0x109bde090>]




![png](VetalLogistic_files/VetalLogistic_46_1.png)



    OptDSet = train.D.unique()
    OptDSet.sort()
    OptDSet




    array([1, 2, 3])




    BMeansOptD = []
    for i in range(len(OptDSet)):     
        BMeansOptD.append(train.B[train.
                                     D == OptDSet[i]].mean())


    plot(BMeansOptD)




    [<matplotlib.lines.Line2D at 0x10072d550>]




![png](VetalLogistic_files/VetalLogistic_49_1.png)



    OptESet = train.E.unique()
    OptESet.sort()
    OptESet




    array([0, 1])




    BMeansOptE = []
    for i in range(len(OptESet)):     
        BMeansOptE.append(train.B[train.
                                     E == OptESet[i]].mean())


    plot(BMeansOptE)




    [<matplotlib.lines.Line2D at 0x109bfd710>]




![png](VetalLogistic_files/VetalLogistic_52_1.png)



    OptFSet = train.F.unique()
    OptFSet.sort()
    OptFSet




    array([0, 1, 2, 3])




    BMeansOptF = []
    for i in range(len(OptFSet)):     
        BMeansOptF.append(train.B[train.
                                     F == OptFSet[i]].mean())


    plot(BMeansOptF)




    [<matplotlib.lines.Line2D at 0x10a280850>]




![png](VetalLogistic_files/VetalLogistic_55_1.png)


One thing I started to think about was the fact that I could not possible assume
chosing a 1 over a 2 was a closer option than choosing a 1 over a 3 in any of
the categories.  What I really care about is the range of impact the feature has
on my B feature. Below is the range of B% for each option

These are all eyeball guesstimates:
A: 0.53 - 0.3 == 0.33
C: 0.51 - 0.42 == 0.09
D: 0.5 - 0.38 == 0.12
E: 0.69 - 0.29 == 0.4
F: 0.55 - 0.36 == 0.19

It looks like features A and E are my best bets.

***PREP DATA FOR LOGISTIC REGRESSION***

I know that sci kit learn only accepts numbers. I also know the numbers provided
for the A through F features are categories and are not meant to represent real
numbers.  So I will treat those as categories.  Below I am creating new columns
for my features.  I am going to use the car value, and options A and E as my
predictors. Yes I know it is quick and dirty and there is a more elegant way to
do this so I don't have to keep changing the values of the getbool function.  I
ran out of time.


    def getbool(row):
        if row['E'] == 1:
            return 1
        else:
            return 0



    train['cv_A'] = train.apply(getbool , axis = 1)       
    testset['cv_A'] = train.apply(getbool , axis = 1)       


    train['cv_B'] = train.apply(getbool , axis = 1)   
    testset['cv_B'] = train.apply(getbool , axis = 1)   


    train['cv_C'] = train.apply(getbool , axis = 1)  
    testset['cv_C'] = train.apply(getbool , axis = 1)   


    train['cv_D'] = train.apply(getbool , axis = 1)   
    testset['cv_D'] = train.apply(getbool , axis = 1)   


    train['cv_E'] = train.apply(getbool , axis = 1)   
    testset['cv_E'] = train.apply(getbool , axis = 1)   


    train['cv_F'] = train.apply(getbool , axis = 1)   
    testset['cv_F'] = train.apply(getbool , axis = 1)   


    train['cv_G'] = train.apply(getbool , axis = 1)   
    testset['cv_G'] = train.apply(getbool , axis = 1)   


    train['cv_H'] = train.apply(getbool , axis = 1)   
    testset['cv_H'] = train.apply(getbool , axis = 1)   


    train['cv_I'] = train.apply(getbool , axis = 1)   
    testset['cv_I'] = train.apply(getbool , axis = 1)   


    train['cv_J'] = train.apply(getbool , axis = 1)  
    testset['cv_J'] = train.apply(getbool , axis = 1)   


    train['A0'] = train.apply(getbool, axis = 1)
    testset['A0'] = train.apply(getbool, axis = 1)


    train['A1'] = train.apply(getbool, axis = 1)
    testset['A1'] = train.apply(getbool, axis = 1)


    train['A2'] = train.apply(getbool, axis = 1)
    testset['A2'] = train.apply(getbool, axis = 1)


    train['E0'] = train.apply(getbool, axis = 1)
    testset['E0'] = train.apply(getbool, axis = 1)


    train['E1'] = train.apply(getbool, axis = 1)
    testset['E1'] = train.apply(getbool, axis = 1)

I will now create a fitted logistic regression model based uppn the features I
care about resulting from my discovery activities.

The output includes coefficient values


    regr = linear_model.LogisticRegression(C=1e5)


    dataset = train[['cv_A','cv_B','cv_C','cv_D','cv_E','cv_F','cv_G','cv_H','cv_I','cv_J','A0','A1','A2','E0','E1']].copy()


    tester = train[['cv_A','cv_B','cv_C','cv_D','cv_E','cv_F','cv_G','cv_H','cv_I','cv_J','A0','A1','A2','E0','E1']].copy()


    response = train.B


    regr.fit(dataset, response)




    LogisticRegression(C=100000.0, class_weight=None, dual=False,
              fit_intercept=True, intercept_scaling=1, penalty='l2',
              random_state=None, tol=0.0001)




    regr.coef_




    array([[-0.17309089, -0.17309089, -0.17309089, -0.03069424, -0.01818288,
            -0.05711328, -0.04068807, -0.05511636, -0.2338521 ,  0.        ,
            -0.01887235,  0.04069065, -0.03502563, -0.84604407,  0.83283674]])




    result = regr.predict(tester)


    result




    array([1, 0, 0, ..., 1, 1, 0])




    X = dataset


    Y = response


    k_fold = KFold(n=len(X), n_folds=3, indices=False)


    scores = []
    
    for dataset, tester in k_fold:
        train_text = X[dataset]
        train_y = Y[dataset]
        test_text = X[tester]
        test_y = Y[tester]
        regr.fit(train_text, train_y)
        score = regr.score(test_text, test_y)
        scores.append(score)
    
    score = sum(scores) / len(scores)
    print(score)

    0.70068754248



    scores




    [0.70287905495253111, 0.69875680356259273, 0.70042676892627409]



CONCLUSION: It looks like I'm averaging about 70% accuracy across my 3 folds.
Not too shabby.  I'm sure I could have done better if I had more time on my
hands to work on this.


    from sklearn.metrics import roc_curve, auc


    # Compute ROC curve and area the curve
    fpr, tpr, thresholds = roc_curve(tester, probas_[:, 1])
    roc_auc = auc(fpr, tpr)
    print("Area under the ROC curve : %f" % roc_auc)


    ---------------------------------------------------------------------------
    NameError                                 Traceback (most recent call last)

    <ipython-input-197-afa21faf56d3> in <module>()
          1 # Compute ROC curve and area the curve
    ----> 2 fpr, tpr, thresholds = roc_curve(tester, probas_[:, 1])
          3 roc_auc = auc(fpr, tpr)
          4 print("Area under the ROC curve : %f" % roc_auc)


    NameError: name 'probas_' is not defined



    
