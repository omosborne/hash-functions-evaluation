function hashedIndex = multiplicative(key, tableSize)

    goldenRatioR = (sqrt(5)-1)/2; % Reciprocal of the golden ratio.

    hashedKey = floor(tableSize * (goldenRatioR * key - floor(goldenRatioR * key)));

    hashedIndex = mod(hashedKey, tableSize) + 1;

end