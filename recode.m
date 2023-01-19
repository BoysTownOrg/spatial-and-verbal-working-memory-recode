function events = recode(events)
events([Inf; diff(events(:, 1))] <= 1024 & [1; diff(events(:, end))] == 0, :) = [];
fixationLogicalIndices = diff([0; ismember(events(:, end), [20, 4116])]) == 1;
encodingOnsetLogicalIndices = diff([0; ismember(events(:, end), [23, 24, 4119, 4120])]) == 1;
retrievalOnsetLogicalIndices = diff([0; ismember(events(:, end), [33, 34, 4129, 4130])]) == 1;
encodingOnsetIndices = find(encodingOnsetLogicalIndices);
retrievalOnsetIndices = find(retrievalOnsetLogicalIndices);
assert(numel(encodingOnsetIndices) == numel(retrievalOnsetIndices), ...
    "The number of encoding onset triggers does not match the number of retrieval onset triggers.");
contributedByButton = logical(bitget(events(:, end), 8+1)) | logical(bitget(events(:, end), 9+1));
for i = 1:numel(retrievalOnsetIndices)
    if i == numel(retrievalOnsetIndices)
        lastCandidateResponseIndex = size(events, 1);
    else
        lastCandidateResponseIndex = encodingOnsetIndices(i+1) - 1;
    end
    retrievalIndex = retrievalOnsetIndices(i);
    responseIndex = find(contributedByButton(retrievalIndex+1:lastCandidateResponseIndex), 1) + retrievalIndex;
    encodingOnsetTrigger = events(encodingOnsetIndices(i), end);
    triggerFollowingEncodingOnset = events(encodingOnsetIndices(i) + 1, end);
    assert(ismember(triggerFollowingEncodingOnset, [bitset(encodingOnsetTrigger, 12 + 1), 4096]), "Unexpected trigger, %d, following encoding onset index %d.", triggerFollowingEncodingOnset, encodingOnsetIndices(i));
    retrievalOnsetTrigger = events(retrievalOnsetIndices(i), end);
    triggerFollowingRetrievalOnset = events(retrievalOnsetIndices(i) + 1, end);
    assert(ismember(triggerFollowingRetrievalOnset, [bitset(retrievalOnsetTrigger, 12 + 1), 4096]), "Unexpected trigger, %d, following retrieval onset index %d.", triggerFollowingRetrievalOnset, retrievalOnsetIndices(i));
    if ~isempty(responseIndex) ...
            && (bitget(events(responseIndex, end), 8+1) && ismember(events(retrievalIndex, end), [33, 4129]) ...
            || bitget(events(responseIndex, end), 9+1) && ismember(events(retrievalIndex, end), [34, 4130]))
        events(encodingOnsetIndices(i) + 1, end) = bitset(encodingOnsetTrigger, 12 + 1);
        events(retrievalOnsetIndices(i) + 1, end) = bitset(retrievalOnsetTrigger, 12 + 1);
    else
        events(encodingOnsetIndices(i) + 1, end) = bitset(encodingOnsetTrigger, 12 + 1) + 4000;
        events(retrievalOnsetIndices(i) + 1, end) = bitset(retrievalOnsetTrigger, 12 + 1) + 4000;
    end
end
events(encodingOnsetLogicalIndices | retrievalOnsetLogicalIndices | fixationLogicalIndices, :) = [];
end