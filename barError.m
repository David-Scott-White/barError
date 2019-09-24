function hBarError=barError(y,x_labels,varargin)
% Generate a bar plot with error bars and w/ option to overlay raw data 
%
% David S. White [dswhite2012@gmail.com];
% 2019-09-19 MIT License
%
% Overview: 
% ----------
% The goal of barError is to generate a barplot with error bar and raw data
% shown. This is an extension of built in MATLAB plotting functions:
% bar, errorbar, & scatter. barError will compute the mean and standard
% deviation of values provided in y for plotting the summary statistics
% overlaid with raw data.
% 
% Input Data: 
% -----------
% x = vector of x values [optional, can be left empty]
% y = cell array of y values [n,m] where n is per condtion and m is per
% group. [column major]
% 
% Ouput Data: 
% -----------
% H = final figure. 
%

% Check input data. 
% -----------------
[n_conditions, n_groups] = size(y); 
% should write a check for if y is cell 

% compute mean & std values for all conditoins and groups of y
y_mu = zeros(n_conditions,n_groups);
y_sd = zeros(n_conditions,n_groups);
for n = 1:n_conditions
    for m = 1:n_groups
        y_mu(n,m) = mean(y{n,m}); 
        y_sd(n,m) = std(y{n,m}); 
    end
end
% set default width of bar plot 
if n_conditions == 1
    bar_width = 0.75; 
else
     bar_width = 1; 
end

% Generate Figure
figure; 

% Default bar plot  
hBarError = bar(y_mu,bar_width); 
hold on

% grab all x_data information 


% adjust color and specs

% plot the error [top only]; need to match linewidths
% need to know position of x axis
for m = 1:n_groups
    % grab offset from figure if plotting multiple groups
    x_data =  hBarError(m).XData+hBarError(m).XOffset;
    
    % plot error bar with top line only [need to modify]
    errorbar(x_data, y_mu(:,m), nan(numel(y_sd(:,m)),1), y_sd(:,m),...
        'k','linestyle','none','CapSize',20,'linewidth',1); hold on
    
    % now scatter on the data
    for n= 1:n_conditions
        y_data = y{n,m};
        scatter(zeros(numel(y_data),1)+x_data(n),y_data,100,...
            'MarkerEdgeColor','k', 'MarkerFaceAlpha',0.75,'jitter','on','jitterAmount',0); hold on
    end
    
end

grid on
% now we need to show the data 
end

