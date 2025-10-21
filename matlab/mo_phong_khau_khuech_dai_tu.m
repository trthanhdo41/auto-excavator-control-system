%% MÔ PHỎNG KHÂU KHUẾCH ĐẠI TỪ
% Mô phỏng sơ đồ cấu trúc MATLAB khâu khuếch đại từ ПДД-1,5B
% Tác giả: Hệ thống điều khiển máy xúc EKG-5A
% Ngày: 10/2025

clc; clear all; close all;

%% ========== THÔNG SỐ KHÂU KHUẾCH ĐẠI TỪ ==========

% Thông số khuếch đại từ
K_u = 22;               % Hệ số khuếch đại điện áp
tau_KDT = 0.1;          % Hằng số thời gian tổng hợp [s] (100 ms)
U_max = 240;            % Điện áp bão hòa [V]
U_offset = 15;          % Điện áp lệch (từ dư) [V]

% Thông số phi tuyến (bão hòa từ)
k_sat = 0.95;           % Hệ số bão hòa (0.9-1.0)

% Tín hiệu đầu vào
t_sim = 2.0;            % Thời gian mô phỏng [s]
dt = 0.001;             % Bước thời gian [s]
t = 0:dt:t_sim;         % Vector thời gian

%% ========== TẠO TÍN HIỆU ĐẦU VÀO ==========

% Tín hiệu bước nhảy ở nhiều mức
U_in = zeros(size(t));
U_in(t >= 0.0 & t < 0.5) = 0;
U_in(t >= 0.5 & t < 1.0) = 5;
U_in(t >= 1.0 & t < 1.5) = 8;
U_in(t >= 1.5) = 10;

%% ========== HIỂN THỊ THÔNG SỐ ==========

fprintf('========== THÔNG SỐ KHÂU KHUẾCH ĐẠI TỪ ==========\n');
fprintf('Hệ số khuếch đại K_u: %.0f\n', K_u);
fprintf('Hằng số thời gian τ: %.3f s = %.0f ms\n', tau_KDT, tau_KDT*1000);
fprintf('Điện áp bão hòa U_max: %.0f V\n', U_max);
fprintf('Điện áp lệch U_offset: %.0f V\n', U_offset);
fprintf('Hệ số bão hòa k_sat: %.2f\n', k_sat);
fprintf('==================================================\n\n');

%% ========== MÔ PHỎNG KHÂU TUYẾN TÍNH ==========

% Hàm truyền: G(s) = K_u / (tau*s + 1)
% Đáp ứng: du/dt = (K_u*U_in - u) / tau

U_out_linear = zeros(size(t));
u_temp = U_offset;  % Điều kiện đầu

for i = 1:length(t)
    % Phương trình vi phân bậc 1
    du_dt = (K_u * U_in(i) + U_offset - u_temp) / tau_KDT;
    u_temp = u_temp + du_dt * dt;
    U_out_linear(i) = u_temp;
end

%% ========== MÔ PHỎNG KHÂU PHI TUYẾN (CÓ BÃO HÒA) ==========

U_out_nonlinear = zeros(size(t));
u_temp = U_offset;

for i = 1:length(t)
    % Tính điện áp tuyến tính
    U_linear = K_u * U_in(i) + U_offset;
    
    % Áp dụng đặc tính bão hòa (hàm tanh)
    U_target = U_max * tanh(k_sat * U_linear / U_max);
    
    % Phương trình vi phân với bão hòa
    du_dt = (U_target - u_temp) / tau_KDT;
    u_temp = u_temp + du_dt * dt;
    U_out_nonlinear(i) = u_temp;
end

%% ========== TÍNH TOÁN ĐẶC TÍNH TĨNH ==========

% Đặc tính tĩnh (static characteristic)
U_in_static = 0:0.1:12;
U_out_static_ideal = K_u * U_in_static + U_offset;
U_out_static_saturation = U_max * tanh(k_sat * U_out_static_ideal / U_max);

%% ========== VẼ ĐỒ THỊ ==========

figure('Name', 'Mô phỏng khâu khuếch đại từ', 'Position', [100, 100, 1400, 900]);

% Subplot 1: Tín hiệu đầu vào
subplot(3, 3, 1);
plot(t, U_in, 'b-', 'LineWidth', 2);
grid on;
xlabel('Thời gian (s)');
ylabel('Điện áp (V)');
title('Tín hiệu đầu vào U_{in}');
ylim([-1 12]);

