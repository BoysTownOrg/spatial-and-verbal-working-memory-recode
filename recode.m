function events = recode(events)
events([Inf; diff(events(:, 1))] <= 1024 & [1; diff(events(:, end))] == 0 & events(:, end) < 4096, :) = [];
fixationLogicalIndices = diff([0; ismember(events(:, end), [20, 4116])]) == 1;
encodingOnsetLogicalIndices = findEncodingOnsetLogicalIndices(events);
maintenanceLogicalIndices = diff([0; ismember(events(:, end), 4121)]) == 1;
retrievalOnsetLogicalIndices = diff([0; ismember(events(:, end), [33, 34, 4129, 4130])]) == 1;
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
    assert(ismember(triggerFollowingEncodingOnset, [bitset(encodingOnsetTrigger, 12 + 1), 4096]), "Unexpected trigger, %d, following encoding onset index %d.", triggerFollowingEncodingOnset, encodingOnsetIndices(i));
    retrievalOnsetTrigger = events(retrievalOnsetIndices(i), end);
    retrievalVisualTriggerIndex = find(~contributedByButton(retrievalOnsetIndices(i)+1:end), 1) + retrievalOnsetIndices(i);
    triggerFollowingRetrievalOnset = events(retrievalVisualTriggerIndex, end);
    assert(ismember(triggerFollowingRetrievalOnset, [bitset(retrievalOnsetTrigger, 12 + 1), 4096, 4097, 4098]), "Unexpected trigger, %d, following retrieval onset index %d.", triggerFollowingRetrievalOnset, retrievalOnsetIndices(i));
    if ~isempty(responseIndex) ...
            && (bitget(events(responseIndex, end), 8+1) && ismember(events(retrievalIndex, end), [33, 4129]) ...
            || bitget(events(responseIndex, end), 9+1) && ismember(events(retrievalIndex, end), [34, 4130]))
        events(encodingVisualTriggerIndex, end) = bitset(encodingOnsetTrigger, 12 + 1);
        events(retrievalVisualTriggerIndex, end) = bitset(retrievalOnsetTrigger, 12 + 1);
    else
        events(encodingVisualTriggerIndex, end) = bitset(encodingOnsetTrigger, 12 + 1) + 4000;
        events(retrievalVisualTriggerIndex, end) = bitset(retrievalOnsetTrigger, 12 + 1) + 4000;
    end
end
events((encodingOnsetLogicalIndices | retrievalOnsetLogicalIndices | fixationLogicalIndices) & ~encodingVisualLogicalIndices, :) = [];
end

function indices = findEncodingOnsetLogicalIndices(events)
indices = false([size(events, 1), 1]);
offset = 1;
candidates = ismember(events(:, end), [23, 24, 4119, 4120]);
while offset <= size(events, 1)
    nextIndex = find(candidates(offset:end), 1) + offset - 1;
    if isempty(nextIndex)
        break
    end
    indices(nextIndex) = true;
    offset = nextIndex + 1;
    while offset <= size(events, 1) && (candidates(offset) || bitget(events(offset, end), 8 + 1) || bitget(events(offset, end), 9 + 1))
        offset = offset + 1;
    end
end
end