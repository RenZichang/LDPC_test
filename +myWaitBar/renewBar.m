function new_param = renewBar(param, pts, bounds)
%RENEWBAR renew the parameters of current waitbar
%   input: param, the key values passed between each functions
%          pts, pointers from inner to outer
%          bounds, bounds of these pointers
%   output: new_params, new values

new_param = param;
stageNew = round(barProgress(pts, bounds) / param.stageStep);
if stageNew ~= param.stageNow
    waitbar(param.stageNow * param.stageStep, param.bar);
    new_param.stageNow = stageNew;
end
end

