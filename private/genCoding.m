function [Gp, N, K] = genCoding(H)
%LDPCCODING 根据校验矩阵H计算生成矩阵的校验部分Gp
%   暂无

N = size(H, 2);
K = N - size(H, 1);
Hs = H(:, 1:K);
Hp = H(:, end-N+K+1:end);
Gp = mod((Hp \ Hs).', 2);
end

