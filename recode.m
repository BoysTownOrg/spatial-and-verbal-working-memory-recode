function events = recode(events)
events([Inf; diff(events(:, 1))] <= 1024 ...
    & [1; diff(events(:, end))] == 0 ...
    & events(:, end) < bitset(0, BitTrigger.visual), :) = [];
fixationLogicalIndices = firstOfGroupLogicalIndices(events, [20, bitset(20, BitTrigger.visual)]);
encodingOnsetLogicalIndices = findOnsetLogicalIndices(events, [23, 24, bitset(24, BitTrigger.visual), bitset(23, BitTrigger.visual)]);
maintenanceLogicalIndices = firstOfGroupLogicalIndices(events, bitset(25, BitTrigger.visual));
retrievalOnsetLogicalIndices = findOnsetLogicalIndices(events, [33, 34, bitset(33, BitTrigger.visual), bitset(34, BitTrigger.visual)]);
encodingOnsetIndices = find(encodingOnsetLogicalIndices);
retrievalOnsetIndices = find(retrievalOnsetLogicalIndices);
assert(numel(encodingOnsetIndices) == numel(retrievalOnsetIndices), ...
    "The number of encoding onset triggers does not match the number of retrieval onset triggers.");
contributedByButton = logical(bitget(events(:, end), 8+1)) | logical(bitget(events(:, end), 9+1));
encodingVisualLogicalIndices = false([size(events, 1), 1]);
for i = 1:numel(retrievalOnsetIndices)
    if i == numel(retrievalOnsetIndices)
        lastCandidateResponseIndex = size(events, 1);
    else
        lastCandidateResponseIndex = encodingOnsetIndices(i+1) - 1;
    end
    retrievalIndex = retrievalOnsetIndices(i);
    responseIndex = find(contributedByButton(retrievalIndex+1:lastCandidateResponseIndex), 1) + retrievalIndex;
    encodingOnsetTrigger = events(encodingOnsetIndices(i), end);
    encodingVisualTriggerIndex = find(~contributedByButton(encodingOnsetIndices(i)+1:end), 1) + encodingOnsetIndices(i);
    if maintenanceLogicalIndices(encodingVisualTriggerIndex)
        encodingVisualTriggerIndex = encodingOnsetIndices(i);
    end
    encodingVisualLogicalIndices(encodingVisualTriggerIndex) = true;
    triggerFollowingEncodingOnset = events(encodingVisualTriggerIndex, end);
    assert(ismember(triggerFollowingEncodingOnset, [bitset(encodingOnsetTrigger, BitTrigger.visual), bitset(0, BitTrigger.visual)]), "Unexpected trigger, %d, following encoding onset index %d.", triggerFollowingEncodingOnset, encodingOnsetIndices(i));
    retrievalOnsetTrigger = events(retrievalOnsetIndices(i), end);
    retrievalVisualTriggerIndex = find(~contributedByButton(retrievalOnsetIndices(i)+1:end), 1) + retrievalOnsetIndices(i);
    triggerFollowingRetrievalOnset = events(retrievalVisualTriggerIndex, end);
    assert(ismember(triggerFollowingRetrievalOnset, [bitset(retrievalOnsetTrigger, BitTrigger.visual), bitset(0, BitTrigger.visual), 4097, 4098]), "Unexpected trigger, %d, following retrieval onset index %d.", triggerFollowingRetrievalOnset, retrievalOnsetIndices(i));
    if ~isempty(responseIndex) ...
            && (bitget(events(responseIndex, end), BitTrigger.buttonOne) && ismember(events(retrievalIndex, end), [33, 4129]) ...
            || bitget(events(responseIndex, end), BitTrigger.buttonTwo) && ismember(events(retrievalIndex, end), [34, 4130]))
        events(encodingVisualTriggerIndex, end) = bitset(encodingOnsetTrigger, BitTrigger.visual);
        events(retrievalVisualTriggerIndex, end) = bitset(retrievalOnsetTrigger, BitTrigger.visual);
    else
        events(encodingVisualTriggerIndex, end) = bitset(encodingOnsetTrigger, BitTrigger.visual) + 4000;
        events(retrievalVisualTriggerIndex, end) = bitset(retrievalOnsetTrigger, BitTrigger.visual) + 4000;
    end
end
events((encodingOnsetLogicalIndices | retrievalOnsetLogicalIndices | fixationLogicalIndices) & ~encodingVisualLogicalIndices, :) = [];
end

function indices = findOnsetLogicalIndices(events, candidateTriggers)
indices = false([size(events, 1), 1]);
offset = 1;
candidates = ismember(events(:, end), candidateTriggers);
while offset <= size(events, 1)
    nextIndex = find(candidates(offset:end), 1) + offset - 1;
    if isempty(nextIndex)
        break
    end
    indices(nextIndex) = true;
    offset = nextIndex + 1;
    while offset <= size(events, 1) && (candidates(offset) || bitget(events(offset, end), BitTrigger.buttonOne) || bitget(events(offset, end), BitTrigger.buttonTwo))
        offset = offset + 1;
    end
end
end

function indices = firstOfGroupLogicalIndices(events, candidateTriggers)
indices = diff([0; ismember(events(:, end), candidateTriggers)]) == 1;
end