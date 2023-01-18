classdef RecodeTestCase < matlab.unittest.TestCase
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
            self.assertEqual(recode(events), [
                11255000       	1	4120
                12743000       	1	4121
                15257000       	1	4130
                15885000       	1	512]);
        end
    end
end