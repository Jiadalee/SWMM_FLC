% Some redundant calculations to preserve the compatibility with the donor project
NumberOfInputs = length(genfuzinfsys.input);


for i=1:1:NumberOfInputs
    
    for j=1:1:length(genfuzinfsys.input(i).mf)
        
        if strcmp(genfuzinfsys.input(i).mf(j).type,'trapmf') == 1
            genfuzinfsys.input(i).mf(j).type = 'trimf';
            
            ParA = genfuzinfsys.input(i).mf(j).params(1);
            ParB = genfuzinfsys.input(i).mf(j).params(2);
            ParC = genfuzinfsys.input(i).mf(j).params(3);
            ParD = genfuzinfsys.input(i).mf(j).params(4);

            genfuzinfsys.input(i).mf(j).params=[ParA ParB ParD];
        end
        
    end
    
end
