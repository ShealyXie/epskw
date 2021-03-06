function create_chikw_lineplot(X1, YMatrix1)
%CREATEFIGURE(X1, YMATRIX1)
%  X1:  vector of x data
%  YMATRIX1:  matrix of y data

%  Auto-generated by MATLAB on 18-Oct-2014 19:08:39

% Create figure
figure1 = figure;

% Create axes
axes1 = axes('Parent',figure1,...
    'XTick',[35 100 200 300 400 500 600 700 800 900 1000],...
    'Position',[0.155723905723906 0.157560355781449 0.718855218855219 0.729409816903011],...
    'FontSize',30,...
    'ColorOrder',[0 0 0.6;0 0 0.8;0 0 1;0 0.2 1;0 0.4 1;0 0.6 1;0 0.8 1;0 1 1;0.2 1 0.8;0.4 1 0.6;0.6 1 0.4;0.8 1 0.2;1 1 0;1 0.8 0;1 0.6 0;1 0.4 0;1 0.2 0;1 0 0;0.8 0 0]);
%% Uncomment the following line to preserve the X-limits of the axes
xlim(axes1,[10 1000]);
% Uncomment the following line to preserve the Y-limits of the axes
ylim(axes1,[0 0.01]);
hold(axes1,'all');

% Create ylabel
ylabel('\chi_T (k,\omega)','FontSize',35);

% Create xlabel
xlabel('\omega (cm^{-1})','FontSize',35);

% Create title
title('\omega (THz)','FontSize',35);

% Create multiple lines using matrix input to plot
plot1 = plot(X1,YMatrix1,'Parent',axes1);
set(plot1(1),'DisplayName','0.25');
set(plot1(2),'DisplayName','0.36');
set(plot1(3),'DisplayName','0.44');
set(plot1(4),'DisplayName','0.51');
set(plot1(5),'DisplayName','0.72');
set(plot1(6),'DisplayName','0.76');
set(plot1(7),'DisplayName','0.88');
set(plot1(8),'DisplayName','1.01');
set(plot1(9),'DisplayName','1.07');
set(plot1(10),'DisplayName','1.27');
set(plot1(11),'DisplayName','1.32');
set(plot1(12),'DisplayName','1.43');
set(plot1(13),'DisplayName','1.52');
set(plot1(14),'DisplayName','1.76');
set(plot1(15),'DisplayName','1.76');
set(plot1(16),'DisplayName','1.79');
set(plot1(17),'DisplayName','2.15');
set(plot1(18),'DisplayName','2.28');

% Create legend
legend1 = legend(axes1,'show');
set(legend1,'YColor',[1 1 1],'XColor',[1 1 1],...
    'Position',[0.909487537887488 -0.000872724578732775 0.093469416386083 1.00333545108005],...
    'FontSize',24);

% Create axes
axes2 = axes('Parent',figure1,'YTick',zeros(1,0),'YAxisLocation','right',...
    'XAxisLocation','top',...
    'Position',[0.158249158249158 0.162642947903431 0.716329966329966 0.724269377382465],...
    'FontSize',30,...
    'Color','none');
%% Uncomment the following line to preserve the X-limits of the axes
% xlim(axes2,[0.2998 29.98]);


% Create textbox
annotation(figure1,'textbox',...
    [0.908177033492824 0.945169712793734 0.10522009569378 0.0509138381201044],...
    'String',{'k (A^{-1})'},...
    'FontSize',25,...
    'FitBoxToText','off',...
    'EdgeColor',[1 1 1],...
    'BackgroundColor',[1 1 1]);


