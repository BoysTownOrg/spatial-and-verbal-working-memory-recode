function events = recode(events)
fixationLogicalIndices = diff([0; ismember(events(:, end), [20, 4116])]) == 1;
encodingOnsetLogicalIndices = diff([0; ismember(events(:, end), [23, 24, 4119, 4120])]) == 1;
maintenanceLogicalIndices = diff([0; ismember(events(:, end), [25, 4121])]) == 1;
retrievalOnsetLogicalIndices = diff([0; ismember(events(:, end), [33, 34, 4129, 4130])]) == 1;
encodingOnsetIndices = find(encodingOnsetLogicalIndices);
retrievalOnsetIndices = find(retrievalOnsetLogicalIndices);
for retrievalIndex = find(retrievalOnsetLogicalIndices).'
    responseIndex = retrievalIndex + 2;
    if responseIndex <= size(events, 1) && bitget(events(responseIndex, end), 8+1) && ismember(events(retrievalIndex, end), [33, 4129]) ...
            || responseIndex <= size(events, 1) && bitget(events(responseIndex, end), 9+1) && ismember(events(retrievalIndex, end), [34, 4130])
        events(encodingOnsetIndices + 1, end) = bitset(events(encodingOnsetLogicalIndices, end), 12 + 1);
        events(retrievalOnsetIndices + 1, end) = bitset(events(retrievalOnsetLogicalIndices, end), 12 + 1);
    else
        events(encodingOnsetIndices + 1, end) = bitset(events(encodingOnsetLogicalIndices, end), 12 + 1) + 4000;
        events(retrievalOnsetIndices + 1, end) = bitset(events(retrievalOnsetLogicalIndices, end), 12 + 1) + 4000;
    end
end
events(encodingOnsetLogicalIndices | retrievalOnsetLogicalIndices | fixationLogicalIndices, :) = [];
end