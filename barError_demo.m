% Demo for barError 
% David S. White [dswhite2012@gmail.com];
% 2019-09-19 MIT License

% y data [3 conditions, 1 group]
y=cell(3,3);
y{1,1} =normrnd(10,1,10,1);
y{2,1} =normrnd(50,2,10,1);
y{3,1} =normrnd(10,3,10,1);
y{4,1} =normrnd(10,3,10,1);

y{1,2} =y{1,1} * 1.5;
y{2,2} =y{2,1} * 1.5;
y{3,2} =y{3,1} * 1.5;
y{4,2} =y{3,1} * 1.5;

y{1,3} =y{1,1} * 2.5;
y{2,3} =y{2,1} * 2.5;
y{3,3} =y{3,1} * 2.5;
y{4,3} =y{3,1} * 2.5;
y = [y,y];

%% without modifications
close all
figure; 
barError(y);

%% with modificiaitons
h = figure; 
barError(y,'dataSize',15,'fillData',1,'jitterAmount', 0.05, 'capSize',10);
grid on
pbaspect([2,1,1]);
h.Units = 'inches';
h.Position = [0,0,5,2.5];
set(gca,'fontsize',7,'fontname','arial');
saveas(h, 'demo.png')
