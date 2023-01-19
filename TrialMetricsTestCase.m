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

        function tbd2(self)
            events = [
                16548000       	1	4116
                18301000       	1	23
                18308000       	1	4119
                19803000       	1	4121
                22305000       	1	33
                22310000       	1	4129
                22865000       	1	256
                ];
            metrics = trialMetrics(recode(events));
            self.verifyTrialCount(metrics, 1);
            self.verifyTrue(metrics(1).correct);
            self.verifyEqual(metrics(1).reactionTimeMilliseconds, 22865 - 22310);
            self.verifyEqual(metrics(1).condition, Condition.InSet);
        end

        function tbd3(self)
            events = [
                30718000       	1	4116
                32221000       	1	23
                32232000       	1	4119
                33723000       	1	4121
                36225000       	1	33
                36234000       	1	4129
                37095000       	1	512
                ];
            metrics = trialMetrics(recode(events));
            self.verifyTrialCount(metrics, 1);
            self.verifyFalse(metrics(1).correct);
            self.verifyEqual(metrics(1).reactionTimeMilliseconds, nan);
            self.verifyEqual(metrics(1).condition, Condition.InSet);
        end
    end
end