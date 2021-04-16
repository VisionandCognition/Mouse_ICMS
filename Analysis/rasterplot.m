function [fig_raster] = rasterplot(trl_time,event_matrix)
%PLOT THE RASTER PLOT OF AN EVENT MATRIX
%
%   Input:   trl_time - time axis with the unit of seconds
%            event_matrix - event matrix in trial-by-time
%   Output:  fig_raster - figure handle of the raster plot
%
%   created by B. Li on 2021.04.14

fig_raster = figure;
hold on;
for i = 1:size(event_matrix,1)
    plot(trl_time, event_matrix(i,:)*i, '.k','MarkerSize', 10);
end
xlabel('Time(s)');
ylabel('Trial#');

end

