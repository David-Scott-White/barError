function barErrorFig=barError(y,varargin)
% Generate a bar plot with error bars and overlay of the raw data 
%
% David S. White [dswhite2012@gmail.com];
% MIT License
% updated: 2019-10-04 
%
% Overview: 
% ----------
% The goal of barError is to generate a barplot with error bar and raw data
% shown. This is an extension of built in MATLAB plotting functions:
%   1. bar 
%   2. errorbar 
%   3. scatter 
% barError will compute the mean and standard deviation of values provided 
% in y for plotting the summary statistics overlaid with raw data.
% 
% Input: 
% -----
% barError(y) = y is cell array of y values [n,m] where n is per condtion 
% and m is per group. [column major]. 
%
% Ouput Data: 
% -----------
% barErrorFig = final figure
%
% Varagin 
% -------
% barError(y,'PARAM1','val1', 'PARAM2', 'val2', ...)
% specifies optional conditons for plotting. 
%   xLabel
%   yLabel
%   conditions
%   groups
%   lineWidth
%   capSize
%   jitterAmount
%   fillData
%   dataSize
%
% -------------------------------------------------------------------------
%
% Initalize:
% ----------
%
% Grab number of groups and conditons from the size of y
[numConditions, numGroups] = size(y); 

% Set Default values for plotting. These will be updated by varargin 
xLabel = 'Conditions';
yLabel = 'Observed Values';
conditions = [1:numConditions]; 
groups = cell(numGroups,1); 

% Name the groups by number  
for n = 1:numGroups
    groups{n} = ['Group ',num2str(n)]; 
end
barAlpha = 0.6; 
lineWidth = 1; 
jitterAmount = 0.05; 
capSize = 20; 
fillData = 0;
dataSize = 100; 

% check varargin and set defaults if needed
for i = 1:2:length(varargin)-1
    switch varargin{i}
        case 'xLabel'
            xLabel = varargin{i+1}; 
        case 'yLabel'
            yLabel = varargin{i+1}; 
        case 'conditions'
            conditions = varargin{i+1}; 
        case 'groups'
            groups = varargin{i+1}; 
        case 'lineWidth'
            lineWidth = varargin{i+1};
        case 'capSize'
            capSize = varargin{i+1};
        case 'jitterAmount'
            jitterAmount = varargin{i+1}; 
        case 'fillData'
            fillData = varargin{i+1}; 
        case 'dataSize'
            dataSize = varargin{i+1}; 
    end
end

% compute mean & std values for all conditions and groups in y
yMu = zeros(numConditions,numGroups);
ySD = zeros(numConditions,numGroups);
for n = 1:numConditions
    for m = 1:numGroups
        yMu(n,m) = mean(y{n,m}); 
        ySD(n,m) = std(y{n,m}); 
    end
end

% set default width of bar plot 
if numGroups == 1
    barWidth = 0.75; 
else
    barWidth = 1; 
end

% Begin generating the figure
% ----------------------------

% Default bar plot  
barErrorFig = bar(yMu,barWidth,'LineWidth',lineWidth, 'FaceAlpha',barAlpha,...
    'EdgeColor', 'k'); 

% Set axis labels and legend. turn off autoupdate of legend so values from
% scatter and error bar do not get added. 
ylabel(yLabel);
xlabel(xLabel);
xticklabels(conditions);
legend(groups,'location','northwest','AutoUpdate','off');

% Plot Error Bars on top of Bar Graph
hold on;

% plot the error [top only]; need to match linewidths
% need to know position of x axis

% use default colors for now [should update for custom colors]
dataColors = lines(numGroups);

% Plot the scatter and errorbars of all data 
for m = 1:numGroups
    % grab offset from figure if plotting multiple groups
    xData =  barErrorFig(m).XData+barErrorFig(m).XOffset;
    
    % now scatter on the data
    for n= 1:numConditions
        yData = y{n,m};
        if fillData
            scatter(zeros(numel(yData),1)+xData(n),yData,dataSize,'filled',...
                'MarkerFaceColor', dataColors(m,:) ,'MarkerEdgeColor','k', ...
                'MarkerFaceAlpha',1,'jitter','on','jitterAmount',jitterAmount);
        else
            scatter(zeros(numel(yData),1)+xData(n),yData,dataSize,...
                'MarkerEdgeColor','k', 'MarkerFaceAlpha',0.75,'jitter','on',...
                'jitterAmount',jitterAmount);
        end
        hold on
    end
    % plot error bar with top line only [need to modify]
    errorbar(xData, yMu(:,m), nan(numel(ySD(:,m)),1), ySD(:,m),...
        'k','linestyle','none','CapSize',capSize,'linewidth',lineWidth);
    hold on
end

% turn on grid for better clarity
grid on

end

