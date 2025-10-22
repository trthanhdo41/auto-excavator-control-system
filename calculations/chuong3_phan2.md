# CHƯƠNG 3 - PHẦN 2: XÁC ĐỊNH CÁC THÔNG SỐ (3.1.7 - 3.1.12)

## 3.1.7 - Xác định sức từ động của cuộn YCM-4 (F₄)

### Khái niệm
Cuộn YCM-4 là cuộn bù (compensation winding), dùng để bù trừ phản ứng phần ứng và cải thiện đặc tính của máy phát.

**GIẢI THÍCH CHI TIẾT:**

Cuộn YCM-4 có vai trò đặc biệt quan trọng trong việc cải thiện đặc tính của máy phát DC. Nó được thiết kế để bù trừ hiệu ứng phản ứng phần ứng, một hiện tượng vật lý quan trọng trong máy điện.

**Ý nghĩa vật lý:**
- Khi máy phát có tải, dòng điện phần ứng tạo ra từ trường riêng
- Từ trường này làm méo dạng từ trường chính của cuộn kích từ
- Cuộn YCM-4 tạo ra từ trường ngược lại để bù trừ hiệu ứng này

**Nguyên lý phản ứng phần ứng:**
```
Dòng điện phần ứng → Từ trường phần ứng → Méo từ trường chính → Giảm điện áp máy phát
```

**Cơ chế bù trừ:**
```
Cuộn YCM-4 → Từ trường bù → Khôi phục từ trường chính → Ổn định điện áp máy phát
```

**Đặc điểm thiết kế:**
- Số vòng dây ít (20-80 vòng) nhưng dây dẫn lớn
- Mắc nối tiếp với phần ứng để phản ánh dòng tải
- Điện trở rất nhỏ để không ảnh hưởng đến hiệu suất

### Công thức tính:

**1. Công thức cơ bản:**
```
F₄ = N₄ × I₄
```

**GIẢI THÍCH TỪNG KÝ HIỆU:**
- `F₄`: Sức từ động cuộn YCM-4 (At)
- `N₄`: Số vòng dây cuộn YCM-4 (vòng)
- `I₄`: Dòng điện qua cuộn YCM-4 (A)

**2. Quan hệ với dòng tải:**
```
I₄ = I_phần_ứng = I_tải
```

**GIẢI THÍCH TỪNG KÝ HIỆU:**
- `I_phần_ứng`: Dòng điện phần ứng máy phát (A)
- `I_tải`: Dòng điện tải của máy phát (A)

**CƠ SỞ VẬT LÝ:**
Cuộn YCM-4 được mắc nối tiếp với phần ứng nên dòng điện qua nó chính là dòng điện tải. Điều này đảm bảo cuộn bù hoạt động tỷ lệ với mức độ phản ứng phần ứng.

**VÍ DỤ TÍNH TOÁN TỪNG BƯỚC:**

**Ví dụ 1: Không tải**
```
Cho: I_tải = 0 A
     N₄ = 50 vòng

Bước 1: Tính dòng điện YCM-4
I₄ = I_tải = 0 A

Bước 2: Tính sức từ động
F₄ = N₄ × I₄ = 50 × 0 = 0 At

Bước 3: Ý nghĩa
Không tải → Không có phản ứng phần ứng → Không cần bù trừ
```

**Ví dụ 2: Tải 50A**
```
Cho: N₄ = 50 vòng
     I₄ = I_tải = 50 A

Bước 1: Áp dụng công thức cơ bản
F₄ = N₄ × I₄

Bước 2: Thay số
F₄ = 50 × 50 = 2500 At

Bước 3: Phân tích hiệu quả
F₄ = 2500 At đủ để bù trừ phản ứng phần ứng ở tải 50A
```

**Ví dụ 3: Tải định mức**
```
Cho: N₄ = 50 vòng
     I₄ = I_tải = 350 A (định mức)

Bước 1: Tính sức từ động
F₄ = N₄ × I₄ = 50 × 350 = 17500 At

Bước 2: So sánh với các cuộn khác
F₄ = 17500 At >> F₂ = 1000 At
→ Cuộn bù có sức từ động rất lớn

Bước 3: Đánh giá hiệu quả
F₄ lớn đảm bảo bù trừ hoàn toàn phản ứng phần ứng
```

**KIỂM TRA KẾT QUẢ:**
- F₄ tỷ lệ thuận với I_tải
- F₄ = 0 khi không tải (hợp lý)
- F₄ rất lớn khi tải đầy (cần thiết để bù trừ)

**ÁP DỤNG THỰC TẾ:**
- **Thiết kế:** Chọn N₄ để có F₄ đủ bù trừ phản ứng phần ứng
- **Điều chỉnh:** Thay đổi N₄ để tối ưu đặc tính điều áp
- **Kiểm tra:** Đo điện áp máy phát để đánh giá hiệu quả bù trừ
- **Bảo trì:** F₄ không đúng có thể do hỏng cuộn dây hoặc mạch nối tiếp

### Thông số cuộn YCM-4:

**Thông số điển hình:**
- Số vòng dây: N₄ = 20 - 80 vòng (ít vòng, dây dẫn lớn)
- Dòng điện: I₄ = I_tải = 0 - 100 A
- Tiết diện dây: 10-25 mm²
- Điện trở: R₄ = 0.01 - 0.05 Ω (rất nhỏ)

### Tính toán cụ thể:

**Ví dụ 1: Không tải**
```
I_tải = 0 A
=> I₄ = 0 A
=> F₄ = 0 At
```

**Ví dụ 2: Tải 50A**
```
Cho: N₄ = 50 vòng
     I₄ = 50 A

F₄ = 50 × 50 = 2500 At
```

**Ví dụ 3: Tải định mức 100A**
```
Cho: N₄ = 50 vòng
     I₄ = 100 A

F₄ = 50 × 100 = 5000 At
```

### Quan hệ tuyến tính:

```
F₄ = N₄ × I_tải = K_F4 × I_tải
```

Trong đó: K_F4 = N₄ (At/A)

### Ví dụ tính K_F4:

```
Cho: N₄ = 50 vòng

K_F4 = 50 At/A

Khi I_tải = 80A:
F₄ = 50 × 80 = 4000 At
```

### Đặc tính F₄ theo dòng tải:

| I_tải (A) | F₄ (At) | % F_max |
|-----------|---------|---------|
| 0 | 0 | 0% |
| 20 | 1000 | 20% |
| 40 | 2000 | 40% |
| 60 | 3000 | 60% |
| 80 | 4000 | 80% |
| 100 | 5000 | 100% |

### Vai trò của cuộn YCM-4:

**1. Bù phản ứng phần ứng:**
Khi máy phát có tải, dòng điện phần ứng tạo ra từ trường làm méo dạng từ trường chính. Cuộn YCM-4 tạo MMF ngược lại để bù trừ.

**2. Cải thiện đặc tính điều áp:**
```
ΔU% = (U₀ - U_tải) / U_định_mức × 100%
```

Không có YCM-4: ΔU% = 15-25%
Có YCM-4: ΔU% = 5-10%

**3. Tăng khả năng quá tải:**
Cho phép máy phát chịu quá tải 120-150% trong thời gian ngắn.

### Phản ứng phần ứng và bù trừ:

**Không có cuộn bù:**
```
Φ_tổng = Φ_kích_từ - Φ_phản_ứng
```

**Có cuộn bù:**
```
Φ_tổng = Φ_kích_từ - Φ_phản_ứng + Φ_bù
Φ_bù ≈ Φ_phản_ứng
=> Φ_tổng ≈ Φ_kích_từ (ổn định)
```

### Tính toán MMF phản ứng phần ứng:

```
F_phản_ứng = K_phản_ứng × I_tải × p
```

Trong đó:
- K_phản_ứng: hệ số phản ứng (thường 0.5-0.8)
- p: số đôi cực của máy

