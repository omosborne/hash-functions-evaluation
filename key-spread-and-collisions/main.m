clear all;
close all;
clc;

% Customise these variables for testing.
keyMode        	= "SEQUENTIAL"; % SEQUENTIAL, RANDOM
offset          = 3; % 1, 2, 3
tableSize     	= 128; % 128, 256
loadFactor    	= 0.25; % 0.1, 0.25, 0.5
baseKey     	= 1000;

totalKeys    	= int16(tableSize.*loadFactor);
keys         	= zeros(1,totalKeys);
midHashTable	= zeros(1,tableSize);
mulHashTable 	= zeros(1,tableSize);
fibHashTable   	= zeros(1,tableSize);

% Apply squential mode related variables.
if (keyMode == "SEQUENTIAL")
    % Set graph titles for sequential keys with offset.
    midTitle = sprintf('Midsquare Hash\nTable Size: %d, Load: %d%%\n Sequential keys offset by %d', tableSize, loadFactor*100, offset);
    mulTitle = sprintf('Multiplicative Hash\nTable Size: %d, Load: %d%%\n Sequential keys offset by %d', tableSize, loadFactor*100, offset);
    fibTitle = sprintf('Fibonacci Hash\nTable Size: %d, Load: %d%%\n Sequential keys offset by %d', tableSize, loadFactor*100, offset);
    
    % Allocate keys sequantially.
    keys(1) = baseKey;
    for i = 2:totalKeys
        keys(i) = baseKey + ((i-1) * offset);
    end
    
% Apply random mode related variables.
elseif (keyMode == "RANDOM")
    % Set graph titles for random keys.
    midTitle = sprintf('Midsquare Hash\nTable Size: %d, Load: %d%%\n Random keys', tableSize, loadFactor*100);
    mulTitle = sprintf('Multiplicative Hash\nTable Size: %d, Load: %d%%\n Random keys', tableSize, loadFactor*100);
    fibTitle = sprintf('Fibonacci Hash\nTable Size: %d, Load: %d%%\n Random keys', tableSize, loadFactor*100);
    
    % Allocate keys randomly.
    for i = 1:totalKeys
        keys(i) = randi([baseKey,10000]);
    end
end

% Perform hashing process for each key and count table position.
for i = 1:totalKeys
    key = keys(i);

    midIndex = midsquare(key, tableSize);
    mulIndex = multiplicative(key, tableSize);
    fibIndex = fibonacci(key, tableSize);
   
    midHashTable(midIndex) = midHashTable(midIndex) + 1;  
    mulHashTable(mulIndex) = mulHashTable(mulIndex) + 1;  
    fibHashTable(fibIndex) = fibHashTable(fibIndex) + 1;  
end

% Count the number of elements in the table.
midElements = numel(midHashTable(midHashTable>0));
mulElements = numel(mulHashTable(mulHashTable>0));
fibElements = numel(fibHashTable(fibHashTable>0));

% Count the number of repeated landings where an element already existed.
midCollisions = sum(midHashTable(midHashTable>1))-sum(midHashTable>1);
mulCollisions = sum(mulHashTable(mulHashTable>1))-sum(mulHashTable>1);
fibCollisions = sum(fibHashTable(fibHashTable>1))-sum(fibHashTable>1);

% Calculate the standard deviation for distribution.
midStanDev  = std(midHashTable);
multStanDev = std(mulHashTable);
fibStanDev  = std(fibHashTable);

% Perform Chi-Squared Goodness-of-fit test using the formula: (observered-expected)^2/expected
midChiTest  = (midElements-totalKeys)^2 / totalKeys;
multChiTest = (mulElements-totalKeys)^2 / totalKeys;
fibChiTest  = (fibElements-totalKeys)^2 / totalKeys;

% Display the results of the calculations.
landed   = [midElements;mulElements;fibElements];
collided = [midCollisions;mulCollisions;fibCollisions];
stanDevs = [midStanDev;multStanDev;fibStanDev];
chiTests = [midChiTest;multChiTest;fibChiTest];
disp(table(landed,collided,stanDevs,chiTests,'VariableNames',{'Landed','Collided','Standard Deviation','Chi Tests'},'RowName',{'Midsquare','Multiplicative','Fibonacci'}));

% Using CData on lines 91, 105, and 119 for changing bar colours based on values inspired from:
% https://uk.mathworks.com/matlabcentral/answers/372647-change-bar-color-based-on-value#answer_296066

% ===== Midsquare Results Graph =====
figure;
midBar = bar(midHashTable, 'FaceColor', 'g');
midBar.FaceColor = 'flat';
midBar.CData(midHashTable>1,:) = repmat([1 0 0],sum(midHashTable>1),1); % Turn collisions red.
xlabel('Hash Table Elements');
ylabel('Element Chosen Count');
title(midTitle);
axis square;
xlim([1 tableSize]);
ylim([0 max(midHashTable)]);

print('-dpng', 'midsquareGraph.png');

% ===== Multiplicative Results Graph =====
figure;
multBar = bar(mulHashTable, 'FaceColor', 'g');
multBar.FaceColor = 'flat';
multBar.CData(mulHashTable>1,:) = repmat([1 0 0],sum(mulHashTable>1),1); % Turn collisions red.
xlabel('Hash Table Elements');
ylabel('Element Chosen Count');
title(mulTitle);
axis square;
xlim([1 tableSize]);
ylim([0 max(mulHashTable)]);

print('-dpng', 'multiplicativeGraph.png');

% ===== Fibonacci Results Graph =====
figure;
fibBar = bar(fibHashTable, 'FaceColor', 'g');
fibBar.FaceColor = 'flat';
fibBar.CData(fibHashTable>1,:) = repmat([1 0 0],sum(fibHashTable>1),1); % Turn collisions red.
xlabel('Hash Table Elements');
ylabel('Element Chosen Count');
title(fibTitle);
axis square;
xlim([1 tableSize]);
ylim([0 max(fibHashTable)]);

print('-dpng', 'fibonacciGraph.png');