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

        function tbd4(self)
            events = [
                30718000       	1	4116
                32221000       	1	23
                32232000       	1	4119
                33723000       	1	4121
                36225000       	1	33
                36234000       	1	4129
                37095000       	1	512
                ];
            self.assertEqual(recode(events), [
                32232000       	1	8119
                33723000       	1	4121
                36234000       	1	8129
                37095000       	1	512]);
        end

        function tbd5(self)
            events = [
                37528000       	1	4116
                39180000       	1	24
                39185000       	1	4120
                40682000       	1	4121
                43185000       	1	4130
                43187000       	1	4130
                43770000       	1	512
                ];
            self.assertEqual(recode(events), [
                39185000       	1	4120
                40682000       	1	4121
                43187000       	1	4130
                43770000       	1	512]);
        end

        function tbd6(self)
            events = [
                44487000       	1	4116
                46189000       	1	23
                46206000       	1	4096
                47691000       	1	4121
                50195000       	1	33
                50208000       	1	4096
                50693000       	1	256
                ];
            self.assertEqual(recode(events), [
                46206000       	1	4119
                47691000       	1	4121
                50208000       	1	4129
                50693000       	1	256]);
        end

        function tbd7(self)
            events = [
                51498000       	1	4116
                53350000       	1	24
                53359000       	1	4120
                54852000       	1	4121
                57354000       	1	34
                57361000       	1	4130
                58159000       	1	256
                ];
            self.assertEqual(recode(events), [
                53359000       	1	8120
                54852000       	1	4121
                57361000       	1	8130
                58159000       	1	256]);
        end

        function tbd8(self)
            events = [
                72526000       	1	4116
                73928000       	1	23
                73936000       	1	4119
                75430000       	1	4121
                75843000       	1	256
                77933000       	1	33
                77938000       	1	4129
                78532000       	1	256
                ];
            self.assertEqual(recode(events), [
                73936000       	1	4119
                75430000       	1	4121
                75843000       	1	256
                77938000       	1	4129
                78532000       	1	256]);
        end

        function tbd9(self)
            events = [
                79236000       	1	4116
                80538000       	1	4120
                80540000       	1	4120
                82040000       	1	4121
                84542000       	1	34
                84558000       	1	4096
                ];
            self.assertEqual(recode(events), [
                80540000       	1	8120
                82040000       	1	4121
                84558000       	1	8130]);
        end

        function tbd10(self)
            events = [
                106173000      	1	4116
                107425000      	1	23
                107437000      	1	4119
                108927000      	1	4121
                111430000      	1	33
                111439000      	1	4129
                112732000      	1	4116
                112954000      	1	512
                ];
            self.assertEqual(recode(events), [
                107437000      	1	8119
                108927000      	1	4121
                111439000      	1	8129
                112954000      	1	512]);
        end

        function tbd11(self)
            events = [
                112732000      	1	4116
                112954000      	1	512
                114535000      	1	23
                114540000      	1	4119
                116037000      	1	4121
                118539000      	1	4129
                118542000      	1	4129
                119842000      	1	4116
                119924000      	1	512
                ];
            self.assertEqual(recode(events), [
                112954000      	1	512
                114540000      	1	8119
                116037000      	1	4121
                118542000      	1	8129
                119924000      	1	512]);
        end

        function tbd12(self)
            events = [
                112732000      	1	4116
                112954000      	1	512
                114535000      	1	23
                114540000      	1	4119
                116037000      	1	4121
                118539000      	1	4129
                118542000      	1	4129
                119842000      	1	4116
                119924000      	1	512
                121244000      	1	24
                121260000      	1	4096
                122746000      	1	4121
                123380000      	1	512
                125248000      	1	34
                125262000      	1	4096
                126372000      	1	512
                ];
            self.assertEqual(recode(events), [
                112954000      	1	512
                114540000      	1	8119
                116037000      	1	4121
                118542000      	1	8129
                119924000      	1	512
                121260000      	1	4120
                122746000      	1	4121
                123380000      	1	512
                125262000      	1	4130
                126372000      	1	512]);
        end

        function tbd13(self)
            events = [
                35072000       	1	4116
                36574000       	1	23
                36579000       	1	4119
                38076000       	1	4121
                40579000       	1	33
                40599000       	1	4096
                41190000       	1	512
                41503000       	1	768
                ];
            self.assertEqual(recode(events), [
                36579000       	1	8119
                38076000       	1	4121
                40599000       	1	8129
                41190000       	1	512
                41503000       	1	768]);
        end

        function tbd14(self)
            events = [
                133389000      	1	4116
                134640992      	1	23
                134652992      	1	4119
                136143008      	1	4121
                138644992      	1	33
                138656992      	1	4129
                139948000      	1	4116
                140348000      	1	256
                ];
            self.assertEqual(recode(events), [
                134652992      	1	4119
                136143008      	1	4121
                138656992      	1	4129
                140348000      	1	256]);
        end

        function tbd15(self)
            events = [
                400940992      	1	4116
                401072992      	1	256
                401548000      	1	256
                401795008      	1	256
                402543008      	1	23
                402552000      	1	4119
                404046016      	1	4121
                406548000      	1	33
                406553984      	1	4129
                407851008      	1	4116
                408215008      	1	256
                ];
            self.assertEqual(recode(events), [
                401072992      	1	256
                401548000      	1	256
                401795008      	1	256
                402552000      	1	4119
                404046016      	1	4121
                406553984      	1	4129
                408215008      	1	256]);
        end

        function tbd16(self)
            events = [
                342380000      	1	4116
                342537984      	1	256
                344281984      	1	24
                344300992      	1	4096
                345784000      	1	4121
                348286016      	1	34
                348287008      	1	34
                348303008      	1	4096
                ];
            self.assertEqual(recode(events), [
                342537984      	1	256
                344300992      	1	8120
                345784000      	1	4121
                348303008      	1	8130]);
        end

        function tbd17(self)
            events = [
                542758016      	1	4116
                544460032      	1	4120
                544460992      	1	4120
                545961984      	1	4121
                548465024      	1	34
                548480000      	1	4096
                549404992      	1	512
                ];
            self.assertEqual(recode(events), [
                544460992      	1	4120
                545961984      	1	4121
                548480000      	1	4130
                549404992      	1	512]);
        end

        function tbd18(self)
            events = [
                291916992      	1	4116
                293168992      	1	23
                293172992      	1	512
                293183008      	1	4096
                294671008      	1	4121
                297172992      	1	33
                297177984      	1	4129
                298084000      	1	256
                ];
            self.assertEqual(recode(events), [
                293172992      	1	512
                293183008      	1	4119
                294671008      	1	4121
                297177984      	1	4129
                298084000      	1	256]);
        end

        function tbd19(self)
            events = [
                804529984      	1	4116
                806432000      	1	23
                806446016      	1	4096
                807934016      	1	4121
                810435968      	1	33
                810449024      	1	4097
                ];
            self.assertEqual(recode(events), [
                806446016      	1	8119
                807934016      	1	4121
                810449024      	1	8129]);
        end

        function tbd20(self)
            events = [
                94646000       	1	4116
                94935000       	1	512
                95998000       	1	512
                96006000       	1	4119
                97500000       	1	4121
                100002000      	1	33
                100010000      	1	4129
                100865000      	1	256
                ];
            self.assertEqual(recode(events), [
                94935000       	1	512
                95998000       	1	512
                96006000       	1	4119
                97500000       	1	4121
                100010000      	1	4129
                100865000      	1	256]);
        end

        function tbd21(self)
            events = [
                781905984      	1	4116
                783809024      	1	23
                783814976      	1	512
                783817984      	1	4119
                785310976      	1	4121
                787814016      	1	33
                787820032      	1	4129
                789116032      	1	4116
                790011008      	1	256
                ];
            self.assertEqual(recode(events), [
                783814976      	1	512
                783817984      	1	4119
                785310976      	1	4121
                787820032      	1	4129
                790011008      	1	256]);
        end

        function tbd22(self)
            events = [
                9279000        	1	20
                10831000       	1	24
                10853000       	1	4096
                12333000       	1	4121
                14836000       	1	34
                14848000       	1	4098
                15736000       	1	512
                ];
            self.assertEqual(recode(events), [
                10853000       	1	4120
                12333000       	1	4121
                14848000       	1	4130
                15736000       	1	512]);
        end
    end
end