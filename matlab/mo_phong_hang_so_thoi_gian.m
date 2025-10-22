%% MÔ PHỎNG HẰNG SỐ THỜI GIAN ĐỘNG CƠ
% Phân tích T_a (điện) và T_m (cơ)
% Tác giả: Hệ thống điều khiển máy xúc Huina 1592
% Ngày: 10/2025

clc; clear all; close all;

%% ========== THÔNG SỐ ==========

fprintf('========== HẰNG SỐ THỜI GIAN ==========\n\n');

% Thông số động cơ
R_a = 0.8;              % Điện trở [Ohm]
L_a = 0.0002;           % Độ tự cảm [H] = 0.2 mH
K_e = 0.00557;          % Hằng số EMF [V/(rad/s)]
K_m = 0.0066;           % Hằng số mô men [N.m/A]
J_motor = 0.00005;      % Mô men đà motor [kg.m²]
J_load = 0.0002;        % Mô men đà tải [kg.m²]
B = 0.0001;             % Ma sát [N.m.s/rad]

% Hằng số thời gian
T_a = L_a / R_a;
T_m_no_load = (J_motor * R_a) / (K_e * K_m);
T_m_with_load = ((J_motor + J_load) * R_a) / (K_e * K_m);

fprintf('THÔNG SỐ ĐỘNG CƠ:\n');
fprintf('  R_a = %.2f Ω\n', R_a);
fprintf('  L_a = %.2f mH\n', L_a*1000);
fprintf('  K_e = %.5f V/(rad/s)\n', K_e);
fprintf('  K_m = %.5f N.m/A\n', K_m);
fprintf('  J_motor = %.6f kg.m²\n', J_motor);
fprintf('  J_load = %.6f kg.m²\n', J_load);
fprintf('\n');

fprintf('HẰNG SỐ THỜI GIAN:\n');
fprintf('  T_a (điện): %.3f ms\n', T_a*1000);
fprintf('  T_m (không tải): %.2f ms\n', T_m_no_load*1000);
fprintf('  T_m (có tải): %.1f ms\n', T_m_with_load*1000);
fprintf('  Tỷ lệ T_m/T_a: %.0f lần\n', T_m_with_load/T_a);
fprintf('\n');

%% ========== MÔ PHỎNG 1: ĐÁP ỨNG BƯỚC DÒNG ĐIỆN (T_a) ==========

t_sim = 0.002;  % 2ms
dt = 0.000001;  % 1μs
t1 = 0:dt:t_sim;

U_step = 7.4;  % Bước điện áp
E_a = 3.5;     % Giả sử động cơ đang quay

% Đáp ứng bước lý thuyết
I_final = (U_step - E_a) / R_a;
I_theory = I_final * (1 - exp(-t1/T_a));

% Mô phỏng thực tế
I_real = zeros(size(t1));
I_temp = 0;
for i = 1:length(t1)
    dI_dt = (U_step - R_a * I_temp - E_a) / L_a;
    I_temp = I_temp + dI_dt * dt;
    I_real(i) = I_temp;
end

figure('Name', 'Hằng số thời gian', 'Position', [50, 50, 1400, 900]);

subplot(2, 3, 1);
plot(t1*1000, I_theory, 'b-', 'LineWidth', 2);
hold on;
plot(t1*1000, I_real, 'r--', 'LineWidth', 1.5);
plot([T_a T_a]*1000, [0 I_final], 'k--');
plot([0 t_sim]*1000, [I_final*0.632 I_final*0.632], 'g--');
plot(T_a*1000, I_final*0.632, 'ro', 'MarkerSize', 10);
grid on;
xlabel('Thời gian (ms)');
ylabel('Dòng điện (A)');
title(sprintf('Đáp ứng bước dòng điện (T_a = %.2f ms)', T_a*1000));
legend('Lý thuyết', 'Mô phỏng', 'T_a', '63.2%', 'Location', 'Southeast');

% Annotation
text(T_a*1000, I_final*0.7, sprintf('T_a=%.2fms', T_a*1000), 'FontSize', 9);

%% ========== MÔ PHỎNG 2: ĐÁP ỨNG BƯỚC TỐC ĐỘ (T_m) ==========

