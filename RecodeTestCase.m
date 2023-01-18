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
            self.assertEqual(recode(events), [
                18308000       	1	4119
                19803000       	1	4121
                22310000       	1	4129
                22865000       	1	256]);
        end

        function tbd3(self)
            events = [
                23609000       	1	4116
                25411000       	1	24
                25428000       	1	4096
                26913000       	1	4121
                29416000       	1	34
                29430000       	1	4096
                29869000       	1	512
                ];
            self.assertEqual(recode(events), [                
                25428000       	1	4120
                26913000       	1	4121
                29430000       	1	4130
                29869000       	1	512]);
        end
    end
end