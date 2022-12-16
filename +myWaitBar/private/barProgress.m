function progress = barProgress(iter_s, bound_s)
%BARGPROGRESS return a progress speed number for waitbar
%   input: iter_s, iteration pointers, from small to big
%          bound_s, iteration bounds, must be positive integers
%   output: progress, progress speed

progress = 0;
for i = 1:numel(iter_s)
    progress = (iter_s(i) - 1 + progress) / bound_s(i);
end
end