t_sim2 = 0.5;  % 500ms
dt2 = 0.0001;
t2 = 0:dt2:t_sim2;

% Không tải
omega_no_load = zeros(size(t2));
omega_temp = 0;
M_em_avg = K_m * 3;  % Mô men trung bình

for i = 1:length(t2)
    d_omega = (M_em_avg - B * omega_temp) / J_motor * dt2;
    omega_temp = omega_temp + d_omega;
    omega_no_load(i) = omega_temp;
end

% Có tải
omega_with_load = zeros(size(t2));
omega_temp = 0;

for i = 1:length(t2)
    d_omega = (M_em_avg - B * omega_temp) / (J_motor + J_load) * dt2;
    omega_temp = omega_temp + d_omega;
    omega_with_load(i) = omega_temp;
end

% Đáp ứng lý thuyết
omega_final_no_load = M_em_avg / B;
omega_final_with_load = M_em_avg / B;
omega_theory_no_load = omega_final_no_load * (1 - exp(-t2/T_m_no_load));
omega_theory_with_load = omega_final_with_load * (1 - exp(-t2/T_m_with_load));

subplot(2, 3, 2);
plot(t2*1000, omega_no_load*60/(2*pi), 'b-', 'LineWidth', 2);
hold on;
plot(t2*1000, omega_with_load*60/(2*pi), 'r-', 'LineWidth', 2);
plot([T_m_no_load T_m_no_load]*1000, [0 max(omega_no_load)*60/(2*pi)], 'b--');
plot([T_m_with_load T_m_with_load]*1000, [0 max(omega_with_load)*60/(2*pi)], 'r--');
grid on;
xlabel('Thời gian (ms)');
ylabel('Tốc độ (rpm)');
title('Đáp ứng bước tốc độ');
legend('Không tải', 'Có tải', sprintf('T_m=%.1fms', T_m_no_load*1000), ...
    sprintf('T_m=%.0fms', T_m_with_load*1000), 'Location', 'Southeast');

%% ========== MÔ PHỎNG 3: SO SÁNH T_a VÀ T_m ==========

subplot(2, 3, 3);
% Vẽ thanh so sánh
bar_data = [T_a*1000, T_m_no_load*1000, T_m_with_load*1000];
bar(bar_data);
grid on;
ylabel('Thời gian (ms)');
title('So sánh hằng số thời gian');
set(gca, 'XTickLabel', {'T_a (điện)', 'T_m (motor)', 'T_m (tải)'});
text(1, T_a*1000+5, sprintf('%.2fms', T_a*1000), 'HorizontalAlignment', 'center');
text(2, T_m_no_load*1000+5, sprintf('%.1fms', T_m_no_load*1000), 'HorizontalAlignment', 'center');
text(3, T_m_with_load*1000+10, sprintf('%.0fms', T_m_with_load*1000), 'HorizontalAlignment', 'center');

%% ========== MÔ PHỎNG 4: ẢNH HƯỞNG CỦA MÔ MEN ĐÀ ==========

subplot(2, 3, 4);
J_values = [0.00005, 0.0001, 0.0002, 0.0005, 0.001];
colors = {'b', 'g', 'r', 'm', 'k'};
hold on;

for i = 1:length(J_values)
    J_test = J_values(i);
    T_m_test = (J_test * R_a) / (K_e * K_m);
    omega_test = omega_final_no_load * (1 - exp(-t2/T_m_test));
    plot(t2*1000, omega_test*60/(2*pi), colors{i}, 'LineWidth', 2);
end

grid on;
xlabel('Thời gian (ms)');
ylabel('Tốc độ (rpm)');
title('Ảnh hưởng của J đến T_m');
legend('J=0.05mg.m²', 'J=0.1mg.m²', 'J=0.2mg.m²', ...
    'J=0.5mg.m²', 'J=1.0mg.m²', 'Location', 'Southeast');

%% ========== MÔ PHỎNG 5: THỜI GIAN TĂNG TỐC ==========

subplot(2, 3, 5);
percent_levels = [63.2, 86.5, 95, 98.2, 99.3];
time_factors = [1, 2, 3, 4, 5];
time_no_load = time_factors * T_m_no_load * 1000;
time_with_load = time_factors * T_m_with_load * 1000;

