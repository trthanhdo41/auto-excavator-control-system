# HƯỚNG DẪN SỬ DỤNG

## HỆ THỐNG ĐIỀU KHIỂN MÁY XÚC TỰ ĐỘNG EKG-5A

---

## MỤC LỤC

1. [Yêu cầu hệ thống](#1-yêu-cầu-hệ-thống)
2. [Cấu trúc thư mục](#2-cấu-trúc-thư-mục)
3. [Hướng dẫn sử dụng](#3-hướng-dẫn-sử-dụng)
4. [Câu hỏi thường gặp](#4-câu-hỏi-thường-gặp)
5. [Khắc phục sự cố](#5-khắc-phục-sự-cố)

---

## 1. YÊU CẦU HỆ THỐNG

### Phần mềm cần thiết:

- **MATLAB R2019b trở lên** (khuyến nghị R2021a+)
- Không cần toolbox đặc biệt
- Hệ điều hành: Windows, macOS, Linux

### Kiến thức cần có:

- Cơ bản về MATLAB
- Hiểu biết về máy điện và điều khiển tự động
- Đọc hiểu sơ đồ điện

---

## 2. CẤU TRÚC THƯ MỤC

```
hệ thống điều khiển máy xúc auto/
│
├── README.md                          # Giới thiệu tổng quan
├── HUONG_DAN_SU_DUNG.md              # File này
│
├── calculations/                      # Tính toán chi tiết
│   ├── chuong3_phan1.md              # Tính toán 3.1.1 - 3.1.6
│   └── chuong3_phan2.md              # Tính toán 3.1.7 - 3.1.12
│
├── matlab/                            # Code MATLAB mô phỏng
│   ├── mo_phong_thoi_gian_khuech_dai_tu.m
│   ├── mo_phong_khau_khuech_dai_tu.m
│   ├── mo_phong_khau_may_phat.m
│   └── mo_phong_khau_dong_co.m
│
└── docs/                              # Tài liệu
    └── BAO_CAO_TONG_HOP.md           # Báo cáo tổng hợp
```

---

## 3. HƯỚNG DẪN SỬ DỤNG

### 3.1. Xem tính toán lý thuyết

#### Bước 1: Mở file tính toán
```
Vào thư mục: calculations/
Mở file: chuong3_phan1.md (hoặc phan2)
```

#### Bước 2: Đọc nội dung
- Mỗi phần có công thức chi tiết
- Ví dụ tính toán cụ thể
- Bảng tra cứu giá trị

### 3.2. Chạy mô phỏng MATLAB

#### A. Mô phỏng thời gian khuếch đại từ

**File:** `mo_phong_thoi_gian_khuech_dai_tu.m`

**Cách chạy:**
```matlab
% Mở MATLAB
cd 'matlab/'

% Chạy script
mo_phong_thoi_gian_khuech_dai_tu

% Kết quả:
% - Đồ thị hiển thị trên màn hình
% - File ảnh: mo_phong_thoi_gian_khuech_dai_tu.png
% - File dữ liệu: data_thoi_gian_khuech_dai_tu.mat
```

**Nội dung mô phỏng:**
- Đáp ứng bước cuộn điều khiển
- Đáp ứng bước cuộn công suất
- So sánh thời gian đáp ứng
- Phân tích hằng số thời gian τ

**Thời gian chạy:** ~2-3 giây

**Kết quả mong đợi:**
- Cuộn điều khiển: τ = 5ms
- Cuộn công suất: τ = 100ms
- 6 subplot hiển thị đầy đủ

#### B. Mô phỏng khâu khuếch đại từ

**File:** `mo_phong_khau_khuech_dai_tu.m`

**Cách chạy:**
```matlab
cd 'matlab/'
mo_phong_khau_khuech_dai_tu
```

**Nội dung mô phỏng:**
- Đáp ứng tuyến tính vs phi tuyến
- Đặc tính bão hòa từ
- Đáp ứng tần số (Bode plot)
- Đặc tính tĩnh U_out = f(U_in)

**Thời gian chạy:** ~3-4 giây

**Kết quả mong đợi:**
- 9 subplot
- Đặc tính bão hòa rõ ràng
- Tần số cắt ω_c ≈ 10 rad/s

#### C. Mô phỏng khâu máy phát

**File:** `mo_phong_khau_may_phat.m`

**Cách chạy:**
```matlab
cd 'matlab/'
mo_phong_khau_may_phat
```

**Nội dung mô phỏng:**
- Ảnh hưởng các MMF (F_2, F_1, F_6, F_4)
- Từ thông và sức điện động
- Đặc tính ngoài U = f(I)
- Đặc tính điều chỉnh
- Phân tích công suất

**Thời gian chạy:** ~5-6 giây

**Kết quả mong đợi:**
- 12 subplot
- Điện áp ổn định ở ~220V
- Độ điều áp 8-12%

#### D. Mô phỏng khâu động cơ

**File:** `mo_phong_khau_dong_co.m`

**Cách chạy:**
```matlab
cd 'matlab/'
mo_phong_khau_dong_co
```

**Nội dung mô phỏng:**
- Quá trình khởi động
- Đáp ứng với điện áp và tải thay đổi
- Đặc tính cơ n = f(M)
- Đặc tính n = f(I_a)
- Hiệu suất

**Thời gian chạy:** ~10-15 giây (do dt nhỏ)

**Kết quả mong đợi:**
- 12 subplot
- Tốc độ định mức ~600 rpm
- Hiệu suất 95-97%

### 3.3. Chạy tất cả mô phỏng

**Script tự động (tùy chọn):**

Tạo file `chay_tat_ca.m`:
```matlab
%% Chạy tất cả mô phỏng
clc; clear all; close all;

fprintf('========== CHẠY TẤT CẢ MÔ PHỎNG ==========\n\n');

% 1. Mô phỏng thời gian khuếch đại từ
fprintf('1. Mô phỏng thời gian khuếch đại từ...\n');
mo_phong_thoi_gian_khuech_dai_tu;
pause(2);

% 2. Mô phỏng khâu khuếch đại từ
fprintf('\n2. Mô phỏng khâu khuếch đại từ...\n');
mo_phong_khau_khuech_dai_tu;
pause(2);

% 3. Mô phỏng khâu máy phát
fprintf('\n3. Mô phỏng khâu máy phát...\n');
mo_phong_khau_may_phat;
pause(2);

% 4. Mô phỏng khâu động cơ
fprintf('\n4. Mô phỏng khâu động cơ...\n');
mo_phong_khau_dong_co;

fprintf('\n========== HOÀN THÀNH TẤT CẢ ==========\n');
```

Chạy:
```matlab
chay_tat_ca
```

### 3.4. Xem báo cáo tổng hợp

```
Vào thư mục: docs/
Mở file: BAO_CAO_TONG_HOP.md

Nội dung:
- Giới thiệu và mục tiêu
- Cơ sở lý thuyết
- Tính toán chi tiết
- Kết quả mô phỏng
- Đánh giá và khuyến nghị
```

### 3.5. Tùy chỉnh mô phỏng

#### Thay đổi thông số:

**Ví dụ: Thay đổi điện trở phần ứng động cơ**

Mở file `mo_phong_khau_dong_co.m`, tìm dòng:
```matlab
R_a = 0.035;            % Điện trở phần ứng [Ohm]
```

Thay đổi thành:
```matlab
R_a = 0.050;            % Thử với giá trị khác
```

Chạy lại script và xem sự thay đổi.

#### Thay đổi tín hiệu đầu vào:

**Ví dụ: Thay đổi điện áp máy phát**

Trong `mo_phong_khau_may_phat.m`, tìm:
```matlab
U_2(t >= 0.5 & t < 1.5) = 110;   % 50%
U_2(t >= 1.5 & t < 2.5) = 220;   % 100%
```

Thay đổi theo ý muốn.

#### Thay đổi thời gian mô phỏng:

Tìm dòng:
```matlab
t_sim = 3.0;            % Thời gian mô phỏng [s]
```

Tăng/giảm theo nhu cầu.

---

## 4. CÂU HỎI THƯỜNG GẶP

### Q1: MATLAB báo lỗi "Undefined function or variable"?

**Trả lời:** Đảm bảo đang ở đúng thư mục chứa file .m

```matlab
% Kiểm tra thư mục hiện tại
pwd

% Chuyển đến thư mục đúng
cd '/đường/dẫn/đến/matlab/'

% Hoặc thêm thư mục vào path
addpath('/đường/dẫn/đến/matlab/')
```

### Q2: Đồ thị không hiển thị?

**Trả lời:** 
```matlab
% Đảm bảo không có lệnh close all ở đầu
% Hoặc comment dòng: % close all;

% Kiểm tra figure
figure(1)
```

### Q3: Chạy quá lâu?

**Trả lời:** Giảm thời gian mô phỏng hoặc tăng bước thời gian

```matlab
% Thay vì
t_sim = 5.0;
dt = 0.0001;

% Thử
t_sim = 2.0;
dt = 0.001;
```

### Q4: Muốn lưu kết quả vào Excel?

**Trả lời:** Thêm code sau cuối file:

```matlab
% Tạo bảng dữ liệu
T = table(t', U_in', U_out', ...
    'VariableNames', {'Time', 'U_in', 'U_out'});

% Lưu vào Excel
writetable(T, 'ket_qua.xlsx');
```

### Q5: Làm sao so sánh kết quả với lý thuyết?

**Trả lời:** Xem file tính toán trong `calculations/` và so sánh giá trị.

Ví dụ:
- Lý thuyết: U_out = 220V @ U_in = 10V
- Mô phỏng: Xem giá trị cuối đồ thị

### Q6: Code có chạy được trên Octave không?

**Trả lời:** Có, nhưng cần chỉnh sửa nhỏ:
- Thay `sprintf` trong title bằng chuỗi đơn giản
- Một số hàm plot có thể khác nhau

### Q7: Muốn xuất video animation?

**Trả lời:** Sử dụng VideoWriter:

```matlab
v = VideoWriter('mo_phong.avi');
open(v);

for i = 1:length(t)
    % Vẽ frame
    plot(t(1:i), U_out(1:i));
    drawnow;
    
    % Capture frame
    frame = getframe(gcf);
    writeVideo(v, frame);
end

close(v);
```

---

## 5. KHẮC PHỤC SỰ CỐ

### Sự cố 1: Warning về singular matrix

**Nguyên nhân:** Thông số không hợp lý (R = 0, L = 0, etc.)

**Giải pháp:**
- Kiểm tra lại các thông số
- Đảm bảo không có giá trị 0 ở mẫu số

### Sự cố 2: Kết quả không ổn định (oscillation)

**Nguyên nhân:** Bước thời gian dt quá lớn

**Giải pháp:**
```matlab
dt = 0.0001;  % Giảm bước thời gian
```

### Sự cố 3: Out of memory

**Nguyên nhân:** Thời gian mô phỏng quá dài với dt quá nhỏ

**Giải pháp:**
```matlab
% Giảm thời gian hoặc tăng dt
t_sim = 2.0;
dt = 0.001;
```

### Sự cố 4: Đồ thị bị méo

**Nguyên nhân:** Dữ liệu có NaN hoặc Inf

**Giải pháp:**
```matlab
% Kiểm tra dữ liệu
any(isnan(U_out))
any(isinf(U_out))

% Loại bỏ
U_out(isnan(U_out)) = 0;
U_out(isinf(U_out)) = 0;
```

### Sự cố 5: Không lưu được file

**Nguyên nhân:** Không có quyền ghi

**Giải pháp:**
```matlab
% Chuyển sang thư mục có quyền ghi
cd('~/Desktop/')
saveas(gcf, 'hinh_anh.png');
```

---

## 6. MẸO VÀ THỦ THUẬT

### Mẹo 1: Zoom vào vùng quan tâm

```matlab
% Sau khi plot
xlim([0.5 1.0]);  % Zoom vùng 0.5-1.0s
ylim([0 250]);    % Giới hạn trục y
```

### Mẹo 2: So sánh nhiều trường hợp

```matlab
% Chạy với R_a = 0.035
R_a1 = 0.035;
% ... mô phỏng
U_out_1 = U_out;

% Chạy với R_a = 0.050
R_a2 = 0.050;
% ... mô phỏng
U_out_2 = U_out;

% So sánh
figure;
plot(t, U_out_1, 'b-', t, U_out_2, 'r--');
legend('R_a = 0.035', 'R_a = 0.050');
```

### Mẹo 3: Xuất dữ liệu để vẽ bằng Python

```matlab
% Lưu vào CSV
csvwrite('du_lieu.csv', [t', U_out']);
```

Trong Python:
```python
import pandas as pd
import matplotlib.pyplot as plt

data = pd.read_csv('du_lieu.csv')
plt.plot(data.iloc[:, 0], data.iloc[:, 1])
plt.show()
```

### Mẹo 4: In báo cáo PDF

```matlab
% Sau khi có tất cả figure
figHandles = findall(0, 'Type', 'figure');
for i = 1:length(figHandles)
    figure(figHandles(i));
    print('-dpdf', sprintf('figure_%d.pdf', i));
end
```

### Mẹo 5: Debug khi kết quả sai

```matlab
% Thêm điểm dừng
keyboard

% Hoặc in giá trị
fprintf('U_out tại t=1s: %.2f V\n', U_out(find(t>=1, 1)));
```

---

## 7. HỖ TRỢ

### Liên hệ:

- **Email:** [địa chỉ email]
- **GitHub:** [link repository]
- **Documentation:** Xem file `docs/BAO_CAO_TONG_HOP.md`

### Báo lỗi:

Nếu phát hiện lỗi, vui lòng báo cáo với thông tin:
1. File nào bị lỗi
2. Thông báo lỗi (copy toàn bộ)
3. Phiên bản MATLAB
4. Hệ điều hành

---

## 8. CẬP NHẬT VÀ BẢN QUYỀN

### Phiên bản:
- **v1.0** - Tháng 10/2025: Phiên bản đầu tiên

### Bản quyền:
- Mã nguồn mở cho mục đích học tập và nghiên cứu
- Trích dẫn khi sử dụng trong công trình khoa học

### Đóng góp:
Chào mừng mọi đóng góp để cải thiện dự án!

---

**Chúc các bạn sử dụng thành công! 🚜⚡**

