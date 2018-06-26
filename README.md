"# MEFOG" 
Market Equilibrium Multi-resource Allocation

Sample simulation data: "dataTON_v1.m"

You can generate new datasets by using

"dataCapacity.m": generate the set of FNs, each of which corresponds to an Amazon EC2 instance (or a set of instances).
"generateBaseDemandVector.m": generate basedemand vectors of the services/buyers. (data in "dataTON_v1" is created using these two files).
Using "plot_xx..." files to plot figures in the paper. You can change the dataset to obtain results in new settings.
" capLinearLeontief.m" is the centralized solution.
"admmcapLinearLeontief.m" is the ADMM implementation. ....