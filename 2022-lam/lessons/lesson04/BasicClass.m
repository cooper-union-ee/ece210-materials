classdef BasicClass
    % BasicClass is a simple sample class definition
    properties (Access = private)
        vals     % vector
    end
    
    methods
        function obj = BasicClass(x)
            % Construct an instance of this class
            % Sets x to the object's vals property
            obj.vals = x;
        end
        
        function z = getVals(obj)
            z = obj.vals;
        end
        
        function z = findClosest(obj,n)
            % Find closest entry in obj.vals to n
            [~, ind] = min(abs(obj.vals - n));
            z = obj.vals(ind);
        end
    end
end