**Ví dụ:**
```
Cho: I_tải = 100A
     p = 2 (4 cực)
     K_phản_ứng = 0.6
     N_phần_ứng = 40 vòng/cực

F_phản_ứng = 0.6 × 100 × 40 = 2400 At

Cuộn bù cần: F₄ ≥ 2400 At
Chọn N₄ = 50 vòng:
F₄ = 50 × 100 = 5000 At > 2400 At ✓
```

### Đặc tính với và không có cuộn bù:

```
U (V)
  |
220|●___________  Có cuộn bù YCM-4
   | \
200|  \
   |   \●______  Không có cuộn bù
180|    \
   |     \
   |      \
   |_______\_____ I (A)
   0   50   100
```

### Tổn thất công suất trên YCM-4:

```
P_loss = I₄² × R₄
```

**Ví dụ:**
```
Cho: I₄ = 100A
     R₄ = 0.03 Ω

P_loss = 100² × 0.03 = 300W
```

### Ý nghĩa:
- F₄ tỷ lệ thuận với dòng tải
- Bù trừ phản ứng phần ứng
- Cải thiện đặc tính điều áp của máy phát
- Quan trọng cho hoạt động ổn định

---

## 3.1.8 - Xác định tham số E_od của máy phát nâng hạ gầu

### Khái niệm
E_od (Electromotive force at open circuit - Sức điện động không tải) là điện áp sinh ra ở đầu cực máy phát khi không có tải.

**GIẢI THÍCH CHI TIẾT:**

E_od là một tham số cơ bản và quan trọng nhất của máy phát DC. Nó đặc trưng cho khả năng phát điện của máy phát khi hoạt động ở chế độ không tải.

**Ý nghĩa vật lý:**
- E_od là điện áp tối đa mà máy phát có thể sinh ra
- Phụ thuộc vào từ thông kích từ và tốc độ quay
- Là cơ sở để tính toán điện áp làm việc của máy phát

**Nguyên lý hoạt động:**
```
Từ thông kích từ → Cảm ứng điện từ → Sức điện động E_od → Điện áp đầu ra
```

**Đặc điểm quan trọng:**
- E_od tỷ lệ thuận với từ thông và tốc độ quay
- Không phụ thuộc vào dòng tải (chế độ không tải)
- Là tham số chuẩn để đánh giá chất lượng máy phát

**Ứng dụng thực tế:**
- Thiết kế máy phát: Chọn từ thông và tốc độ để có E_od mong muốn
- Điều khiển: Thay đổi từ thông để điều chỉnh E_od
- Kiểm tra: Đo E_od để đánh giá tình trạng máy phát

### Công thức tính:

**1. Công thức cơ bản:**
```
E_od = C_e × Φ × n
```

**GIẢI THÍCH TỪNG KÝ HIỆU:**
- `E_od`: Sức điện động không tải (V)
- `C_e`: Hằng số cấu tạo máy phát (V.min/Wb.vòng)
- `Φ`: Từ thông kích từ (Wb)
- `n`: Tốc độ quay (rpm)

**2. Công thức chi tiết:**
```
E_od = (p × Z × Φ × n) / (60 × a)
```

**GIẢI THÍCH TỪNG KÝ HIỆU:**
- `p`: Số đôi cực (không đơn vị)
- `Z`: Tổng số thanh dẫn phần ứng (thanh)
- `a`: Số đường nhánh song song (không đơn vị)
- `n`: Tốc độ quay (rpm)
- `Φ`: Từ thông mỗi cực (Wb)

**CƠ SỞ VẬT LÝ:**
Công thức này xuất phát từ định luật Faraday về cảm ứng điện từ:
```
E = -N × (dΦ/dt)
```
Trong máy phát DC, từ thông thay đổi theo thời gian do sự quay của phần ứng.

**VÍ DỤ TÍNH TOÁN TỪNG BƯỚC:**

**Ví dụ 1: Tính từ thông số cơ bản**
```
Cho: C_e = 8 V.min/Wb.vòng
     Φ = 0.0198 Wb
     n = 1500 rpm

Bước 1: Áp dụng công thức cơ bản
E_od = C_e × Φ × n

Bước 2: Thay số
E_od = 8 × 0.0198 × 1500 = 237.6 V

Bước 3: Kiểm tra kết quả
E_od = 237.6 V hợp lý cho máy phát 220V
```

**Ví dụ 2: Tính từ thông số chi tiết**
```
Cho: p = 2 (4 cực)
     Z = 480 thanh dẫn
     a = 2 nhánh song song
     Φ = 0.0198 Wb
     n = 1500 rpm

Bước 1: Tính hằng số C_e
C_e = (p × Z) / (60 × a) = (2 × 480) / (60 × 2) = 8 V.min/Wb.vòng

Bước 2: Tính E_od
E_od = C_e × Φ × n = 8 × 0.0198 × 1500 = 237.6 V

Bước 3: So sánh với ví dụ 1
Kết quả giống nhau ✓
```

**Ví dụ 3: Tính với tốc độ khác**
```
Cho: C_e = 8 V.min/Wb.vòng
     Φ = 0.0198 Wb
     n = 1800 rpm (tăng tốc độ)

Bước 1: Tính E_od
E_od = C_e × Φ × n = 8 × 0.0198 × 1800 = 285.1 V

Bước 2: So sánh với tốc độ định mức
E_od_1800 = 285.1 V > E_od_1500 = 237.6 V
→ Tăng tốc độ 20% → Tăng E_od 20%
```

**KIỂM TRA KẾT QUẢ:**
- E_od tỷ lệ thuận với Φ và n
- E_od > U_định_mức (cần thiết để bù điện áp rơi)
- Giá trị hợp lý cho máy phát công nghiệp

**ÁP DỤNG THỰC TẾ:**
- **Thiết kế:** Chọn Φ và n để có E_od phù hợp với U_định_mức
- **Điều khiển:** Thay đổi từ thông để điều chỉnh E_od
- **Kiểm tra:** Đo E_od để đánh giá tình trạng máy phát
- **Bảo trì:** E_od giảm có thể do giảm từ thông hoặc tốc độ quay

### Đơn giản hóa:

```
C_e = (p × Z) / (60 × a)

=> E_od = C_e × Φ × n
```

### Thông số hệ thống nâng hạ gầu Huina 1592:

**Lưu ý:** Huina 1592 là máy xúc RC tỉ lệ 1:14, sử dụng động cơ DC và xi lanh thủy lực nhỏ.

| Thông số | Ký hiệu | Giá trị | Đơn vị |
|----------|---------|---------|--------|
| Nguồn điện | U_nguồn | 7.4 - 11.1 | V |
| Công suất động cơ | P | 20 - 50 | W |
| Điện áp làm việc | U_đm | 7.4 | V |
| Dòng định mức | I_đm | 3 - 5 | A |
| Tốc độ | n | 3000 - 6000 | rpm |
| Loại động cơ | - | 540/550 Brushed DC | - |
| Pin | - | 7.4V 2S Li-ion | - |

### Tính hằng số C_e:

```
C_e = (p × Z) / (60 × a)
C_e = (2 × 480) / (60 × 2)
C_e = 960 / 120
C_e = 8 V.min/Wb.vòng
```

### Tính từ thông Φ:

**Từ điều kiện định mức:**
```
E_od = U_đm + I_đm × (R_phần_ứng + R_chổi_than)

Giả sử: R_tổng ≈ 0.05 Ω
E_od = 220 + 350 × 0.05 = 237.5 V
```

**Từ công thức E_od:**
```
Φ = E_od / (C_e × n)
Φ = 237.5 / (8 × 1500)
Φ = 237.5 / 12000
Φ = 0.0198 Wb ≈ 19.8 mWb
```

### Quan hệ E_od với từ thông kích từ:

```
E_od = K_Φ × Φ = K_Φ × f(F_kích_từ)
```

Trong đó:
```
F_kích_từ = F₂ - F₁ + F₆ (± F₄)
```

### Đặc tính từ hóa E_od = f(F):

**Vùng tuyến tính (không bão hòa):**
```
E_od = K_tuyến_tính × F_kích_từ
```

**Vùng bão hòa:**
```
E_od = E_max × tanh(F_kích_từ / F_bão_hòa)
```

