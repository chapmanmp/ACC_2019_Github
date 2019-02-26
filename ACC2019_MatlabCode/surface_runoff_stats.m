% Provides statistics for surface runoff due to design storm
% Authors: Victoria Cheng, Kevin Smith
% September 10, 2018

% Sample mean and moments
Mymean = 12.16;
Myvariance = 3.22;
Myskewness = 1.68;
Mykurtosis = 8.31;

%range of 
ws = Mymean-2*sqrt(Myvariance):0.5*sqrt(Myvariance):Mymean+2.5*sqrt(Myvariance); %ft^3/s, possible values of wk