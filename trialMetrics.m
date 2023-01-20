function metrics = trialMetrics(events)
retrievalIndices = find(ismember(events(:, end), [...
    bitset(33, BitTrigger.visual), ...
    bitset(34, BitTrigger.visual), ...
    bitset(33, BitTrigger.visual) + 4000, ...
    bitset(34, BitTrigger.visual) + 4000]));
metrics(numel(retrievalIndices)).correct = false;
for i = 1:numel(retrievalIndices)
    index = retrievalIndices(i);
    metrics(i).correct = ismember(events(index, end), [...
        bitset(33, BitTrigger.visual), ...
        bitset(34, BitTrigger.visual)]);
    metrics(i).condition = conditionFromRetrievalIndex(events, index);
    metrics(i).reactionTimeMilliseconds = nan;
    if metrics(i).correct
        responseIndex =  find(logical(bitget(events(index+1:end, end), BitTrigger.buttonOne)) ...
            | logical(bitget(events(index+1:end, end), BitTrigger.buttonTwo)), 1) + index;
        metrics(i).reactionTimeMilliseconds = (events(responseIndex, 1) - events(index, 1)) / 1000;
    end
end
end

function condition = conditionFromRetrievalIndex(events, index)
switch events(index, end)
    case {bitset(33, BitTrigger.visual), bitset(33, BitTrigger.visual) + 4000}
        condition = Condition.InSet;
    case {bitset(34, BitTrigger.visual), bitset(34, BitTrigger.visual) + 4000}
        condition = Condition.OutOfSet;
end
end