plot(percent_levels, time_no_load, 'bo-', 'LineWidth', 2, 'MarkerSize', 8);
hold on;
plot(percent_levels, time_with_load, 'rs-', 'LineWidth', 2, 'MarkerSize', 8);
grid on;
xlabel('% Tốc độ đạt được');
ylabel('Thời gian (ms)');
title('Thời gian đạt tốc độ mong muốn');
legend('Không tải', 'Có tải', 'Location', 'Northwest');

% Đánh dấu điểm 95%
idx_95 = find(percent_levels == 95);
plot(95, time_with_load(idx_95), 'ro', 'MarkerSize', 12, 'LineWidth', 2);
text(95, time_with_load(idx_95)+20, sprintf('%.0fms @ 95%%', time_with_load(idx_95)), 'FontSize', 9);

%% ========== MÔ PHỎNG 6: BẢO TỒN NĂNG LƯỢNG ==========

subplot(2, 3, 6);

% Năng lượng tích trong L_a (điện)
t_energy = 0:dt:0.005;
I_energy = I_final * (1 - exp(-t_energy/T_a));
E_magnetic = 0.5 * L_a * I_energy.^2;

% Năng lượng động năng (cơ)
omega_energy = omega_final_with_load * (1 - exp(-t_energy/T_m_with_load));
E_kinetic = 0.5 * (J_motor + J_load) * omega_energy.^2;

plot(t_energy*1000, E_magnetic*1000, 'b-', 'LineWidth', 2);
hold on;
plot(t_energy*1000, E_kinetic*1000, 'r-', 'LineWidth', 2);
grid on;
xlabel('Thời gian (ms)');
ylabel('Năng lượng (mJ)');
title('Năng lượng tích lũy');
legend('E_{từ} = ½LI²', 'E_{động} = ½Jω²', 'Location', 'Southeast');

%% ========== PHÂN TÍCH ==========

fprintf('========== PHÂN TÍCH ==========\n\n');

fprintf('THỜI GIAN ĐÁP ỨNG (Có tải):\n');
fprintf('  t @ 63.2%%: %.1f ms (1×T_m)\n', T_m_with_load*1000);
fprintf('  t @ 86.5%%: %.1f ms (2×T_m)\n', 2*T_m_with_load*1000);
fprintf('  t @ 95.0%%: %.1f ms (3×T_m)\n', 3*T_m_with_load*1000);
fprintf('  t @ 99.3%%: %.1f ms (5×T_m)\n', 5*T_m_with_load*1000);
fprintf('\n');

fprintf('ẢNH HƯỞNG CỦA TẢI:\n');
ratio = T_m_with_load / T_m_no_load;
fprintf('  T_m tăng %.0f lần khi có tải\n', ratio);
fprintf('  Thời gian tăng tốc chậm hơn %.0f%%\n', (ratio-1)*100);
fprintf('\n');

fprintf('THIẾT KẾ BỘ ĐIỀU KHIỂN:\n');
fprintf('  Tần số lấy mẫu đề xuất: %.0f Hz\n', 10/T_m_with_load);
fprintf('  Chu kỳ điều khiển: %.1f ms\n', T_m_with_load*1000/10);
fprintf('  Băng thông hệ thống: %.1f Hz\n', 1/(2*pi*T_m_with_load));
fprintf('\n');

fprintf('KHUYẾN NGHỊ:\n');
fprintf('  - T_a << T_m → Bỏ qua động học điện\n');
fprintf('  - Tải >> Motor → T_m quyết định bởi J_tải\n');
fprintf('  - Thời gian khởi động thực tế: ~%.0fms\n', 3*T_m_with_load*1000);
fprintf('\n');

fprintf('==============================\n');

%% ========== LƯU KẾT QUẢ ==========

saveas(gcf, 'hang_so_thoi_gian.png');
fprintf('\nĐã lưu: hang_so_thoi_gian.png\n');

data.T_a = T_a;
data.T_m_no_load = T_m_no_load;
data.T_m_with_load = T_m_with_load;
data.percent_levels = percent_levels;
data.time_with_load = time_with_load;
save('data_hang_so_thoi_gian.mat', 'data');
fprintf('Đã lưu: data_hang_so_thoi_gian.mat\n');

