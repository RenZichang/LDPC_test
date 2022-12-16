function dc = softDecode(c, H)
%SOFTDECODE 传入LDPC编码c和H矩阵，返回软译码结果
%   暂无

% 初始化
N_K = size(H, 1);
edge_inds = find(H);
L_V2F = zeros(size(H)).';
L_F2V = zeros(size(H));
L_V = c;
% 开始软译码
iter_time = 0;
while (sum(mod(H * L_V.', 2)) ~= 0) && (iter_time < 30)
    iter_time = iter_time + 1;
    % 从变量到校验的似然更新，只遍历存在的边
    for iter_edge = 1:numel(edge_inds)
        % 获取变量节点编号j和校验方程编号i
        j = ceil(edge_inds(iter_edge) / N_K);
        i = mod(edge_inds(iter_edge) - 1, N_K) + 1;
        % 似然更新
        L_V2F(j, i) = c(j) + sum(L_F2V(1:end~=i, j), 'all');
    end
    % 从校验到变量的似然更新，只遍历存在的边
    for iter_edge = 1:numel(edge_inds)
        % 获取变量节点编号j和校验方程编号i
        j = ceil(edge_inds(iter_edge) / N_K);
        i = mod(edge_inds(iter_edge) - 1, N_K) + 1;
        % 似然更新（连乘式中需要保证不存在0、且不能包括V_j）
        L_F2V(i, j) = 2 * atanh(prod(tanh(L_V2F(H(i, 1:end)==1, i) / 2), 'all') / tanh(L_V2F(j, i) / 2));
    end
    % 计算变量节点置信度
    L_V = c + sum(L_F2V, 1);
end
dc = (1 - sign(L_V)) / 2;
end

