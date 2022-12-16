function param = initBar(content, step, start_from)
%INITBAR initialize a new waitbar for myself
%   input: content, the words you want to show in a bar
%          step, how long the step is for every time we display
%          start_from, where you want to start the bar from
%   output: param, you don't need to know the details

if nargin == 2
    start_from = 0;
end
param = struct("bar", waitbar(start_from, content), ...
    "stageNow", start_from, ...
    "stageStep", step);
end

