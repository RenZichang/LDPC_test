clear; clc; close all;
%% 初始化
% LDPC编译码结构初始化
H = load(".\private\H.mat").H_matrix;
[Gp, N, K] = genCoding(H);
% 迭代初始化
import myWaitBar.*;
my_bar = initBar("仿真中...", 0.05);
test_times = 1e2;
% 系统仿真参数
snr_dBs = -0:0.2:2;
snr_lins = 10 .^ (snr_dBs / 10);
noise_powers = 1 ./ snr_lins;
% 结果展示变量
sers = zeros(size(snr_dBs));
%% 循环多次仿真
for iter_test = 1:test_times
    for iter_snr = 1:numel(snr_dBs)
        % 更新进度条
        my_bar = renewBar(my_bar, [iter_snr, iter_test], [numel(snr_dBs), test_times]);
        % 产生比特、编码、调制加噪、软比特译码
        tx_bits = randi([0, 1], 1, K);
        tx_code = [tx_bits, mod(tx_bits * Gp, 2)];
        rx_llrs = 2 * snr_lins(iter_snr) * ((1 - 2 * tx_code) + ...
            randn(size(tx_code)) * noise_powers(iter_snr));
        rx_code = softDecode(rx_llrs, H);
        rx_bits = rx_code(1:K);
        % 更新误符号率
        sers(iter_snr) = [iter_test - 1, 1] / iter_test * ...
            [sers(iter_snr); double(0 < sum(abs(rx_bits-tx_bits), 'all'))];
    end
end
closeBar(my_bar);
%% 仿真结果展示
% figure(); subplot(111);
% % 分别展示编码误符号率和无编码误符号率
% ncode_bers = qfunc(snr_lins);
% ncode_sers = 1 - (1 - ncode_bers) .^ K;
% semilogy( ...
%     snr_dBs, sers, 'r-x', ...
%     snr_dBs, ncode_sers, 'b-.');
% % 绘图收尾工作
% legend("有编码", "无编码");
% grid on;

figure(); subplot(111);
semilogy(snr_dBs, sers, 'r-x');
grid on;