### Bảng đặc tính từ hóa:

| F_kích_từ (At) | Φ (mWb) | E_od (V) | Ghi chú |
|----------------|---------|----------|---------|
| 0 | 0 | 0 | Không kích từ |
| 500 | 10 | 120 | Vùng tuyến tính |
| 1000 | 19.8 | 237 | Định mức |
| 1500 | 25 | 300 | Bắt đầu bão hòa |
| 2000 | 28 | 336 | Bão hòa |
| 2500 | 29.5 | 354 | Bão hòa sâu |

### Đồ thị đặc tính từ hóa:

```
E_od (V)
   |
350|        ●---●  Vùng bão hòa
   |      /
300|     /●
   |    /
237|   ●  Định mức
   |  /
120| ●  Vùng tuyến tính
   | /
  0|●_____________ F (At)
   0  500 1000 1500 2000
```

### Ảnh hưởng của tốc độ:

```
E_od ∝ n

n = 1500 rpm => E_od = 237V
n = 1800 rpm => E_od = 237 × (1800/1500) = 284V
n = 1200 rpm => E_od = 237 × (1200/1500) = 190V
```

### Ảnh hưởng của nhiệt độ:

Điện trở tăng theo nhiệt độ:
```
R_t = R₂₀ × [1 + α(t - 20)]

α_đồng ≈ 0.004 /°C
```

**Ví dụ:**
```
R₂₀ = 0.05 Ω (ở 20°C)
t = 80°C

R₈₀ = 0.05 × [1 + 0.004 × (80 - 20)]
R₈₀ = 0.05 × 1.24 = 0.062 Ω

Điện áp rơi tăng:
ΔU = 350 × (0.062 - 0.05) = 4.2V
```

### Công thức thực tế tính E_od:

```
E_od = U_tải + I_tải × R_tổng + 2 × U_chổi_than
```

Trong đó:
- U_chổi_than ≈ 1V/chổi than (thường có 2 chổi)

**Ví dụ tính toán:**
```
U_tải = 220V
I_tải = 300A
R_tổng = 0.05 Ω

E_od = 220 + 300 × 0.05 + 2 × 1
E_od = 220 + 15 + 2 = 237V
```

### Ý nghĩa:
- E_od đặc trưng cho khả năng phát điện của máy phát
- E_od tỷ lệ với từ thông và tốc độ quay
- Cần xác định chính xác để tính toán điều khiển
- Quan trọng cho việc ổn định điện áp đầu ra

---

## 3.1.9 - Xác định sức từ động kích thích độc lập (F_ĐL)

### Khái niệm
F_ĐL là sức từ động của cuộn kích từ độc lập, cấp nguồn kích từ từ nguồn ngoài độc lập với tải.

**GIẢI THÍCH CHI TIẾT:**

Sức từ động kích thích độc lập F_ĐL là một thành phần quan trọng trong hệ thống kích từ máy phát DC. Nó đảm bảo máy phát luôn có từ thông cơ bản để hoạt động ổn định.

**Ý nghĩa vật lý:**
- F_ĐL tạo ra từ thông cố định, không phụ thuộc vào tải
- Cung cấp từ thông nền để máy phát có thể tự kích từ
- Đảm bảo máy phát luôn có từ thông tối thiểu để hoạt động

**Nguyên lý hoạt động:**
```
Nguồn DC độc lập → Cuộn kích từ độc lập → Từ thông cố định → Điện áp máy phát cơ bản
```

**Đặc điểm quan trọng:**
- Độc lập với mạch điều khiển chính
- Không thay đổi theo tải
- Có thể điều chỉnh thủ công để tối ưu hệ thống
- Quan trọng cho quá trình khởi động máy phát

**So sánh với kích từ song song:**
- Kích từ độc lập: Ổn định, dễ điều khiển, cần nguồn riêng
- Kích từ song song: Đơn giản, rẻ tiền, nhưng kém ổn định

### Công thức tính:

**1. Công thức cơ bản:**
```
F_ĐL = N_ĐL × I_ĐL
```

**GIẢI THÍCH TỪNG KÝ HIỆU:**
- `F_ĐL`: Sức từ động kích thích độc lập (At)
- `N_ĐL`: Số vòng dây cuộn kích từ độc lập (vòng)
- `I_ĐL`: Dòng điện kích từ độc lập (A)

**2. Quan hệ với nguồn cấp:**
```
I_ĐL = U_kích_từ / R_kích_từ
```

**GIẢI THÍCH TỪNG KÝ HIỆU:**
- `U_kích_từ`: Điện áp cấp cho cuộn kích từ (V)
- `R_kích_từ`: Điện trở cuộn kích từ (Ω)

**CƠ SỞ VẬT LÝ:**
Cuộn kích từ độc lập được cấp nguồn từ nguồn DC độc lập, thường là máy phát phụ hoặc chỉnh lưu riêng. Dòng điện qua cuộn này không đổi và không phụ thuộc vào tải của máy phát chính.

**VÍ DỤ TÍNH TOÁN TỪNG BƯỚC:**

**Ví dụ 1: Tính từ thông số định mức**
```
Cho: N_ĐL = 1200 vòng
     U_kích_từ = 220V DC
     R_kích_từ = 55 Ω

Bước 1: Tính dòng điện theo định luật Ohm
I_ĐL = U_kích_từ / R_kích_từ = 220 / 55 = 4.0 A

Bước 2: Tính sức từ động
F_ĐL = N_ĐL × I_ĐL = 1200 × 4.0 = 4800 At

Bước 3: Ý nghĩa
F_ĐL = 4800 At cung cấp từ thông cơ bản cho máy phát
```

**Ví dụ 2: Tính với điện áp khác**
```
Cho: N_ĐL = 1200 vòng
     U_kích_từ = 110V DC (50% điện áp)
     R_kích_từ = 55 Ω

Bước 1: Tính dòng điện
I_ĐL = U_kích_từ / R_kích_từ = 110 / 55 = 2.0 A

Bước 2: Tính sức từ động
F_ĐL = N_ĐL × I_ĐL = 1200 × 2.0 = 2400 At

Bước 3: So sánh với định mức
F_ĐL_50% = 2400 At = 50% × F_ĐL_định_mức
```

**Ví dụ 3: Tính với điện trở khác**
```
Cho: N_ĐL = 1200 vòng
     U_kích_từ = 220V DC
     R_kích_từ = 73.3 Ω (tăng 33%)

Bước 1: Tính dòng điện
I_ĐL = U_kích_từ / R_kích_từ = 220 / 73.3 = 3.0 A

Bước 2: Tính sức từ động
F_ĐL = N_ĐL × I_ĐL = 1200 × 3.0 = 3600 At

Bước 3: Phân tích ảnh hưởng
F_ĐL giảm 25% → Từ thông cơ bản giảm → Điện áp máy phát giảm
```

**KIỂM TRA KẾT QUẢ:**
- F_ĐL tỷ lệ thuận với U_kích_từ và tỷ lệ nghịch với R_kích_từ
- F_ĐL không phụ thuộc vào tải máy phát
- Giá trị F_ĐL hợp lý cho cuộn kích từ cơ bản

**ÁP DỤNG THỰC TẾ:**
- **Thiết kế:** Chọn U_kích_từ và R_kích_từ để có F_ĐL mong muốn
- **Điều chỉnh:** Thay đổi U_kích_từ hoặc R_kích_từ để điều chỉnh F_ĐL
- **Kiểm tra:** Đo I_ĐL để đánh giá hoạt động cuộn kích từ
- **Bảo trì:** F_ĐL giảm có thể do hỏng nguồn cấp hoặc cuộn dây

### Thông số kích từ độc lập:

**Thông số điển hình:**
- Số vòng dây: N_ĐL = 800 - 1500 vòng
- Dòng điện: I_ĐL = 2 - 5 A
- Điện áp: U_kích_từ = 220V DC
- Điện trở: R_kích_từ = 40 - 100 Ω
- Công suất: P_kích_từ = 500 - 1000 W

