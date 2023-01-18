function events = recode(events)
fixationLogicalIndices = diff([0; ismember(events(:, end), [20, 4116])]) == 1;
encodingOnsetLogicalIndices = diff([0; ismember(events(:, end), [23, 24, 4119, 4120])]) == 1;
maintenanceLogicalIndices = diff([0; ismember(events(:, end), [25, 4121])]) == 1;
retrievalOnsetLogicalIndices = diff([0; ismember(events(:, end), [33, 34, 4129, 4130])]) == 1;
encodingOnsetIndices = find(encodingOnsetLogicalIndices);
events(encodingOnsetIndices + 1, end) = bitset(events(encodingOnsetLogicalIndices, end), 12 + 1);
retrievalOnsetIndices = find(retrievalOnsetLogicalIndices);
events(retrievalOnsetIndices + 1, end) = bitset(events(retrievalOnsetLogicalIndices, end), 12 + 1);
events(encodingOnsetLogicalIndices | retrievalOnsetLogicalIndices | fixationLogicalIndices, :) = [];
end