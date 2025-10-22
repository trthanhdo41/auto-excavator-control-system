# HỆ THỐNG ĐIỀU KHIỂN MÁY XÚC TỰ ĐỘNG HUINA 1592

## Giới thiệu
Dự án nghiên cứu hệ thống điều khiển tự động cho máy xúc Huina 1592, bao gồm các phần tính toán thông số, mô phỏng MATLAB và báo cáo chi tiết.

## Cấu trúc thư mục

```
├── calculations/          # Các file tính toán chi tiết
│   ├── chuong3_phan1.md  # Tính toán 3.1.1 - 3.1.6
│   └── chuong3_phan2.md  # Tính toán 3.1.7 - 3.1.12
├── matlab/                # Code MATLAB mô phỏng
│   ├── mo_phong_thoi_gian_khuech_dai_tu.m
│   ├── mo_phong_khau_khuech_dai_tu.m
│   ├── mo_phong_khau_may_phat.m
│   └── mo_phong_khau_dong_co.m
├── docs/                  # Tài liệu và báo cáo
│   └── bao_cao_tong_hop.pdf
└── README.md              # File này
```

## Nội dung chính

### Chương 3: Nghiên cứu hệ thống TĐĐ cơ cấu nâng hạ của máy xúc

#### 3.1 Xác định các thông số:
- 3.1.1 - Xác định hệ số Kᵢᵢ
- 3.1.2 - Xác định hằng số thời gian của các cuộn dây trong khuếch đại từ kép ПДД-1,5B
- 3.1.3 - Xác định diện áp ra của khuếch đại từ ở trạng thái ổn định
- 3.1.4 - Xác định sức từ động của cuộn dây điều khiển YCM-2 (F₂)
- 3.1.5 - Xác định sức từ động của cuộn YCM-1 (F₁)
- 3.1.6 - Xác định sức từ động của cuộn YCM-6 (F₆)
- 3.1.7 - Xác định sức từ động của cuộn YCM-4 (F₆)
- 3.1.8 - Xác định tham số Eₒd của máy phát nâng hạ gầu
- 3.1.9 - Xác định sức từ động kích thích độc lập (F_ĐL)
- 3.1.10 - Xác định sức từ động trong mạch kích thích song song (F_KTSS)
- 3.1.11 - Xác định hằng số thời gian của máy phát T_F
- 3.1.12 - Xác định tham số của động cơ nâng hạ gầu

#### 3.3 Nghiên cứu thành lập các mô hình:
1. Sơ đồ cấu trúc MATLAB mô phỏng thời gian khuếch đại từ
2. Sơ đồ cấu trúc MATLAB mô phỏng khâu khuếch đại từ
3. Sơ đồ cấu trúc MATLAB mô phỏng khâu máy phát
4. Sơ đồ cấu trúc MATLAB mô phỏng khâu động cơ

## Hướng dẫn sử dụng

### 1. Xem các tính toán
Mở các file trong thư mục `calculations/` để xem công thức và kết quả tính toán chi tiết.

### 2. Chạy mô phỏng MATLAB
```matlab
cd matlab/
% Chạy từng file mô phỏng
mo_phong_thoi_gian_khuech_dai_tu
mo_phong_khau_khuech_dai_tu
mo_phong_khau_may_phat
mo_phong_khau_dong_co
```

### 3. Xem báo cáo tổng hợp
Mở file `docs/bao_cao_tong_hop.pdf`

## Tài liệu tham khảo
- Tài liệu máy xúc Huina 1592
- TERA: Terrain Excavation Robot Autonomy (https://droneslab.github.io/tera/)
- Các papers về autonomous excavator

## Tác giả
Dự án nghiên cứu hệ thống điều khiển máy xúc tự động

## Ngày hoàn thành
Tháng 10/2025

