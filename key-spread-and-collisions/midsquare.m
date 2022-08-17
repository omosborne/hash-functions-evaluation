function hashedIndex = midsquare(key, tableSize)

    keySquared = key * key;

    keyString = num2str(keySquared);

    keyLength = numel(keyString);

    midpoint = int8(keyLength/2);

    key = keyString(midpoint-1:midpoint+1);

    hashedKey = str2double(key);

    hashedIndex = mod(hashedKey, tableSize) + 1;

end