### Tính toán cụ thể:

**Ví dụ 1: Máy phát nâng hạ gầu**
```
Cho: N_ĐL = 1200 vòng
     U_kích_từ = 220V
     R_kích_từ = 55 Ω

I_ĐL = 220 / 55 = 4.0 A
F_ĐL = 1200 × 4.0 = 4800 At
```

**Ví dụ 2: Với điều chỉnh điện áp**
```
U_kích_từ thay đổi: 0 → 220V

I_ĐL = 0 → 4.0 A
F_ĐL = 0 → 4800 At
```

### Quan hệ F_ĐL với điện áp kích từ:

```
F_ĐL = (N_ĐL / R_kích_từ) × U_kích_từ = K_ĐL × U_kích_từ
```

Trong đó:
```
K_ĐL = N_ĐL / R_kích_từ (At/V)
```

### Ví dụ tính K_ĐL:

```
N_ĐL = 1200 vòng
R_kích_từ = 55 Ω

K_ĐL = 1200 / 55 = 21.82 At/V

Khi U_kích_từ = 180V:
F_ĐL = 21.82 × 180 = 3927 At
```

### Bảng đặc tính F_ĐL theo điện áp:

| U_kích_từ (V) | I_ĐL (A) | F_ĐL (At) | % F_max |
|---------------|----------|-----------|---------|
| 0 | 0 | 0 | 0% |
| 50 | 0.91 | 1091 | 22.7% |
| 100 | 1.82 | 2182 | 45.5% |
| 150 | 2.73 | 3273 | 68.2% |
| 200 | 3.64 | 4364 | 90.9% |
| 220 | 4.00 | 4800 | 100% |

### So sánh kích từ độc lập và kích từ song song:

| Đặc điểm | Kích từ độc lập | Kích từ song song |
|----------|-----------------|-------------------|
| Nguồn cấp | Riêng biệt | Từ chính máy phát |
| Ổn định | Cao | Thấp hơn |
| Điều khiển | Dễ dàng | Phức tạp |
| Chi phí | Cao | Thấp |
| Khởi động | Dễ | Khó (cần từ dư) |

### Sơ đồ kích từ độc lập:

```
Nguồn DC    Biến trở điều chỉnh
  (+)------------[R_điều_chỉnh]---+
                                   |
                              [Cuộn_kích_từ]
                                   |
  (-)------------------------------+
```

### Công thức tính từ thông:

Với kích từ độc lập:
```
Φ = f(F_ĐL)
```

Không phụ thuộc vào điện áp đầu ra hay dòng tải.

### Ưu điểm của kích từ độc lập:

**1. Điều khiển chính xác:**
```
U_máy_phát = K × F_ĐL
```
Điều chỉnh F_ĐL dễ dàng điều chỉnh U_máy_phát

**2. Ổn định:**
Không bị ảnh hưởng bởi:
- Thay đổi tải
- Thay đổi điện áp đầu ra
- Quá độ của hệ thống

**3. Khởi động dễ dàng:**
Không cần từ dư ban đầu

### Nhược điểm:

**1. Cần nguồn riêng:**
- Máy phát phụ
- Hoặc chỉnh lưu riêng
- Tăng chi phí và độ phức tạp

**2. Tổn thất:**
```
P_kích_từ = U_kích_từ × I_ĐL
P_kích_từ = 220 × 4 = 880W
```

### Tính toán công suất kích từ:

```
P_kích_từ = I_ĐL² × R_kích_từ
```

**Ví dụ:**
```
I_ĐL = 4A
R_kích_từ = 55 Ω

P_kích_từ = 4² × 55 = 880W
```

Hiệu suất kích từ:
```
η_kích_từ = P_từ_trường / P_điện
η_kích_từ ≈ 70-80%
```

### Điều chỉnh F_ĐL:

**Phương pháp 1: Biến trở nối tiếp**
```
I_ĐL = U / (R_kích_từ + R_biến_trở)
```

**Phương pháp 2: Điều chỉnh điện áp nguồn**
```
U_kích_từ: 0 → 220V (liên tục)
```

**Phương pháp 3: PWM (hiện đại)**
```
U_trung_bình = U_nguồn × D
D: Duty cycle (0 → 1)
```

### Ý nghĩa:
- F_ĐL độc lập với tải và điện áp ra
- Cho phép điều khiển chính xác điện áp máy phát
- Quan trọng trong hệ thống điều khiển tự động
- Đảm bảo hoạt động ổn định

---

## 3.1.10 - Xác định sức từ động trong mạch kích thích song song (F_KTSS)

### Khái niệm
F_KTSS là sức từ động của cuộn kích từ song song, lấy nguồn từ chính điện áp đầu ra của máy phát.

**GIẢI THÍCH CHI TIẾT:**

Sức từ động kích thích song song F_KTSS là một thành phần quan trọng trong hệ thống kích từ máy phát DC. Nó hoạt động theo nguyên lý tự kích từ, lấy nguồn từ chính điện áp đầu ra của máy phát.

**Ý nghĩa vật lý:**
- F_KTSS phụ thuộc vào điện áp đầu ra của máy phát
- Tạo ra phản hồi dương trong hệ thống
- Cho phép máy phát tự kích từ mà không cần nguồn ngoài

**Nguyên lý hoạt động:**
```
Điện áp máy phát → Cuộn kích từ song song → Từ thông → Điện áp máy phát tăng
```

**Đặc điểm quan trọng:**
- Phản hồi dương: U_máy_phát ↑ → I_KTSS ↑ → F_KTSS ↑ → U_máy_phát ↑
- Cần có từ dư ban đầu để tự kích từ
- Điện trở mạch kích từ phải thỏa mãn điều kiện nhất định

**So sánh với kích từ độc lập:**
- Kích từ song song: Đơn giản, rẻ tiền, nhưng kém ổn định
- Kích từ độc lập: Phức tạp, đắt tiền, nhưng ổn định

### Công thức tính:

**1. Công thức cơ bản:**
```
F_KTSS = N_KTSS × I_KTSS
```

**GIẢI THÍCH TỪNG KÝ HIỆU:**
- `F_KTSS`: Sức từ động kích thích song song (At)
- `N_KTSS`: Số vòng dây cuộn kích từ song song (vòng)
- `I_KTSS`: Dòng điện kích từ song song (A)

**2. Quan hệ với điện áp máy phát:**
```
I_KTSS = U_máy_phát / R_kích_từ
```

**GIẢI THÍCH TỪNG KÝ HIỆU:**
- `U_máy_phát`: Điện áp đầu ra của máy phát (V)
- `R_kích_từ`: Điện trở cuộn kích từ song song (Ω)

**CƠ SỞ VẬT LÝ:**
Cuộn kích từ song song được mắc song song với phần ứng máy phát. Dòng điện qua cuộn này tỷ lệ với điện áp đầu ra, tạo ra phản hồi dương trong hệ thống.

**VÍ DỤ TÍNH TOÁN TỪNG BƯỚC:**

**Ví dụ 1: Tính ở điện áp định mức**
```
Cho: N_KTSS = 2000 vòng
     U_máy_phát = 220V
     R_kích_từ = 110 Ω

Bước 1: Tính dòng điện theo định luật Ohm
I_KTSS = U_máy_phát / R_kích_từ = 220 / 110 = 2.0 A

Bước 2: Tính sức từ động
F_KTSS = N_KTSS × I_KTSS = 2000 × 2.0 = 4000 At

Bước 3: Ý nghĩa
F_KTSS = 4000 At tạo từ thông kích từ song song
```

**Ví dụ 2: Tính khi điện áp giảm**
```
Cho: N_KTSS = 2000 vòng
     U_máy_phát = 180V (giảm do tải)
     R_kích_từ = 110 Ω

Bước 1: Tính dòng điện
I_KTSS = U_máy_phát / R_kích_từ = 180 / 110 = 1.64 A

Bước 2: Tính sức từ động
F_KTSS = N_KTSS × I_KTSS = 2000 × 1.64 = 3280 At

Bước 3: Phân tích phản hồi
U giảm → I_KTSS giảm → F_KTSS giảm → U giảm thêm
→ Phản hồi âm về điện áp (tốt)
```

