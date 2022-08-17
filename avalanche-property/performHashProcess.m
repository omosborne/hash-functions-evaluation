function [midMAD,mulMAD,fibMAD] = performHashProcess(keys)

    % Setup midsquare hash arrays.
    midHash = zeros(1,10);
    mulHash = zeros(1,10);
    fibHash = zeros(1,10);

    % Perform hashes for each key.
    for i=1:numel(keys)
        key = keys(i);
        midHash(i) = midsquare(key);
        mulHash(i) = multiplicative(key);
        fibHash(i) = fibonacci(key);
    end

    % Collect the distances for each hash and key offset.
    midDistances = getDistance(midHash);
    mulDistances = getDistance(mulHash);
    fibDistances = getDistance(fibHash);

    % Calculate the Mean Absolute Distance (MAD)
    midMAD = round(sum(midDistances) / numel(midDistances));
    mulMAD = round(sum(mulDistances) / numel(mulDistances));
    fibMAD = round(sum(fibDistances) / numel(fibDistances));

end