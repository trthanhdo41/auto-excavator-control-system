%% CHẠY TẤT CẢ MÔ PHỎNG
% Script tự động chạy tất cả các mô phỏng cho Huina 1592
% Tác giả: Hệ thống điều khiển máy xúc Huina 1592
% Ngày: 10/2025

clc; clear all;

fprintf('\n');
fprintf('╔════════════════════════════════════════════════════════╗\n');
fprintf('║   HỆ THỐNG ĐIỀU KHIỂN MÁY XÚC HUINA 1592              ║\n');
fprintf('║   CHẠY TẤT CẢ MÔ PHỎNG                                ║\n');
fprintf('╚════════════════════════════════════════════════════════╝\n');
fprintf('\n');

%% Danh sách mô phỏng
scripts = {
    'mo_phong_khau_dong_co.m', 'Mô phỏng động cơ 540/550'
    'mo_phong_dieu_khien_pwm.m', 'Điều khiển PWM'
    'mo_phong_dac_tinh_co.m', 'Đặc tính cơ'
    'mo_phong_hang_so_thoi_gian.m', 'Hằng số thời gian'
    'mo_phong_hieu_suat.m', 'Phân tích hiệu suất'
};

n_scripts = size(scripts, 1);
success_count = 0;
failed_scripts = {};

%% Chạy từng script
for i = 1:n_scripts
    script_name = scripts{i, 1};
    script_desc = scripts{i, 2};
    
    fprintf('──────────────────────────────────────────────────────────\n');
    fprintf('[%d/%d] %s\n', i, n_scripts, script_desc);
    fprintf('File: %s\n', script_name);
    fprintf('──────────────────────────────────────────────────────────\n');
    
    try
        % Đóng tất cả figure trước khi chạy
        close all;
        
        % Chạy script
        tic;
        run(script_name);
        elapsed = toc;
        
        fprintf('✓ Hoàn thành trong %.2f giây\n', elapsed);
        fprintf('\n');
        success_count = success_count + 1;
        
        % Đợi 2 giây để xem kết quả
        pause(2);
        
    catch ME
        fprintf('✗ LỖI: %s\n', ME.message);
        fprintf('   File: %s\n', ME.stack(1).file);
        fprintf('   Dòng: %d\n', ME.stack(1).line);
        fprintf('\n');
        failed_scripts{end+1} = script_name;
    end
end

%% Tổng kết
fprintf('\n');
fprintf('╔════════════════════════════════════════════════════════╗\n');
fprintf('║   KẾT QUẢ                                              ║\n');
fprintf('╚════════════════════════════════════════════════════════╝\n');
fprintf('\n');
fprintf('Tổng số script: %d\n', n_scripts);
fprintf('Thành công: %d\n', success_count);
fprintf('Thất bại: %d\n', length(failed_scripts));
fprintf('\n');

if isempty(failed_scripts)
    fprintf('🎉 TẤT CẢ MÔ PHỎNG CHẠY THÀNH CÔNG!\n');
else
    fprintf('⚠️  CÁC SCRIPT THẤT BẠI:\n');
    for i = 1:length(failed_scripts)
        fprintf('  %d. %s\n', i, failed_scripts{i});
    end
end

fprintf('\n');
fprintf('File đồ thị đã được lưu trong thư mục hiện tại.\n');
fprintf('File dữ liệu .mat có thể dùng để phân tích thêm.\n');
fprintf('\n');

%% Hiển thị danh sách figure
fig_handles = findall(0, 'Type', 'figure');
if ~isempty(fig_handles)
    fprintf('Số lượng figure đã tạo: %d\n', length(fig_handles));
    fprintf('\n');
    fprintf('Mẹo: Dùng "close all" để đóng tất cả figure.\n');
end

fprintf('\n');
fprintf('══════════════════════════════════════════════════════════\n');
fprintf('            HOÀN THÀNH TẤT CẢ MÔ PHỎNG\n');
fprintf('══════════════════════════════════════════════════════════\n');
fprintf('\n');

