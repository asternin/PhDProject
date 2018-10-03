% to view SART data.

%load data
load('_GreenMyEyes_SARTdata.mat')
%calculate correct/incorrect - add a column?
for r=1: length(data)
    if data(r,1) == 3 && data(r,2) == 0; %correct inhibition
        data(r,5) = 1;
    elseif data(r,1) ~= 3 && data(r,2) == 1; %correct button push
        data(r,5) = 1;
    else
        data(r,5) = 0; %incorrect response
    end
end

%plot
figure;
scatter(data(:,3),data(:,5))