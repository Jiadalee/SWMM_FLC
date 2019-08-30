% Some redundant calculations to preserve the compatibility with the donor project
NumberOfInputs = length(fuzinfsys.input);


for i=1:1:NumberOfInputs
    
    for j=1:1:length(fuzinfsys.input(i).mf)
        
        if strcmp(fuzinfsys.input(i).mf(j).type,'trimf') == 1
            fuzinfsys.input(i).mf(j).type = 'trapmf';
            
            ParA = fuzinfsys.input(i).mf(j).params(1);
            ParB = fuzinfsys.input(i).mf(j).params(2);
            ParC = fuzinfsys.input(i).mf(j).params(3);
            fuzinfsys.input(i).mf(j).params=[ParA ParB ParB ParC];
        end
        
    end
    
end
