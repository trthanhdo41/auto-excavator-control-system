%% MÔ PHỎNG ĐÁP ỨNG THỜI GIAN HỆ THỐNG
% Script mô phỏng thời gian đáp ứng của hệ thống điều khiển PWM
% Tác giả: Hệ thống điều khiển máy xúc Huina 1592
% Ngày: 10/2025

clc; clear all; close all;

%% ========== THÔNG SỐ KHUẾCH ĐẠI TỪ ==========

% Cuộn điều khiển (Control Winding)
L_control = 1.5;        % Độ tự cảm [H]
R_control = 300;        % Điện trở [Ohm]
tau_control = L_control / R_control;  % Hằng số thời gian [s]

% Cuộn công suất (Power Winding)
L_power = 10;           % Độ tự cảm [H]
R_power = 100;          % Điện trở [Ohm]
tau_power = L_power / R_power;        % Hằng số thời gian [s]

% Hệ số khuếch đại
K_u = 22;               % Hệ số khuếch đại điện áp
K_i = 100;              % Hệ số khuếch đại dòng điện
K_p = K_u * K_i;        % Hệ số khuếch đại công suất

% Tín hiệu đầu vào
U_in_max = 10;          % Điện áp đầu vào tối đa [V]
U_in_step = 5;          % Bước nhảy điện áp vào [V]

% Thời gian mô phỏng
t_sim = 0.5;            % Thời gian mô phỏng [s]
dt = 0.0001;            % Bước thời gian [s]
t = 0:dt:t_sim;         % Vector thời gian

%% ========== HIỂN THỊ THÔNG SỐ ==========

fprintf('========== THÔNG SỐ KHUẾCH ĐẠI TỪ ПДД-1,5B ==========\n');
fprintf('CUỘN ĐIỀU KHIỂN:\n');
fprintf('  Độ tự cảm L_control = %.2f H\n', L_control);
fprintf('  Điện trở R_control = %.0f Ohm\n', R_control);
fprintf('  Hằng số thời gian τ_control = %.3f s = %.1f ms\n', tau_control, tau_control*1000);
fprintf('\n');
fprintf('CUỘN CÔNG SUẤT:\n');
fprintf('  Độ tự cảm L_power = %.2f H\n', L_power);
fprintf('  Điện trở R_power = %.0f Ohm\n', R_power);
fprintf('  Hằng số thời gian τ_power = %.3f s = %.1f ms\n', tau_power, tau_power*1000);
fprintf('\n');
fprintf('HỆ SỐ KHUẾCH ĐẠI:\n');
fprintf('  K_u (điện áp) = %.0f\n', K_u);
fprintf('  K_i (dòng điện) = %.0f\n', K_i);
fprintf('  K_p (công suất) = %.0f\n', K_p);
fprintf('======================================================\n\n');

%% ========== MÔ PHỎNG ĐÁP ỨNG CUỘN ĐIỀU KHIỂN ==========

% Tín hiệu đầu vào bước nhảy
U_in = U_in_step * ones(size(t));

% Đáp ứng bước của cuộn điều khiển
I_control = (U_in_step / R_control) * (1 - exp(-t / tau_control));

% Thời gian đạt các mốc
t_63_control = tau_control;
t_95_control = 3 * tau_control;
t_99_control = 5 * tau_control;

%% ========== MÔ PHỎNG ĐÁP ỨNG CUỘN CÔNG SUẤT ==========

% Đáp ứng bước của cuộn công suất
I_power = (U_in_step / R_power) * (1 - exp(-t / tau_power));

% Thời gian đạt các mốc
t_63_power = tau_power;
t_95_power = 3 * tau_power;
t_99_power = 5 * tau_power;

%% ========== ĐÁP ỨNG ĐIỆN ÁP RA ==========

% Điện áp ra (chỉ xét đáp ứng cuộn điều khiển)
U_offset = 15;  % Điện áp lệch do từ dư [V]
U_out = K_u * U_in_step * (1 - exp(-t / tau_control)) + U_offset;

%% ========== VẼ ĐỒ THỊ ==========

