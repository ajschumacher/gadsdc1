# -*- coding: utf-8 -*-
# <nbformat>3.0</nbformat>

# <codecell>

import pandas as pd
import numpy as np
from ggplot import *
from sklearn.ensemble import RandomForestClassifier
from sklearn.preprocessing import OneHotEncoder
from sklearn.preprocessing import Imputer
from sklearn.pipeline import Pipeline

# <markdowncell>

# Injury data previously downloaded from https://docs.google.com/spreadsheet/ccc?key=0ApDc5PGsBzgVdDBzT1JSV1FXRzF1MksxeVlYbXh4UlE&usp=drive_web#gid=1
# courtesy of Jeff Zimmerman http://www.baseballheatmaps.com/

# <markdowncell>

# Player performance data from www.fangraphs.com

# <codecell>

injuries2013 = pd.read_csv('DL2013.txt', sep='\t')
pitching2012 = pd.read_csv('Pitching2012.csv')
hitting2012 = pd.read_csv('Hitting2012.csv')
pitching2013 = pd.read_csv('All_Pitching_2013.csv')
hitting2013 = pd.read_csv('All_Batting_2013.csv')
hitting2011 = pd.read_csv('All_Batting_2011.csv')
pitching2011 = pd.read_csv('All_Pitching_2011.csv')

# <markdowncell>

# The injury data frame gets loaded as objects, but to join on them we'll needd equivalent data types, so we first convert the objects to numeric

# <codecell>

injuries2013.PlayerId = injuries2013.PlayerId.convert_objects(convert_dates = False, convert_numeric=True)
injuries2013['On Date'] = injuries2013['On Date'].convert_objects(convert_dates=True)

# <markdowncell>

# This is an ugly hack and I know you can do something better with pd.rename and a lambda, but hey, it works for now. but 
# it is used to create unique features for a player's performance over the past three years.

# <codecell>



for each_column in hitting2013.columns:
    if each_column == 'playerid':
        pass
    else:
        hitting2013 = hitting2013.rename(columns=
                           {each_column:'2013_b_'+each_column}
                           )
        
for each_column in hitting2012.columns:
    if each_column == 'playerid':
        pass
    else:
        hitting2012 = hitting2012.rename(columns=
                           {each_column:'2012_b_'+each_column}
                           )
        
for each_column in hitting2011.columns:
    if each_column == 'playerid':
        pass
    else:
        hitting2011 = hitting2011.rename(columns=
                           {each_column:'2011_b_'+each_column}
                           )
        
        
for each_column in pitching2011.columns:
    if each_column == 'playerid':
        pass
    else:
        pitching2011 = pitching2011.rename(columns=
                           {each_column:'2011_p_'+each_column}
                           )
        
for each_column in pitching2012.columns:
    if each_column == 'playerid':
        pass
    else:
        pitching2012 = pitching2012.rename(columns=
                           {each_column:'2012_p_'+each_column}
                           )
        
for each_column in pitching2013.columns:
    if each_column == 'playerid':
        pass
    else:
        pitching2013 = pitching2013.rename(columns=
                           {each_column:'2013_p_'+each_column}
                           )

# <markdowncell>

# The injury data needs a little renaming.

# <codecell>

injuries2013 = injuries2013.rename(columns = {'PlayerId':'playerid'})
injuries1 = injuries2013[['playerid', 'Days']]

# <markdowncell>

# Let's compile everything into a dataset now.

# <codecell>

data = pd.merge(hitting2013, hitting2012,
                how='outer',
                on='playerid')

# <codecell>

datasets=[hitting2011, pitching2013, pitching2012, pitching2011]

for each_set in datasets:
    data = pd.merge(data, each_set,
                    how='outer',
                    on = 'playerid',
                    )
    
    
data = pd.merge(data, injuries1,
                how = 'left',
                on = 'playerid')

# <markdowncell>

# and some  data cleaning--

# <codecell>

clean_me = list()
for each_column in data:
    if each_column.endswith("%"):
        clean_me.append(each_column)
    elif each_column.endswith("HR/FB"):
        clean_me.append(each_column)

delete_me = list()
for each_column in data:
    if each_column.endswith('"Name"'):
        delete_me.append(each_column)
    elif each_column.endswith('Team'):
        delete_me.append(each_column)

keep_cols = [col for col in data if col not in delete_me]
data = data[keep_cols]


#gets rid of the "%" which ends a lot of numeric values in these columns.
for each_column in clean_me:
    data[each_column] = data[each_column].apply(lambda x: (str(x)[0:-1]))

# <codecell>

# more_clean = []
# for each_col in data:
#     if each_col.endswith("Team"):
#         more_clean.append(each_col)
# team2013 = pd.concat([data['2013_b_Team'], data['2013_p_Team']])
# team2012 = pd.concat([data['2012_b_Team'], data['2012_p_Team']])
# team2011 = pd.concat([data['2011_b_Team'], data['2011_p_Team']])
# team2012[team2012 == '- - -'] = 'Multiple'
# team2013[team2013 == '- - -'] = 'Multiple'
# team2011[team2011 == '- - -'] = 'Multiple'

# data = pd.concat(data, team2013)
# # data = data.drop(['2012_b_Team'], 1)
# # data = data.drop(['2012_p_Team'], 1)
# # data = data.drop(['2013_p_Team'], 1)
# # data = data.drop(['2013_b_Team'], 1)
# # data = data.drop(['2011_p_Team'], 1)
# # data = data.drop(['2011_b_Team'], 1)

# <codecell>

#here's what i need to do right here: clean up the float columns 
#to get them either as a sparse matrix or at least to 
#nans that get recognized

# <markdowncell>

# We're going to be using a RFC at first, so I'm swtiching the 'days on disabled list' metric to a simple injured boolean.

# <codecell>

data.columns

# <codecell>

data['InjuredBool'] = data['Days']>=1

# <codecell>

injury_days_chart = ggplot(aes(x = 'playerid', y='Days'), data=data) + geom_point()
injury_days_chart

# <codecell>

X_cols = [col for col in data.columns if col not in ['InjuredBool', 'Days']]
X = data[X_cols]
y = data.InjuredBool

# <codecell>

objects = []
for each_col in X:
    if X[each_col].dtype =='object':
        objects.append(each_col)

keep_cols2 = [col for col in X if col not in objects]
X2= X[keep_cols2]

# <codecell>

X2.values
y.values

# <codecell>

pipe = Pipeline([('encoder', OneHotEncoder()), ('rfc', RandomForestClassifier())])
pipe2 = Pipeline([('imp', Imputer()), ('encoder', OneHotEncoder()), ('rfc', RandomForestClassifier())])
#USE IMPUTER as a first pass to fill in missing values on X2

# <codecell>

# pipe.fit_transform(X2, y)
# RFC = RandomForestClassifier()
RFC.fit(X2, y)

pipe2.fit_transform(X2, y)

# <codecell>

print X.dtypes
print X['2013_b_BB%'].values

# <codecell>