**Ví dụ 3: Tính khi điện áp tăng**
```
Cho: N_KTSS = 2000 vòng
     U_máy_phát = 250V (tăng do giảm tải)
     R_kích_từ = 110 Ω

Bước 1: Tính dòng điện
I_KTSS = U_máy_phát / R_kích_từ = 250 / 110 = 2.27 A

Bước 2: Tính sức từ động
F_KTSS = N_KTSS × I_KTSS = 2000 × 2.27 = 4540 At

Bước 3: Phân tích phản hồi
U tăng → I_KTSS tăng → F_KTSS tăng → U tăng thêm
→ Phản hồi dương về điện áp (cần cẩn thận)
```

**KIỂM TRA KẾT QUẢ:**
- F_KTSS tỷ lệ thuận với U_máy_phát
- F_KTSS = 0 khi U_máy_phát = 0 (hợp lý)
- Giá trị F_KTSS hợp lý cho cuộn kích từ song song

**ÁP DỤNG THỰC TẾ:**
- **Thiết kế:** Chọn N_KTSS và R_kích_từ để có đặc tính mong muốn
- **Điều chỉnh:** Thay đổi R_kích_từ để điều chỉnh độ nhạy phản hồi
- **Kiểm tra:** Đo I_KTSS để đánh giá hoạt động kích từ song song
- **Bảo trì:** F_KTSS không đúng có thể do hỏng cuộn dây hoặc mạch song song

```
I_KTSS = U_máy_phát / R_kích_từ
```

**Đặc điểm:** I_KTSS phụ thuộc vào U_máy_phát

### Thông số kích từ song song:

**Thông số điển hình:**
- Số vòng dây: N_KTSS = 1500 - 3000 vòng (nhiều hơn kích từ độc lập)
- Dòng điện: I_KTSS = 1 - 3 A
- Điện áp: U = U_máy_phát = 0 - 220V
- Điện trở: R_kích_từ = 80 - 200 Ω

### Tính toán cụ thể:

**Ví dụ 1: Định mức**
```
Cho: N_KTSS = 2000 vòng
     U_máy_phát = 220V
     R_kích_từ = 110 Ω

I_KTSS = 220 / 110 = 2.0 A
F_KTSS = 2000 × 2.0 = 4000 At
```

**Ví dụ 2: Tải 50%**
```
U_máy_phát = 180V (do sụt áp)

I_KTSS = 180 / 110 = 1.64 A
F_KTSS = 2000 × 1.64 = 3280 At
```

**Ví dụ 3: Không tải**
```
U_máy_phát = 230V

I_KTSS = 230 / 110 = 2.09 A
F_KTSS = 2000 × 2.09 = 4180 At
```

### Quan hệ F_KTSS với điện áp máy phát:

```
F_KTSS = (N_KTSS / R_kích_từ) × U_máy_phát = K_KTSS × U_máy_phát
```

Trong đó:
```
K_KTSS = N_KTSS / R_kích_từ (At/V)
```

### Ví dụ tính K_KTSS:

```
N_KTSS = 2000 vòng
R_kích_từ = 110 Ω

K_KTSS = 2000 / 110 = 18.18 At/V

Khi U = 200V:
F_KTSS = 18.18 × 200 = 3636 At
```

### Bảng đặc tính F_KTSS:

| U_máy_phát (V) | I_KTSS (A) | F_KTSS (At) | Tình trạng |
|----------------|-----------|-------------|------------|
| 0 | 0 | 0 | Không hoạt động |
| 50 | 0.45 | 900 | Khởi động |
| 100 | 0.91 | 1820 | Tải nặng |
| 150 | 1.36 | 2720 | Tải trung bình |
| 200 | 1.82 | 3640 | Tải nhẹ |
| 220 | 2.00 | 4000 | Định mức |

### Đặc tính phản hồi dương:

**Vòng lặp kích từ:**
```
U_máy_phát ↑ → I_KTSS ↑ → F_KTSS ↑ → Φ ↑ → U_máy_phát ↑
```

Đây là phản hồi dương! ⚠️

### Điều kiện tự kích từ:

**1. Cần có từ dư ban đầu:**
```
Φ_dư > 0
```

**2. Điện trở mạch kích từ phải thỏa mãn:**
```
R_kích_từ < R_tới_hạn
```

**3. Chiều đấu dây đúng:**
Từ trường cuộn kích từ cùng chiều với từ dư.

### Đồ thị tự kích từ:

```
U (V)
   |    /●
220|   / |
   |  /  |
   | /   |Đường tải
100|/    |(R=const)
   |     |
   |  ●  |
   | /|  |
  0|/____|_____ I_KTSS (A)
   0   Đặc tính từ hóa
```

Điểm làm việc: Giao điểm giữa đặc tính từ hóa và đường tải.

### Phân tích ổn định:

**Vùng ổn định:**
```
dU/dI_KTSS < R_kích_từ
```

**Vùng không ổn định:**
```
dU/dI_KTSS > R_kích_từ
```

### So sánh kích từ song song vs độc lập:

| Đặc điểm | Kích từ song song | Kích từ độc lập |
|----------|-------------------|-----------------|
| Nguồn | Từ máy phát | Nguồn riêng |
| Ổn định | Kém hơn | Tốt hơn |
| Phản hồi | Dương | Không |
| Khởi động | Cần từ dư | Không cần |
| Điều khiển | Khó | Dễ |
| Chi phí | Thấp | Cao |

### Tổ hợp kích từ hỗn hợp:

Trong hệ thống Huina 1592, thường dùng cả hai:
```
F_tổng = F_ĐL + F_KTSS (+ hoặc -)
```

**Ưu điểm:**
- F_ĐL: Điều khiển chính
- F_KTSS: Bù thêm công suất

### Tính toán công suất:

```
P_KTSS = U_máy_phát × I_KTSS
```

**Ví dụ:**
```
U = 220V
I_KTSS = 2A

P_KTSS = 220 × 2 = 440W

% công suất máy phát:
440W / 75kW = 0.59%
```

### Điều chỉnh F_KTSS:

**Phương pháp 1: Biến trở nối tiếp**
```
R_tổng = R_kích_từ + R_biến_trở
I_KTSS = U / R_tổng
```

Tăng R → Giảm I_KTSS → Giảm F_KTSS → Giảm U

**Phương pháp 2: Shunt điện trở**
```
Điện trở song song với cuộn kích từ
Phân dòng bớt I_KTSS
```

### Ảnh hưởng của nhiệt độ:

```
R_t = R₂₀ × [1 + α(t - 20)]

α ≈ 0.004 /°C
```

**Ví dụ:**
```
R₂₀ = 110 Ω
t = 80°C

R₈₀ = 110 × [1 + 0.004 × 60] = 136.4 Ω

I_KTSS giảm: 220/136.4 = 1.61A (so với 2.0A)
F_KTSS giảm: 2000 × 1.61 = 3220 At (so với 4000 At)
```

→ Điện áp máy phát giảm khi nóng!

### Ý nghĩa:
- F_KTSS phụ thuộc điện áp máy phát
- Tạo phản hồi dương (cần cẩn thận)
- Cần từ dư để tự kích từ
- Rẻ hơn nhưng kém ổn định hơn kích từ độc lập

---

## 3.1.11 - Xác định hằng số thời gian của máy phát T_F

### Khái niệm
T_F (Time constant of field) là hằng số thời gian của mạch kích từ máy phát, đặc trưng cho độ trễ khi thay đổi từ thông.

**GIẢI THÍCH CHI TIẾT:**

Hằng số thời gian mạch kích từ T_F là một thông số quan trọng trong phân tích động học của máy phát DC. Nó đặc trưng cho tốc độ phản ứng của hệ thống kích từ khi có sự thay đổi điện áp đầu vào.

**Ý nghĩa vật lý:**
- T_F cho biết thời gian để từ thông đạt 63.2% giá trị cuối cùng
- Đặc trưng cho quán tính từ của hệ thống
- Ảnh hưởng đến tốc độ phản ứng của máy phát

