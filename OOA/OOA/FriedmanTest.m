
function FriedmanTest
% the functions calculates the Friedman statistic and 
% mean rank values
% 
% input: 
% Update the input file name in the code 
% Example: 
% FreidmanTest 
% 
% 
% Output: 
% * Friedman stats value 
% * Mean ranks 
% 
% 
% Author: Srinivas Adithya Amanchi 
% Data: 12.02.2014 
% impoting the given data into a variable called RawData 
RawData = xlsread('p1.xlsx');
% n = NoOfRows 
% k = NoOfColumns
% load('friedman.xlsx');
% RawData=dh;
[n, k] = size(RawData); 
%% Finding Rank of the problems 
for i = 1:n 
    RankOfTheProblems(i,:) = tiedrank(RawData(i,:)); 
end
%% Taking average of the rank of the problems 
AvgOfRankOfProblems = mean(RankOfTheProblems); 
SquareOfTheAvgs = AvgOfRankOfProblems .* AvgOfRankOfProblems; 
SumOfTheSquares = sum(SquareOfTheAvgs); 
FfStats = (12*n/(k*(k+1))) * (SumOfTheSquares - ((k*(k+1)^2)/4)); 
%% Display the results 
formatSpec = 'Friedman statistic is %4.2f and \n '; 
fprintf(formatSpec,FfStats); 
disp('Average of the ranks obtained in all problems'); 
disp(AvgOfRankOfProblems)