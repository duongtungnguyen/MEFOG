# MEFOG
Market Equilibrium Multi-resource Allocation

1) Sample simulation data: "dataTON_v1.m"

2) You can generate new datasets by using 
- "dataCapacity.m": generate the set of  FNs, each of which corresponds to an Amazon EC2 instance (or a set of instances).
- "generateBaseDemandVector.m": generate basedemand vectors of the services/buyers.
(data in "dataTON_v1" is created using these two files).

3) Using "plot_xx..." files to plot figures in the paper. You can change the dataset to obtain results in new settings.
4) " capLinearLeontief.m" is the centralized solution.
5) "admmcapLinearLeontief.m" is the ADMM implementation.
....
