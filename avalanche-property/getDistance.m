function [distances] = getDistance(hashedValues)

    output = [numel(hashedValues)-1]; % Set size 1 less than hash values.

    for i=1:numel(hashedValues)

        % ignore if on last iteration as no next value to compare.
        if (i == numel(hashedValues))
            continue;
        end

        % Calculate absolute distance between two hashed values.
        output(i) = abs(hashedValues(i) - hashedValues(i+1));

    end

    distances = output;

end