% Subplot 2: Đáp ứng tuyến tính
subplot(3, 3, 2);
plot(t, U_out_linear, 'r-', 'LineWidth', 2);
hold on;
plot(t, K_u*U_in + U_offset, 'k--', 'LineWidth', 1);
grid on;
xlabel('Thời gian (s)');
ylabel('Điện áp (V)');
title('Đáp ứng tuyến tính (lý tưởng)');
legend('U_{out} thực tế', 'U_{out} xác lập', 'Location', 'Southeast');
ylim([0 250]);

% Subplot 3: Đáp ứng phi tuyến (có bão hòa)
subplot(3, 3, 3);
plot(t, U_out_nonlinear, 'g-', 'LineWidth', 2);
hold on;
plot([0 t_sim], [U_max U_max], 'r--', 'LineWidth', 1.5);
grid on;
xlabel('Thời gian (s)');
ylabel('Điện áp (V)');
title('Đáp ứng phi tuyến (có bão hòa)');
legend('U_{out}', sprintf('U_{max} = %d V', U_max), 'Location', 'Southeast');
ylim([0 250]);

% Subplot 4: So sánh tuyến tính và phi tuyến
subplot(3, 3, 4);
plot(t, U_out_linear, 'r-', 'LineWidth', 2);
hold on;
plot(t, U_out_nonlinear, 'g-', 'LineWidth', 2);
plot([0 t_sim], [U_max U_max], 'k--', 'LineWidth', 1);
grid on;
xlabel('Thời gian (s)');
ylabel('Điện áp (V)');
title('So sánh tuyến tính vs phi tuyến');
legend('Tuyến tính', 'Phi tuyến (bão hòa)', 'Giới hạn', 'Location', 'Southeast');
ylim([0 260]);

% Subplot 5: Đặc tính tĩnh
subplot(3, 3, 5);
plot(U_in_static, U_out_static_ideal, 'b--', 'LineWidth', 1.5);
hold on;
plot(U_in_static, U_out_static_saturation, 'r-', 'LineWidth', 2);
plot([0 12], [U_max U_max], 'k--', 'LineWidth', 1);
grid on;
xlabel('U_{in} (V)');
ylabel('U_{out} (V)');
title('Đặc tính tĩnh U_{out} = f(U_{in})');
legend('Lý tưởng', 'Có bão hòa', 'U_{max}', 'Location', 'Southeast');

% Subplot 6: Zoom vào thời điểm chuyển đổi
subplot(3, 3, 6);
idx = find(t >= 0.45 & t <= 0.65);
plot(t(idx), U_in(idx)*20, 'b-', 'LineWidth', 1.5);
hold on;
plot(t(idx), U_out_nonlinear(idx), 'g-', 'LineWidth', 2);
grid on;
xlabel('Thời gian (s)');
ylabel('Điện áp (V)');
title('Chi tiết quá trình quá độ (t = 0.5s)');
legend('U_{in} × 20', 'U_{out}', 'Location', 'Southeast');

% Subplot 7: Hàm truyền tần số - Biên độ
subplot(3, 3, 7);
omega = logspace(-2, 2, 1000);  % Tần số góc [rad/s]
H = K_u ./ sqrt(1 + (omega * tau_KDT).^2);
semilogx(omega, 20*log10(H), 'b-', 'LineWidth', 2);
hold on;
omega_c = 1 / tau_KDT;
plot([omega_c omega_c], [-40 30], 'r--', 'LineWidth', 1.5);
grid on;
xlabel('Tần số góc ω (rad/s)');
ylabel('Biên độ (dB)');
title('Đáp ứng tần số - Biên độ');
legend('|G(jω)|', sprintf('ω_c = %.2f rad/s', omega_c), 'Location', 'Southwest');

% Subplot 8: Hàm truyền tần số - Pha
subplot(3, 3, 8);
phase = -atan(omega * tau_KDT) * 180 / pi;
semilogx(omega, phase, 'r-', 'LineWidth', 2);
hold on;
plot([omega_c omega_c], [-90 0], 'k--', 'LineWidth', 1.5);
grid on;
xlabel('Tần số góc ω (rad/s)');
ylabel('Pha (độ)');
title('Đáp ứng tần số - Pha');
legend('∠G(jω)', 'ω_c', 'Location', 'Southwest');
ylim([-95 5]);

