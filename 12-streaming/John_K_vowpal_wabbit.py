import pandas as pd
sal_data = pd.read_csv("/Users/johnkabler/gadsdata/salary/train.csv")

# ###Vowpal Wabbit Input Format
#
#     1 1.0 |MetricFeatures:3.28 height:1.5 length:2.0 |Says black with white stripes |OtherFeatures NumberOfLegs:4.0 HasStripes
#
#
#     1 1.0 zebra|MetricFeatures:3.28 height:1.5 length:2.0 |Says black with white stripes |OtherFeatures NumberOfLegs:4.0 HasStripes
#     1 2 'tag| a:2 b:3
#     1 2 'tag | a:2 b:3

sal_dict = sal_data.T.to_dict()
# 25000 |Category Engineering Jobs |Company Gregory Martin |ContractTime permanent |Id:1266677 '\n'
for row in sal_dict:
    sal_norm = str(sal_dict[row].pop('SalaryNormalized'))
    sal_row = ""
    for key in sal_dict[row].keys():
        sal_row += sal_norm
        sal_row += " "
        try:
            sal_row += "|" + key + " " + sal_dict[row][key] + " "
        except:
            sal_row += "|" + key + ":" + str(sal_dict[row][key]) + " "
    print(sal_row + '\n')
