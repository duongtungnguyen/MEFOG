"# MEFOG" 
Market Equilibrium Multi-resource Allocation

Sample simulation data: "dataTON_v1.m"

You can generate new datasets by using

1) "dataCapacity.m": to generate the set of FNs, each of which corresponds to an Amazon EC2 instance (or a set of instances).

2) "generateBaseDemandVector.m": to generate basedemand vectors of the services/buyers. (data in "dataTON_v1" was created using these two files).

3) Using "plot_xx..." files to plot figures in the paper. You can change the dataset to obtain results in new settings.

4) " capLinearLeontief.m" is for the centralized solution.

5) "admmcapLinearLeontief.m" is the ADMM implementation. 


...

If you have any questions, please contact me at duong dot vn228 at gmail . com