function hashedKey = multiplicative(key)

    goldenRatioR = (sqrt(5)-1)/2; % Reciprocal of the golden ratio.
    tableSize = 128;

    hashedKey = floor(tableSize * (goldenRatioR * key - floor(goldenRatioR * key)));

end