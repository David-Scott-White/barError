% Demo for barError 
% David S. White [dswhite2012@gmail.com];
% 2019-09-19 MIT License

% x data
x = [1:3]; 

% y data [3 conditions, 1 group]
y=cell(3,2);
y{1,1} =normrnd(10,1,50,1);
y{2,1} =normrnd(20,2,50,1);
y{3,1} =normrnd(30,3,50,1);

y{1,2} =y{1,1} * 1.5;
y{2,2} =y{2,1} * 1.5;
y{3,2} =y{3,1} * 1.5;

barError(y)