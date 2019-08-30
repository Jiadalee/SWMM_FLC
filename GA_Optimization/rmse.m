function r=rmse(data,estimate)
% Computing the root-mean-square error

% delete records with NaNs in both datasets first
I = ~isnan(data) & ~isnan(estimate); 
data = data(I); estimate = estimate(I);

r=sqrt(sum((data(:)-estimate(:)).^2)/numel(data));