**Nguyên lý hoạt động:**
```
Thay đổi điện áp kích từ → Dòng điện thay đổi → Từ thông thay đổi (có trễ)
```

**Đặc điểm quan trọng:**
- T_F lớn: Phản ứng chậm, ổn định tốt
- T_F nhỏ: Phản ứng nhanh, có thể dao động
- Phụ thuộc vào thiết kế mạch từ và cuộn dây

**Ảnh hưởng đến hệ thống:**
- Điều khiển: T_F lớn làm hệ thống chậm phản ứng
- Ổn định: T_F nhỏ có thể gây dao động
- Thiết kế: Cần cân bằng giữa tốc độ và ổn định

### Công thức tính:

**1. Công thức cơ bản:**
```
T_F = L_F / R_F
```

**GIẢI THÍCH TỪNG KÝ HIỆU:**
- `T_F`: Hằng số thời gian mạch kích từ (s)
- `L_F`: Độ tự cảm cuộn kích từ (H)
- `R_F`: Điện trở mạch kích từ (Ω)

**2. Quan hệ với từ thông:**
```
L_F = N × (dΦ/dI)
```

**GIẢI THÍCH TỪNG KÝ HIỆU:**
- `N`: Số vòng dây cuộn kích từ (vòng)
- `dΦ/dI`: Độ nhạy từ thông theo dòng điện (Wb/A)

**CƠ SỞ VẬT LÝ:**
Hằng số thời gian T_F xuất phát từ phương trình vi phân của mạch RL:
```
L_F × (dI/dt) + R_F × I = U_kích_từ
```

Giải phương trình này cho ta:
```
I(t) = I_∞ × (1 - e^(-t/T_F))
```

**VÍ DỤ TÍNH TOÁN TỪNG BƯỚC:**

**Ví dụ 1: Tính từ thông số định mức**
```
Cho: L_F = 20 H
     R_F = 40 Ω

Bước 1: Áp dụng công thức cơ bản
T_F = L_F / R_F = 20 / 40 = 0.5 s

Bước 2: Ý nghĩa
Sau 0.5s, từ thông đạt 63.2% giá trị cuối cùng
Sau 2.5s (5×T_F), từ thông đạt 99.3% giá trị cuối cùng
```

**Ví dụ 2: Tính với độ tự cảm khác**
```
Cho: L_F = 30 H (tăng 50%)
     R_F = 40 Ω

Bước 1: Tính hằng số thời gian
T_F = L_F / R_F = 30 / 40 = 0.75 s

Bước 2: So sánh với trường hợp trước
T_F tăng 50% → Phản ứng chậm hơn 50%
```

**Ví dụ 3: Tính với điện trở khác**
```
Cho: L_F = 20 H
     R_F = 60 Ω (tăng 50%)

Bước 1: Tính hằng số thời gian
T_F = L_F / R_F = 20 / 60 = 0.33 s

Bước 2: Phân tích ảnh hưởng
R_F tăng → T_F giảm → Phản ứng nhanh hơn
Nhưng tổn thất tăng và hiệu suất giảm
```

**KIỂM TRA KẾT QUẢ:**
- T_F tỷ lệ thuận với L_F và tỷ lệ nghịch với R_F
- T_F > 0 (hợp lý)
- Giá trị T_F hợp lý cho mạch kích từ máy phát

**ÁP DỤNG THỰC TẾ:**
- **Thiết kế:** Chọn L_F và R_F để có T_F mong muốn
- **Điều khiển:** T_F lớn cần bộ điều khiển chậm hơn
- **Ổn định:** T_F nhỏ cần cẩn thận với dao động
- **Bảo trì:** T_F thay đổi có thể do hỏng cuộn dây hoặc mạch từ

### Thông số máy phát nâng hạ gầu:

| Thông số | Giá trị | Đơn vị |
|----------|---------|--------|
| Độ tự cảm L_F | 10 - 30 | H |
| Điện trở R_F | 20 - 80 | Ω |
| Hằng số thời gian T_F | 0.2 - 1.0 | s |

### Tính toán cụ thể:

**Ví dụ 1: Kích từ độc lập**
```
Cho: L_F = 20 H
     R_F = 50 Ω

T_F = 20 / 50 = 0.4 s = 400 ms
```

**Ví dụ 2: Kích từ song song**
```
Cho: L_F = 30 H
     R_F = 120 Ω

T_F = 30 / 120 = 0.25 s = 250 ms
```

**Ví dụ 3: Kích từ hỗn hợp**
```
Cho: L_F = 25 H
     R_F_tổng = 40 Ω (song song điện trở)

T_F = 25 / 40 = 0.625 s = 625 ms
```

### Hàm truyền mạch kích từ:

**Hàm truyền bậc 1:**
```
G_F(s) = K_F / (T_F × s + 1)
```

Trong đó:
- K_F: Hệ số khuếch đại mạch kích từ
- T_F: Hằng số thời gian

### Đáp ứng bước (Step Response):

**Tín hiệu vào:** U_in bước nhảy từ 0 → U₀

**Dòng kích từ:**
```
I_F(t) = (U₀/R_F) × [1 - e^(-t/T_F)]
```

**Từ thông:**
```
Φ(t) = Φ_max × [1 - e^(-t/T_F)]
```

**Điện áp máy phát:**
```
U_MF(t) = U_max × [1 - e^(-t/T_F)]
```

### Bảng thời gian đáp ứng:

| Thời gian | Giá trị đạt được | % giá trị max |
|-----------|------------------|---------------|
| t = 0 | 0 | 0% |
| t = 0.5T_F | 0.393 × U_max | 39.3% |
| t = T_F | 0.632 × U_max | 63.2% |
| t = 2T_F | 0.865 × U_max | 86.5% |
| t = 3T_F | 0.950 × U_max | 95.0% |
| t = 4T_F | 0.982 × U_max | 98.2% |
| t = 5T_F | 0.993 × U_max | 99.3% |

### Ví dụ tính toán thời gian:

**Cho T_F = 0.4s, yêu cầu đạt 95% điện áp:**
```
t = 3 × T_F = 3 × 0.4 = 1.2 s
```

**Cho T_F = 0.25s, yêu cầu đạt 99% điện áp:**
```
t = 5 × T_F = 5 × 0.25 = 1.25 s
```

### Đồ thị đáp ứng:

```
U (%)
 100|          ______
    |        /
  95|      ●  3T_F
    |     /
  63|   ●  T_F
    |  /
    | /
   0|●______________ t
    0  T_F 3T_F 5T_F
```

### Ảnh hưởng của T_F đến hệ thống:

**1. Độ nhanh:**
- T_F nhỏ → Đáp ứng nhanh → Điều khiển linh hoạt
- T_F lớn → Đáp ứng chậm → Hệ thống ổn định

**2. Độ ổn định:**
- T_F quá nhỏ → Dao động
- T_F vừa phải → Ổn định tốt

**3. Thời gian quá độ:**
```
t_quá_độ ≈ (3-5) × T_F
```

### Mô hình động học:

**Phương trình vi phân:**
```
T_F × (dI_F/dt) + I_F = U_in / R_F
```

**Nghiệm:**
```
I_F(t) = (U_in/R_F) × [1 - e^(-t/T_F)] + I_F(0) × e^(-t/T_F)
```

### Phân tích tần số:

**Hàm truyền:**
```
G_F(jω) = K_F / (j×ω×T_F + 1)
```

**Biên độ:**
```
|G_F(jω)| = K_F / √(1 + ω²×T_F²)
```

**Pha:**
```
∠G_F(jω) = -arctan(ω × T_F)
```

**Tần số cắt:**
```
ω_c = 1 / T_F (rad/s)
f_c = 1 / (2π × T_F) (Hz)
```

### Ví dụ tính tần số cắt:

```
T_F = 0.4s

ω_c = 1 / 0.4 = 2.5 rad/s
f_c = 1 / (2π × 0.4) = 0.398 Hz
```

