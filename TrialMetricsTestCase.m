classdef TrialMetricsTestCase < matlab.unittest.TestCase
    methods (Access = private)
        function verifyTrialCount(self, metrics, n)
            self.verifyEqual(numel(metrics), n);
        end
    end

    methods (Test)
        function tbd(self)
            events = [
                9689000        	1	20
                11241000       	1	24
                11255000       	1	4096
                12743000       	1	4121
                15245000       	1	34
                15257000       	1	4130
                15885000       	1	512
                ];
            metrics = trialMetrics(recode(events));
            self.verifyTrialCount(metrics, 1);
            self.verifyTrue(metrics(1).correct);
            self.verifyEqual(metrics(1).reactionTimeMilliseconds, 15885 - 15257);
            self.verifyEqual(metrics(1).condition, Condition.OutOfSet);
        end
    end
end