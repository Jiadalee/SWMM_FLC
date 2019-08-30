function y=mod_fis_2(delta,SetOfSamples)


fuzinfsys=evalin('base','fuzinfsys');

delta_num=0;
for i=1:1:length(fuzinfsys.input)
    for j=1:1:length(fuzinfsys.input(i).mf)
        delta_num = delta_num + 1;
        fuzinfsys.input(i).mf(j).params(1)=fuzinfsys.input(i).mf(j).params(1)+delta(delta_num);
        delta_num = delta_num + 1;
        fuzinfsys.input(i).mf(j).params(2)=fuzinfsys.input(i).mf(j).params(2)+delta(delta_num);
       
        fuzinfsys.input(i).mf(j).params(3)=fuzinfsys.input(i).mf(j).params(3)+delta(delta_num);
        delta_num = delta_num + 1;
        fuzinfsys.input(i).mf(j).params(4)=fuzinfsys.input(i).mf(j).params(4)+delta(delta_num);
    end

end
SetOfInputSamples=[];

for i=1:1:length(fuzinfsys.input)
	SetOfInputSamples=[SetOfInputSamples SetOfSamples(:,i)];
end
Yes_No_Out=evalfis(SetOfInputSamples,fuzinfsys);


SetOfOutputSamples=[];

for i=(length(fuzinfsys.input)+1):1:(length(fuzinfsys.input)+length(fuzinfsys.output))
	SetOfOutputSamples=[SetOfOutputSamples SetOfSamples(:,i)];
end

Result= [SetOfOutputSamples,Yes_No_Out];
y=rmse(Result(:,1),Result(:,2));