→ Hệ thống đáp ứng tốt với tín hiệu < 0.4 Hz

### Ảnh hưởng của tải:

Khi có tải, từ trường phần ứng ảnh hưởng:
```
T_F_hiệu_quả = T_F × (1 + K_phản_ứng)
```

K_phản_ứng ≈ 0.1 - 0.3

**Ví dụ:**
```
T_F = 0.4s
K_phản_ứng = 0.2

T_F_hiệu_quả = 0.4 × 1.2 = 0.48s
```

→ Đáp ứng chậm hơn khi có tải!

### So sánh các loại máy phát:

| Loại máy phát | L_F (H) | R_F (Ω) | T_F (s) |
|---------------|---------|---------|---------|
| Máy nhỏ (< 10kW) | 5-10 | 50-100 | 0.1-0.2 |
| Máy trung (10-100kW) | 10-30 | 20-80 | 0.2-1.0 |
| Máy lớn (> 100kW) | 30-100 | 10-50 | 1.0-5.0 |

### Đo đạc T_F thực nghiệm:

**Phương pháp 1: Đáp ứng bước**
1. Đặt máy phát không tải
2. Đột biến điện áp kích từ
3. Đo thời gian đạt 63.2% điện áp = T_F

**Phương pháp 2: Đáp ứng tần số**
1. Quét tần số điện áp kích từ
2. Tìm tần số cắt (-3dB)
3. T_F = 1 / (2π × f_c)

### Ý nghĩa:
- T_F đặc trưng độ trễ của mạch kích từ
- T_F = 0.2-1.0s cho máy phát EKG-5A
- Ảnh hưởng lớn đến chất lượng điều khiển
- Cần tính toán để thiết kế bộ điều khiển phù hợp

---

## 3.1.12 - Xác định tham số của động cơ nâng hạ gầu

### Khái niệm
Động cơ nâng hạ gầu là động cơ DC kích từ độc lập hoặc nối tiếp, điều khiển cơ cấu nâng hạ gầu máy xúc.

**GIẢI THÍCH CHI TIẾT:**

Động cơ nâng hạ gầu là một thành phần quan trọng trong hệ thống điều khiển máy xúc tự động. Nó chịu trách nhiệm điều khiển chuyển động nâng và hạ gầu máy xúc một cách chính xác và ổn định.

**Ý nghĩa vật lý:**
- Động cơ chuyển đổi năng lượng điện thành năng lượng cơ học
- Tạo ra mô men xoắn để điều khiển cơ cấu nâng hạ
- Cần có đặc tính cơ phù hợp với tải trọng và tốc độ yêu cầu

**Nguyên lý hoạt động:**
```
Điện áp đầu vào → Dòng điện phần ứng → Từ trường → Mô men xoắn → Chuyển động cơ học
```

**Đặc điểm quan trọng:**
- Cần có khả năng điều khiển tốc độ chính xác
- Phải chịu được tải trọng lớn và thay đổi đột ngột
- Cần có đặc tính cơ phù hợp với ứng dụng nâng hạ

**So sánh với động cơ khác:**
- Động cơ nâng hạ: Cần mô men lớn, tốc độ thay đổi
- Động cơ quay: Tốc độ cao, mô men nhỏ
- Động cơ di chuyển: Cần điều khiển hai chiều

### Các tham số cần xác định:

**1. Tham số điện:**
- Điện áp định mức: U_đm
- Dòng định mức: I_đm
- Công suất: P_đm
- Điện trở phần ứng: R_a
- Điện trở kích từ: R_f

**2. Tham số cơ:**
- Tốc độ định mức: n_đm
- Mô men định mức: M_đm
- Mô men đà: J

**3. Tham số động học:**
- Hằng số thời gian cơ: T_m
- Hằng số thời gian điện: T_a
- Hằng số động cơ: K_e, K_m

**GIẢI THÍCH TỪNG NHÓM THÔNG SỐ:**

**Tham số điện:**
- U_đm: Điện áp làm việc định mức của động cơ
- I_đm: Dòng điện định mức, quyết định kích thước dây dẫn
- P_đm: Công suất cơ học đầu ra, đặc trưng cho khả năng làm việc
- R_a: Điện trở phần ứng, ảnh hưởng đến tổn thất và đặc tính cơ
- R_f: Điện trở kích từ, quyết định dòng kích từ

**Tham số cơ:**
- n_đm: Tốc độ quay định mức, phù hợp với ứng dụng
- M_đm: Mô men định mức, đảm bảo khả năng tải
- J: Mô men quán tính, ảnh hưởng đến động học

**Tham số động học:**
- T_m: Hằng số thời gian cơ, đặc trưng cho tốc độ phản ứng
- T_a: Hằng số thời gian điện, thường rất nhỏ
- K_e, K_m: Hằng số động cơ, liên hệ giữa điện và cơ

### Thông số động cơ Huina 1592:

**Loại động cơ:** 540/550 Brushed DC Motor (phổ biến trong mô hình RC)

| Thông số | Ký hiệu | Giá trị | Đơn vị |
|----------|---------|---------|--------|
| Công suất | P_đm | 30 | W |
| Điện áp | U_đm | 7.4 | V |
| Dòng điện | I_đm | 4 | A |
| Tốc độ không tải | n₀ | 12000 | rpm |
| Tốc độ có tải | n_đm | 8000 | rpm |
| Mô men định mức | M_đm | 0.035 | N.m |
| Điện trở phần ứng | R_a | 0.8 | Ω |
| Moment đà | J | 0.00005 | kg.m² |
| Khối lượng | m | ~0.15 | kg |

### 1. Tính toán điện trở phần ứng (R_a):

**Phương pháp đo trực tiếp:**
```
R_a = U_dc / I_dc (đo ở DC)
```

**Phương pháp từ tổn thất:**
```
P_tổn_thất_đồng = I_đm² × R_a

R_a = P_tổn_thất_đồng / I_đm²
```

**Ví dụ:**
```
P_tổn_thất = 4300W
I_đm = 350A

R_a = 4300 / 350² = 0.0351 Ω ≈ 0.035 Ω
```

### 2. Tính hằng số sức điện động (K_e):

**Công thức:**
```
E_a = K_e × Φ × ω
```

Với kích từ không đổi:
```
E_a = K'_e × ω
```

Trong đó: K'_e = K_e × Φ

**Xác định K'_e:**
```
E_a = U_đm - I_đm × R_a

ω_đm = 2π × n_đm / 60

K'_e = E_a / ω_đm
```

**Ví dụ tính toán:**
```
U_đm = 220V
I_đm = 350A
R_a = 0.035 Ω
n_đm = 600 rpm

E_a = 220 - 350 × 0.035 = 220 - 12.25 = 207.75V

ω_đm = 2π × 600 / 60 = 62.83 rad/s

K'_e = 207.75 / 62.83 = 3.306 V/(rad/s)
```

### 3. Tính hằng số mô men (K_m):

**Công thức:**
```
M = K_m × Φ × I_a
```

Với kích từ không đổi:
```
M = K'_m × I_a
```

Trong đó: K'_m = K_m × Φ

**Xác định K'_m:**
```
M_đm = P_đm / ω_đm

K'_m = M_đm / I_đm
```

**Ví dụ tính toán:**
```
P_đm = 75000W
ω_đm = 62.83 rad/s
I_đm = 350A

M_đm = 75000 / 62.83 = 1193.7 N.m

K'_m = 1193.7 / 350 = 3.41 N.m/A
```

**Quan hệ K'_e và K'_m:**
```
K'_m = K'_e (trong đơn vị SI)
```

Kiểm tra:
```
K'_e = 3.306 V.s/rad
K'_m = 3.41 N.m/A

Sai số ≈ 3% (do tổn thất)
```

### 4. Tính hằng số thời gian điện (T_a):

**Công thức:**
```
T_a = L_a / R_a
```

Trong đó:
- L_a: Độ tự cảm phần ứng

**Giá trị điển hình:**
- L_a = 2-10 mH (cho động cơ trung bình)

