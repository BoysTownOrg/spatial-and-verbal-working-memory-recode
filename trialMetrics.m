function metrics = trialMetrics(events)
retrievalIndices = find(ismember(events(:, end), [4129, 4130, 8129, 8130]));
metrics(numel(retrievalIndices)).correct = false;
for i = 1:numel(retrievalIndices)
    index = retrievalIndices(i);
    metrics(i).correct = ismember(events(index, end), [4129, 4130]);
    metrics(i).condition = conditionFromRetrievalIndex(events, index);
    metrics(i).reactionTimeMilliseconds = nan;
    if metrics(i).correct
        responseIndex =  find(logical(bitget(events(index+1:end, end), 9)) | logical(bitget(events(index+1:end, end), 10)), 1) + index;
        metrics(i).reactionTimeMilliseconds = (events(responseIndex, 1) - events(index, 1)) / 1000;
    end
end
end

function condition = conditionFromRetrievalIndex(events, index)
switch events(index, end)
    case {4129, 8129}
        condition = Condition.InSet;
    case {4130, 8130}
        condition = Condition.OutOfSet;
end
end