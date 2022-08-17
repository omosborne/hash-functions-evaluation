function hashedKey = fibonacci(key)

    goldenRatioR = (sqrt(5)-1)/2; % Reciprocal of the golden ratio.

    hashedKey = int64(key * ((2^8) / goldenRatioR));

end