**Ví dụ:**
```
L_a = 5 mH = 0.005 H
R_a = 0.035 Ω

T_a = 0.005 / 0.035 = 0.143 s = 143 ms
```

**Thường T_a rất nhỏ (10-200ms), có thể bỏ qua trong nhiều ứng dụng.**

### 5. Tính hằng số thời gian cơ (T_m):

**Công thức:**
```
T_m = (J × R_a) / (K'_e × K'_m)
```

Hoặc đơn giản:
```
T_m = (J × R_a) / K'_e²
```

**Ví dụ tính toán:**
```
J = 5.2 kg.m²
R_a = 0.035 Ω
K'_e = 3.306 V/(rad/s)

T_m = (5.2 × 0.035) / 3.306²
T_m = 0.182 / 10.93
T_m = 0.0167 s ≈ 17 ms
```

**Lưu ý:** Trong thực tế, mô men đà của tải (gầu + đất) >> mô men đà động cơ.

```
J_tổng = J_động_cơ + J_tải_quy_đổi
J_tải_quy_đổi = m_tải × r²/η²

Với gầu máy xúc:
J_tổng ≈ 50-200 kg.m² >> J_động_cơ = 5.2 kg.m²
```

### 6. Phương trình động học động cơ:

**Phương trình điện áp:**
```
U_a = R_a × I_a + L_a × (dI_a/dt) + E_a
U_a = R_a × I_a + L_a × (dI_a/dt) + K'_e × ω
```

**Phương trình mô men:**
```
M_động_cơ - M_tải = J × (dω/dt)
K'_m × I_a - M_tải = J × (dω/dt)
```

**Hàm truyền động cơ:**
```
G_motor(s) = ω(s)/U_a(s) = K_v / [(T_a×s + 1)(T_m×s + 1)]
```

Trong đó:
```
K_v = 1 / K'_e (hệ số khuếch đại vận tốc)
```

**Nếu bỏ qua T_a (vì T_a << T_m):**
```
G_motor(s) ≈ K_v / (T_m × s + 1)
```

### 7. Đặc tính cơ động cơ:

**Đặc tính tự nhiên (U = U_đm, Φ = Φ_đm):**
```
n = (U_đm - I_a × R_a) / (K'_e × 2π/60)
```

Hoặc:
```
n = n₀ - Δn × M
```

Trong đó:
- n₀: Tốc độ không tải
- Δn: Độ dốc đặc tính

**Tính n₀:**
```
n₀ = U_đm / (K'_e × 2π/60)
n₀ = 220 / (3.306 × 0.1047)
n₀ = 635 rpm
```

**Tính Δn:**
```
Δn = (R_a × 60) / (K'_e² × 2π)
Δn = (0.035 × 60) / (3.306² × 2π)
Δn = 0.0322 rpm/(N.m)
```

**Đặc tính:**
```
n (rpm) = 635 - 0.0322 × M (N.m)
```

Tại M_đm = 1194 N.m:
```
n = 635 - 0.0322 × 1194 = 596.6 rpm ≈ 600 rpm ✓
```

### 8. Hiệu suất động cơ:

**Hiệu suất tổng:**
```
η = P_ra / P_vào = P_cơ / P_điện
```

**Các tổn thất:**
1. Tổn thất đồng phần ứng: P_Cu_a = I_a² × R_a
2. Tổn thất đồng kích từ: P_Cu_f = U_f² / R_f
3. Tổn thất cơ (ma sát, gió): P_cơ
4. Tổn thất sắt từ: P_sắt_từ

**Tính hiệu suất:**
```
P_điện = U_đm × I_đm = 220 × 350 = 77000W
P_cơ = 75000W

η = 75000 / 77000 = 0.974 = 97.4%
```

### 9. Dòng khởi động:

**Không hạn chế:**
```
I_khởi_động = U / R_a = 220 / 0.035 = 6286 A !!!
```

→ Rất lớn, cần hạn chế!

**Với điện trở khởi động:**
```
I_khởi_động_cho_phép ≈ (2-2.5) × I_đm = 700-875A

R_khởi_động = U / I_khởi_động - R_a
R_khởi_động = 220 / 800 - 0.035 = 0.240 Ω
```

### 10. Điều khiển tốc độ:

**Phương pháp 1: Thay đổi điện áp phần ứng**
```
n ∝ U_a (với Φ = const)

U_a: 0 → 220V
=> n: 0 → 635 rpm
```

**Phương pháp 2: Thay đổi từ thông**
```
n ∝ 1/Φ (với U_a = const)

Giảm Φ => Tăng n (vượt tốc độ cơ bản)
```

**Phương pháp 3: Thay đổi điện trở phần ứng**
```
Thêm R_ngoài nối tiếp
=> Giảm hiệu suất, ít dùng
```

### Bảng tóm tắt thông số:

| Thông số | Ký hiệu | Giá trị | Đơn vị |
|----------|---------|---------|--------|
| Công suất | P_đm | 75 | kW |
| Điện áp | U_đm | 220 | V |
| Dòng điện | I_đm | 350 | A |
| Tốc độ | n_đm | 600 | rpm |
| Mô men | M_đm | 1194 | N.m |
| Điện trở phần ứng | R_a | 0.035 | Ω |
| Độ tự cảm phần ứng | L_a | 5 | mH |
| Hằng số EMF | K'_e | 3.31 | V/(rad/s) |
| Hằng số mô men | K'_m | 3.31 | N.m/A |
| Mô men đà | J | 5.2 | kg.m² |
| Hằng số thời gian điện | T_a | 143 | ms |
| Hằng số thời gian cơ | T_m | 17 | ms |
| Hiệu suất | η | 97.4 | % |

### Ý nghĩa:
- Các thông số này cần thiết để mô phỏng và điều khiển
- R_a rất nhỏ → Dòng khởi động lớn, cần hạn chế
- T_m nhỏ → Đáp ứng nhanh
- K'_e = K'_m → Kiểm tra tính đúng đắn của tính toán
- Hiệu suất cao (>95%) → Động cơ tốt

---

## TÓM TẮT PHẦN 2

### Bảng tổng hợp thông số (3.1.7 - 3.1.12):

| Thông số | Ký hiệu | Giá trị | Đơn vị |
|----------|---------|---------|--------|
| Sức từ động YCM-4 | F₄ | 0-5000 | At |
| Sức điện động máy phát | E_od | 237 | V |
| MMF kích từ độc lập | F_ĐL | 4800 | At |
| MMF kích từ song song | F_KTSS | 4000 | At |
| Hằng số thời gian máy phát | T_F | 0.2-1.0 | s |
| Điện trở động cơ | R_a | 0.035 | Ω |
| Hằng số EMF | K'_e | 3.31 | V/(rad/s) |
| Hằng số mô men | K'_m | 3.31 | N.m/A |
| Hằng số thời gian cơ | T_m | 17 | ms |

### Các công thức quan trọng:

1. **Sức từ động bù:** F₄ = N₄ × I_tải
2. **EMF máy phát:** E_od = C_e × Φ × n
3. **MMF kích từ độc lập:** F_ĐL = N_ĐL × I_ĐL
4. **MMF kích từ song song:** F_KTSS = N_KTSS × U / R
5. **Hằng số thời gian MF:** T_F = L_F / R_F
6. **Hằng số EMF:** K'_e = E_a / ω
7. **Hằng số mô men:** K'_m = M / I_a
8. **Hằng số thời gian cơ:** T_m = J × R_a / K'_e²

### Ứng dụng thực tế:

- **F₄**: Bù phản ứng phần ứng, cải thiện đặc tính điều áp
- **E_od**: Tính toán điều khiển điện áp máy phát
- **F_ĐL, F_KTSS**: Thiết kế mạch kích từ
- **T_F**: Thiết kế bộ điều khiển, tính thời gian đáp ứng
- **K'_e, K'_m**: Mô phỏng và điều khiển động cơ
- **T_m**: Phân tích động học hệ thống

---

**HẾT PHẦN 2**

Tiếp theo: [Code MATLAB mô phỏng](../matlab/)

