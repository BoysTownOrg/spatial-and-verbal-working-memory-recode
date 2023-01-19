classdef FileStream < handle
    properties (Access = private)
        fid
    end

    methods
        function self = FileStream(filepath)
            self.fid = fopen(filepath, 'w');
        end

        function write(self, s)
            fwrite(self.fid, s);
        end

        function delete(self)
            fclose(self.fid);
        end
    end
end