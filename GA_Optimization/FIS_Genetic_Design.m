% Generating the FIS incorporating the results of the genetic optimization

Generated_FIS_Name = input('Enter the initial FIS name: ','s');
genfuzinfsys=readfis(Generated_FIS_Name);

fuzinfsys = genfuzinfsys;
AddConvert_1;
genfuzinfsys = fuzinfsys;

for i=1:1:length(genfuzinfsys.input)
    genfuzinfsys.input(i).range(2)=genfuzinfsys.input(i).range(2)+dist;
    genfuzinfsys.input(i).range(1)=genfuzinfsys.input(i).range(1)-dist;
end
delta_name = input('Enter the name of the tuned-parameter array: ','s');
delta = eval(delta_name);

delta_num=0;
for i=1:1:length(genfuzinfsys.input)
    for j=1:1:length(genfuzinfsys.input(i).mf)
        delta_num = delta_num + 1;
        genfuzinfsys.input(i).mf(j).params(1)=genfuzinfsys.input(i).mf(j).params(1)+delta(delta_num);
        delta_num = delta_num + 1;
        genfuzinfsys.input(i).mf(j).params(2)=genfuzinfsys.input(i).mf(j).params(2)+delta(delta_num);
        
        genfuzinfsys.input(i).mf(j).params(3)=genfuzinfsys.input(i).mf(j).params(3)+delta(delta_num);
        delta_num = delta_num + 1;
        genfuzinfsys.input(i).mf(j).params(4)=genfuzinfsys.input(i).mf(j).params(4)+delta(delta_num);
    end

end

AddConvert_2 % The reason of using such redundant calculations 
             % is to preserve the compatibility between this submission and 
             % the whole project, which it was taken from.
             % However, note that this redundancy doesn't cause any additional
             % variables to be tuned by GA, and, therefore, the increase in
             % computational cost is rather insignificant.

Save_FIS=input('Enter the final FIS name: ','s');
writefis(genfuzinfsys,Save_FIS);
Save_MAT=[Save_FIS,'.mat'];
save(Save_MAT);
