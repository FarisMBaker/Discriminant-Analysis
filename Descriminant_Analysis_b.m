close all;
clear;
clc;

%%% The input matrix e.g. the thermal data and can be the following:
%%%     A = Input Matrix for pictures 31 to 45 using moments methods
%%%     B = Input Matrix for pictures 16 to 60 using moments method
%%%     C = Input Matrix for pictures 31 to 45 using eigen values method
%%%     D = Input Matrix for pictures 16 to 60 using eigen values method
%%%     E = Input Matrix for pictures 31 to 45 using moments m4 to m9
%%%     F = Input Matrix for pictures 16 to 60 using moments m4 to m9
%%%     Y1 = Target Matrix for pictures 31 to 45
%%%     Y2 = Target Matrix for pictures 16 to 60

PathName = 'C:\AI Lab - Dell 1\Thermal Camera\TestingThermal\';

A = 'InMoments31to45.xlsx'; %%% Moments m1 to m11 data for pictures 31 to 45
B = 'InMoments16to60.xlsx'; %%% Moments m1 to m11 data for pictures 31 to 45
C = 'InEigen31to45';        %%% Eigen values 1 to 6 data for pictures 31 to 45
D = 'InEigen16to60';        %%% Eigen values 1 to 6 data for pictures 16 to 60
E = 'In31to45m4to9';        %%% Moments m4 to m9 (Uncorrelated) data for pictures 31 to 45 
F = 'In16to60m4to9';        %%% Moments m4 to m9 (Uncorrelated) data for pictures 16 to 60 

Y1 = 'Tar1Column31to45.xlsx';   %%% Target Matrix for pictures 31 to 45
Y2 = 'Tar1Column16to60.xlsx';   %%% Target Matrix for pictures 16 to 60

InputData = strcat(PathName,B);
TargetData = strcat(PathName,Y2);

X = xlsread(InputData); 
Y = xlsread(TargetData);



%%% partition the data into training & Targeting
cp = cvpartition(Y,'holdout',.20); 
X_TRAIN = X(training(cp,1),:);  %%% Training data
Y_TRAIN = Y(training(cp,1));    %%% Target data

%%% sample and training must be matrices with the same number of columns
%%% (featurs, variable, predictors)

idx = test(cp); %%% Index of the testing data
sample = X(test(cp),:); %%% The sample to be classified


%%% Train a Classifier using the Training Sets
%%% class is the group of each of each row of the sample belongs to
[class, error] = classify(sample,X_TRAIN,Y_TRAIN,'quadratic' );
display(error*100);