% Tạo figure
figure('Name', 'Mô phỏng thời gian khuếch đại từ', 'Position', [100, 100, 1200, 800]);

% Subplot 1: Tín hiệu đầu vào
subplot(3, 2, 1);
plot(t*1000, U_in, 'b-', 'LineWidth', 2);
grid on;
xlabel('Thời gian (ms)');
ylabel('Điện áp (V)');
title('Tín hiệu đầu vào U_{in}');
ylim([0 U_in_step*1.2]);

% Subplot 2: Đáp ứng cuộn điều khiển
subplot(3, 2, 2);
plot(t*1000, I_control, 'r-', 'LineWidth', 2);
hold on;
I_ss_control = U_in_step / R_control;
plot([0 t_sim*1000], [0.632*I_ss_control 0.632*I_ss_control], 'k--', 'LineWidth', 1);
plot([t_63_control*1000 t_63_control*1000], [0 I_ss_control*1.1], 'g--', 'LineWidth', 1);
plot([0 t_sim*1000], [0.95*I_ss_control 0.95*I_ss_control], 'k--', 'LineWidth', 1);
plot([t_95_control*1000 t_95_control*1000], [0 I_ss_control*1.1], 'm--', 'LineWidth', 1);
grid on;
xlabel('Thời gian (ms)');
ylabel('Dòng điện (A)');
title(sprintf('Đáp ứng cuộn điều khiển (τ = %.1f ms)', tau_control*1000));
legend('I_{control}', '63.2% I_{ss}', sprintf('τ = %.1f ms', tau_control*1000), ...
       '95% I_{ss}', sprintf('3τ = %.1f ms', t_95_control*1000), 'Location', 'Southeast');

% Subplot 3: Đáp ứng cuộn công suất
subplot(3, 2, 3);
plot(t*1000, I_power, 'b-', 'LineWidth', 2);
hold on;
I_ss_power = U_in_step / R_power;
plot([0 t_sim*1000], [0.632*I_ss_power 0.632*I_ss_power], 'k--', 'LineWidth', 1);
plot([t_63_power*1000 t_63_power*1000], [0 I_ss_power*1.1], 'g--', 'LineWidth', 1);
plot([0 t_sim*1000], [0.95*I_ss_power 0.95*I_ss_power], 'k--', 'LineWidth', 1);
plot([t_95_power*1000 t_95_power*1000], [0 I_ss_power*1.1], 'm--', 'LineWidth', 1);
grid on;
xlabel('Thời gian (ms)');
ylabel('Dòng điện (A)');
title(sprintf('Đáp ứng cuộn công suất (τ = %.1f ms)', tau_power*1000));
legend('I_{power}', '63.2% I_{ss}', sprintf('τ = %.1f ms', tau_power*1000), ...
       '95% I_{ss}', sprintf('3τ = %.1f ms', t_95_power*1000), 'Location', 'Southeast');

% Subplot 4: So sánh hai cuộn
subplot(3, 2, 4);
plot(t*1000, I_control/I_ss_control*100, 'r-', 'LineWidth', 2);
hold on;
plot(t*1000, I_power/I_ss_power*100, 'b-', 'LineWidth', 2);
plot([0 t_sim*1000], [63.2 63.2], 'k--', 'LineWidth', 1);
plot([0 t_sim*1000], [95 95], 'k--', 'LineWidth', 1);
grid on;
xlabel('Thời gian (ms)');
ylabel('Phần trăm giá trị xác lập (%)');
title('So sánh đáp ứng hai cuộn');
legend('Cuộn điều khiển', 'Cuộn công suất', '63.2%', '95%', 'Location', 'Southeast');
ylim([0 105]);

% Subplot 5: Điện áp đầu ra
subplot(3, 2, 5);
plot(t*1000, U_out, 'g-', 'LineWidth', 2);
hold on;
U_ss = K_u * U_in_step + U_offset;
plot([0 t_sim*1000], [U_ss U_ss], 'k--', 'LineWidth', 1);
plot([0 t_sim*1000], [0.95*U_ss 0.95*U_ss], 'r--', 'LineWidth', 1);
grid on;
xlabel('Thời gian (ms)');
ylabel('Điện áp (V)');
title('Điện áp đầu ra U_{out}');
legend('U_{out}', sprintf('U_{ss} = %.1f V', U_ss), '95% U_{ss}', 'Location', 'Southeast');