% Subplot 9: Bảng thông tin
subplot(3, 3, 9);
axis off;

% Tính toán một số chỉ số
settling_time = 5 * tau_KDT;  % Thời gian xác lập 99%
rise_time = 2.2 * tau_KDT;    % Thời gian tăng 10%-90%
bandwidth = 1 / tau_KDT;       % Băng thông

str_info = {
    'THÔNG SỐ HỆ THỐNG:'
    ' '
    'Hàm truyền:'
    sprintf('  G(s) = %d / (%.3fs + 1)', K_u, tau_KDT)
    ' '
    'Đặc tính động:'
    sprintf('  Thời gian tăng: %.3f s', rise_time)
    sprintf('  Thời gian xác lập: %.3f s', settling_time)
    sprintf('  Không có vọt lố')
    ' '
    'Đáp ứng tần số:'
    sprintf('  Tần số cắt: %.2f rad/s', bandwidth)
    sprintf('  Băng thông: %.2f rad/s', bandwidth)
    ' '
    'Giới hạn:'
    sprintf('  U_out max: %.0f V', U_max)
    sprintf('  U_in max: %.0f V', 10)
    ' '
    'Trạng thái bão hòa:'
    sprintf('  Bắt đầu: U_in ≈ %.1f V', (U_max-U_offset)/K_u*0.8)
    sprintf('  Hoàn toàn: U_in ≈ %.1f V', (U_max-U_offset)/K_u*1.2)
};
text(0.05, 0.95, str_info, 'VerticalAlignment', 'top', 'FontSize', 9, 'FontName', 'Courier');

%% ========== PHÂN TÍCH KẾT QUẢ ==========

fprintf('========== KẾT QUẢ MÔ PHỎNG ==========\n\n');

fprintf('ĐẶC TÍNH ĐỘNG:\n');
fprintf('  Thời gian tăng (10%%-90%%): %.3f s\n', rise_time);
fprintf('  Thời gian xác lập (99%%): %.3f s\n', settling_time);
fprintf('  Vọt lố: 0%% (hệ bậc 1)\n');

fprintf('\nĐÁP ỨNG TẦN SỐ:\n');
fprintf('  Tần số cắt ω_c: %.2f rad/s = %.2f Hz\n', bandwidth, bandwidth/(2*pi));
fprintf('  Pha tại ω_c: -45°\n');

fprintf('\nĐẶC TÍNH BÃO HÒA:\n');
fprintf('  U_in < %.1f V: Vùng tuyến tính\n', (U_max-U_offset)/K_u*0.8);
fprintf('  U_in = %.1f - %.1f V: Bắt đầu bão hòa\n', (U_max-U_offset)/K_u*0.8, (U_max-U_offset)/K_u*1.2);
fprintf('  U_in > %.1f V: Bão hòa hoàn toàn\n', (U_max-U_offset)/K_u*1.2);

fprintf('\nGIÁ TRỊ ĐIỆN ÁP TẠI CÁC THỜI ĐIỂM:\n');
idx_05s = find(t >= 0.5, 1);
idx_10s = find(t >= 1.0, 1);
idx_15s = find(t >= 1.5, 1);
fprintf('  t = 0.5s: U_in = %.0f V → U_out = %.1f V\n', U_in(idx_05s), U_out_nonlinear(idx_05s));
fprintf('  t = 1.0s: U_in = %.0f V → U_out = %.1f V\n', U_in(idx_10s), U_out_nonlinear(idx_10s));
fprintf('  t = 1.5s: U_in = %.0f V → U_out = %.1f V\n', U_in(idx_15s), U_out_nonlinear(idx_15s));

fprintf('\n======================================\n');

%% ========== LƯU KẾT QUẢ ==========

saveas(gcf, 'mo_phong_khau_khuech_dai_tu.png');
fprintf('\nĐã lưu đồ thị vào file: mo_phong_khau_khuech_dai_tu.png\n');

save('data_khau_khuech_dai_tu.mat', 't', 'U_in', 'U_out_linear', 'U_out_nonlinear', ...
     'K_u', 'tau_KDT', 'U_max', 'U_offset');
fprintf('Đã lưu dữ liệu vào file: data_khau_khuech_dai_tu.mat\n');

fprintf('\n========== HOÀN THÀNH MÔ PHỎNG ==========\n');

