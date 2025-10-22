# HỆ THỐNG ĐIỀU KHIỂN MÁY XÚC TỰ ĐỘNG HUINA 1592

## 📋 Giới thiệu

Dự án nghiên cứu hệ thống điều khiển tự động cho **máy xúc RC Huina 1592** (tỉ lệ 1:14), bao gồm:
- Tính toán thông số động cơ 540/550 Brushed DC
- Thiết kế mạch điều khiển PWM và ESC
- Mô phỏng MATLAB
- Hướng dẫn thực nghiệm

## 🎯 Mục tiêu

- Nghiên cứu và tính toán thông số động cơ DC trong máy xúc RC
- Thiết kế hệ thống điều khiển PWM cho động cơ
- Mô phỏng và kiểm chứng lý thuyết bằng MATLAB
- Cung cấp hướng dẫn thực nghiệm chi tiết

## 📁 Cấu trúc thư mục

```
hệ thống điều khiển máy xúc auto/
│
├── README.md                          # File này
├── GIOI_THIEU_HUINA_1592.md          # Giới thiệu chi tiết Huina 1592
├── HUONG_DAN_SU_DUNG.md              # Hướng dẫn sử dụng
│
├── calculations/                      # Tính toán chi tiết
│   ├── chuong3_phan1.md              # Thông số động cơ (R_a, K_e, K_m, T_m)
│   └── chuong3_phan2.md              # Điều khiển PWM và ESC
│
├── matlab/                            # Code MATLAB mô phỏng
│   ├── mo_phong_khau_dong_co.m       # Mô phỏng động cơ 540/550
│   └── mo_phong_dieu_khien_pwm.m     # Mô phỏng điều khiển PWM
│
└── docs/                              # Tài liệu
    └── BAO_CAO_TONG_HOP.md           # Báo cáo tổng hợp
```

## 🚀 Nội dung chính

### 📖 Chương 3.1: Xác định thông số động cơ

**Phần 1: Thông số cơ bản** (`calculations/chuong3_phan1.md`)
- 3.1.1 - Điện trở phần ứng (R_a = 0.8Ω)
- 3.1.2 - Hằng số EMF (K_e = 0.00557 V/(rad/s))
- 3.1.3 - Hằng số mô men (K_m = 0.0066 N.m/A)
- 3.1.4 - Hằng số thời gian điện (T_a = 0.25 ms)
- 3.1.5 - Hằng số thời gian cơ (T_m = 117 ms)
- 3.1.6 - Đặc tính cơ động cơ (n = f(M))

**Phần 2: Điều khiển PWM** (`calculations/chuong3_phan2.md`)
- 3.2.1 - Nguyên lý điều khiển PWM (10-20 kHz)
- 3.2.2 - ESC (Electronic Speed Controller)
- 3.2.3 - Mạch cầu H (H-Bridge với MOSFET)
- 3.2.4 - Tính toán mạch điều khiển PWM
- 3.2.5 - Lập trình Arduino (code thực tế)
- 3.2.6 - Bảo vệ và an toàn

### 💻 Mô phỏng MATLAB

**1. Mô phỏng động cơ** (`mo_phong_khau_dong_co.m`)
- Đáp ứng với điện áp 3.7V, 7.4V
- Đặc tính cơ n = f(M)
- Hiệu suất động cơ
- Thời gian đáp ứng

**2. Mô phỏng PWM** (`mo_phong_dieu_khien_pwm.m`)
- Điều khiển với Duty Cycle khác nhau
- Dòng gợn sóng
- Hiệu suất hệ thống
- Tín hiệu PWM chi tiết

## ⚡ Bắt đầu nhanh

### 1. Xem tính toán lý thuyết

```bash
# Xem thông số động cơ
cat calculations/chuong3_phan1.md

# Xem điều khiển PWM
cat calculations/chuong3_phan2.md
```

### 2. Chạy mô phỏng MATLAB

```matlab
% Mở MATLAB và chuyển đến thư mục matlab/
cd matlab/

% Mô phỏng động cơ
mo_phong_khau_dong_co

% Mô phỏng PWM
mo_phong_dieu_khien_pwm
```

**Yêu cầu:**
- MATLAB R2019b trở lên
- Không cần toolbox đặc biệt

### 3. Thực nghiệm

Xem file `HUONG_DAN_SU_DUNG.md` để biết:
- Cách đo thông số động cơ thực tế
- Lập trình Arduino
- Kết nối mạch
- Troubleshooting

## 📊 Thông số kỹ thuật Huina 1592

| Thông số | Giá trị | Đơn vị |
|----------|---------|--------|
| **Nguồn điện** | 7.4V (2S Li-ion) | V |
| **Loại động cơ** | 540/550 Brushed DC | - |
| **Công suất động cơ** | 20-50 | W |
| **Dòng định mức** | 3-5 | A |
| **Tốc độ không tải** | 12000 | rpm |
| **Tốc độ có tải** | 8000 | rpm |
| **Điện trở R_a** | 0.8 | Ω |
| **Hằng số K_e** | 0.00557 | V/(rad/s) |
| **Hằng số K_m** | 0.0066 | N.m/A |
| **PWM tần số** | 10-20 | kHz |

## 🔧 Hardware cần thiết (cho thực nghiệm)

- **Máy xúc Huina 1592**: ~3-5 triệu VNĐ
- **Arduino Uno/Nano**: ~150k VNĐ
- **L298N H-Bridge Module**: ~50k VNĐ
- **Cảm biến dòng ACS712**: ~30k VNĐ
- **Pin 7.4V 2S Li-ion**: ~200k VNĐ
- **Đồng hồ vạn năng**: ~300k VNĐ

**Tổng:** ~4-5 triệu VNĐ

## 📚 Tài liệu tham khảo

1. **Huina Official**: [huina-toys.com](https://www.huina-toys.com/)
2. **TERA Framework**: [droneslab.github.io/tera](https://droneslab.github.io/tera/)
3. **Arduino PWM**: [arduino.cc/reference](https://www.arduino.cc/reference/en/)
4. **Papers**:
   - Autonomous Excavation
   - Reinforcement Learning for Excavator Control
   - Vision-based Digging

## 🤝 Đóng góp

Chào mừng mọi đóng góp để cải thiện dự án!

1. Fork repository
2. Tạo branch mới (`git checkout -b feature/AmazingFeature`)
3. Commit changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to branch (`git push origin feature/AmazingFeature`)
5. Tạo Pull Request

## 📝 License

Mã nguồn mở cho mục đích học tập và nghiên cứu.

## 👥 Tác giả

Dự án nghiên cứu hệ thống điều khiển máy xúc tự động - Tháng 10/2025

## 📧 Liên hệ

- **GitHub**: [trthanhdo41/auto-excavator-control-system](https://github.com/trthanhdo41/auto-excavator-control-system)
- **Issues**: Báo lỗi tại GitHub Issues

## 🌟 Star History

Nếu thấy dự án hữu ích, hãy cho một ⭐ trên GitHub!

---

**Chúc các bạn thành công với dự án! 🚜⚡**
