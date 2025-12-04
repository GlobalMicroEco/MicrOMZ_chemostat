function unpackStruct (structure)
% Simple function to extract all fields of a structure as individual terms
    fn = fieldnames(structure);
    for i = 1:numel(fn)
        fni = string(fn(i));
        field = structure.(fni);
%        if (isstruct(field))
%            unpackStruct(field);
%            continue;
%        end
        assignin('caller', fni, field);
    end
end