% Subplot 6: Bảng thông tin
subplot(3, 2, 6);
axis off;
str_info = {
    'KẾT QUẢ MÔ PHỎNG:'
    ' '
    'CUỘN ĐIỀU KHIỂN:'
    sprintf('  Dòng xác lập: %.3f A', I_ss_control)
    sprintf('  Thời gian τ: %.1f ms', tau_control*1000)
    sprintf('  Thời gian 3τ (95%%): %.1f ms', t_95_control*1000)
    sprintf('  Thời gian 5τ (99%%): %.1f ms', t_99_control*1000)
    ' '
    'CUỘN CÔNG SUẤT:'
    sprintf('  Dòng xác lập: %.3f A', I_ss_power)
    sprintf('  Thời gian τ: %.1f ms', tau_power*1000)
    sprintf('  Thời gian 3τ (95%%): %.1f ms', t_95_power*1000)
    sprintf('  Thời gian 5τ (99%%): %.1f ms', t_99_power*1000)
    ' '
    'ĐIỆN ÁP ĐẦU RA:'
    sprintf('  Điện áp xác lập: %.1f V', U_ss)
    sprintf('  Hệ số khuếch đại: %.0f', K_u)
    ' '
    'KẾT LUẬN:'
    sprintf('  Cuộn ĐK nhanh hơn %.0fx', tau_power/tau_control)
};
text(0.1, 0.9, str_info, 'VerticalAlignment', 'top', 'FontSize', 9, 'FontName', 'Courier');

%% ========== PHÂN TÍCH BỔ SUNG ==========

fprintf('========== KẾT QUẢ MÔ PHỎNG ==========\n');
fprintf('\nCUỘN ĐIỀU KHIỂN:\n');
fprintf('  Dòng xác lập: %.4f A\n', I_ss_control);
fprintf('  Thời gian đạt 63.2%%: %.3f ms\n', t_63_control*1000);
fprintf('  Thời gian đạt 95%%: %.3f ms\n', t_95_control*1000);
fprintf('  Thời gian đạt 99%%: %.3f ms\n', t_99_control*1000);

fprintf('\nCUỘN CÔNG SUẤT:\n');
fprintf('  Dòng xác lập: %.4f A\n', I_ss_power);
fprintf('  Thời gian đạt 63.2%%: %.3f ms\n', t_63_power*1000);
fprintf('  Thời gian đạt 95%%: %.3f ms\n', t_95_power*1000);
fprintf('  Thời gian đạt 99%%: %.3f ms\n', t_99_power*1000);

fprintf('\nĐIỆN ÁP ĐẦU RA:\n');
fprintf('  Điện áp xác lập: %.2f V\n', U_ss);
fprintf('  Thời gian đáp ứng (95%%): %.3f ms\n', t_95_control*1000);

fprintf('\nSO SÁNH:\n');
fprintf('  Cuộn điều khiển nhanh hơn cuộn công suất: %.1f lần\n', tau_power/tau_control);

fprintf('\n======================================\n');

%% ========== LƯU KẾT QUẢ ==========

% Lưu hình ảnh
saveas(gcf, 'mo_phong_thoi_gian_khuech_dai_tu.png');
fprintf('\nĐã lưu đồ thị vào file: mo_phong_thoi_gian_khuech_dai_tu.png\n');

% Lưu dữ liệu
save('data_thoi_gian_khuech_dai_tu.mat', 't', 'U_in', 'I_control', 'I_power', 'U_out', ...
     'tau_control', 'tau_power', 'K_u', 'K_i', 'K_p');
fprintf('Đã lưu dữ liệu vào file: data_thoi_gian_khuech_dai_tu.mat\n');

fprintf('\n========== HOÀN THÀNH MÔ PHỎNG ==========\n');

