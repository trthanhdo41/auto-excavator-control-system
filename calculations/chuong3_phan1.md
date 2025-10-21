# CHƯƠNG 3 - PHẦN 1: XÁC ĐỊNH CÁC THÔNG SỐ (3.1.1 - 3.1.6)

## 3.1.1 - Xác định hệ số Kᵢᵢ

### Khái niệm
Hệ số Kᵢᵢ là hệ số khuếch đại của từng khâu trong hệ thống điều khiển máy xúc.

**GIẢI THÍCH CHI TIẾT:**

Hệ số khuếch đại là một đại lượng **không thứ nguyên** (không có đơn vị) cho biết mức độ khuếch đại của hệ thống. Trong khuếch đại từ ПДД-1,5B, hệ số này đặc trưng cho khả năng biến đổi tín hiệu điện áp nhỏ thành tín hiệu điện áp lớn để điều khiển máy phát.

**Ý nghĩa vật lý:** Khi đầu vào thay đổi 1 đơn vị, đầu ra sẽ thay đổi Kᵢᵢ đơn vị. Ví dụ Kᵢᵢ = 22 có nghĩa là khi điện áp đầu vào tăng 1V thì điện áp đầu ra tăng 22V.

### Công thức tính
Hệ số khuếch đại tổng quát:
```
Kᵢᵢ = ΔY_out / ΔX_in
```

**GIẢI THÍCH TỪNG KÝ HIỆU:**
- `Kᵢᵢ`: Hệ số khuếch đại tổng quát (không đơn vị)
- `ΔY_out`: Độ biến thiên tín hiệu đầu ra (V, A, hoặc W)
- `ΔX_in`: Độ biến thiên tín hiệu đầu vào (V, A, hoặc W)

**VÍ DỤ TÍNH TOÁN TỪNG BƯỚC:**

**Bước 1:** Đo điện áp đầu vào tại 2 điểm
```
U_in1 = 0V (không có tín hiệu)
U_in2 = 5V (tín hiệu điều khiển)
ΔU_in = U_in2 - U_in1 = 5 - 0 = 5V
```

**Bước 2:** Đo điện áp đầu ra tương ứng
```
U_out1 = 15V (điện áp dư do từ tính dư)
U_out2 = 125V (điện áp khi có tín hiệu)
ΔU_out = U_out2 - U_out1 = 125 - 15 = 110V
```

**Bước 3:** Tính hệ số khuếch đại
```
K_u = ΔU_out / ΔU_in = 110 / 5 = 22
```

**KIỂM TRA KẾT QUẢ:**
- K_u = 22 có nghĩa là hệ thống khuếch đại điện áp lên 22 lần
- Điều này phù hợp với đặc tính của ПДД-1,5B
- Cho phép điều khiển máy phát từ tín hiệu nhỏ (0-10V) thành điện áp lớn (0-240V)

**ÁP DỤNG THỰC TẾ:**
- **Thiết kế:** Cần K_u = 22 để đảm bảo điều khiển đầy đủ máy phát
- **Kiểm tra:** Đo thực tế để đảm bảo K_u ≈ 22 ± 10%
- **Điều chỉnh:** Thay đổi số vòng dây hoặc từ thông để điều chỉnh K_u
- **Bảo trì:** K_u giảm có thể do lão hóa hoặc hỏng hóc

### Đối với hệ thống khuếch đại từ kép ПДД-1,5B:

**1. Hệ số khuếch đại điện áp (K_u):**
```
K_u = U_out / U_in
```

**2. Hệ số khuếch đại dòng điện (K_i):**
```
K_i = I_out / I_in
```

**3. Hệ số khuếch đại công suất (K_p):**
```
K_p = P_out / P_in = K_u × K_i
```

### Thông số điển hình cho ПДД-1,5B:

| Thông số | Giá trị | Đơn vị |
|----------|---------|--------|
| Điện áp đầu vào | 0-10 | V |
| Điện áp đầu ra | 0-220 | V |
| Dòng điện đầu ra | 0-1.5 | A |
| Hệ số K_u | 22 | - |
| Hệ số K_i | ~100 | - |
| Hệ số K_p | ~2200 | - |

### Tính toán cụ thể:

**Ví dụ tính toán:**
```
Cho: U_in = 5V, U_out = 110V
=> K_u = 110/5 = 22

Cho: I_in = 0.01A, I_out = 1.0A
=> K_i = 1.0/0.01 = 100

=> K_p = 22 × 100 = 2200
```

### Ý nghĩa:
- Hệ số K_u cho biết khả năng khuếch đại điện áp của khuếch đại từ
- Hệ số K_i cho biết khả năng khuếch đại dòng điện
- Hệ số K_p thể hiện khả năng khuếch đại công suất tổng thể

---

## 3.1.2 - Xác định hằng số thời gian của các cuộn dây trong khuếch đại từ kép ПДД-1,5B

### Khái niệm
Hằng số thời gian (τ) đặc trưng cho độ trễ của hệ thống khi có tín hiệu đầu vào thay đổi.

**GIẢI THÍCH CHI TIẾT:**

Hằng số thời gian τ là một đại lượng quan trọng trong phân tích động học của hệ thống điện từ. Nó cho biết hệ thống cần bao lâu để đạt được 63.2% giá trị cuối cùng khi có tín hiệu đầu vào thay đổi đột ngột.

**Ý nghĩa vật lý:** 
- τ nhỏ → Hệ thống đáp ứng nhanh, nhạy cảm với thay đổi
- τ lớn → Hệ thống đáp ứng chậm, có quán tính lớn
- Trong khuếch đại từ, τ phụ thuộc vào cấu trúc từ và điện của cuộn dây

**Nguyên lý hoạt động:**
Khi có điện áp đặt vào cuộn dây, dòng điện không tăng ngay lập tức mà tăng dần theo hàm mũ do hiện tượng tự cảm. Hằng số thời gian τ quyết định tốc độ tăng này.

### Công thức tổng quát:
```
τ = L / R
```

**GIẢI THÍCH TỪNG KÝ HIỆU:**
- `τ` (tau): Hằng số thời gian (giây)
- `L`: Độ tự cảm của cuộn dây (Henry)
- `R`: Điện trở của cuộn dây (Ohm)

**CƠ SỞ VẬT LÝ:**
Công thức τ = L/R xuất phát từ phương trình vi phân của mạch RL:
```
L × (dI/dt) + R × I = U
```
Nghiệm của phương trình này có dạng:
```
I(t) = (U/R) × [1 - e^(-t/τ)]
```
Trong đó τ = L/R là hằng số thời gian.

**VÍ DỤ TÍNH TOÁN TỪNG BƯỚC:**

**Cuộn điều khiển:**
```
Cho: L_control = 1.5 H
     R_control = 300 Ω

Bước 1: Áp dụng công thức
τ_control = L_control / R_control

Bước 2: Thay số
τ_control = 1.5 / 300 = 0.005 s

Bước 3: Chuyển đổi đơn vị
τ_control = 0.005 s = 5 ms
```

**Cuộn công suất:**
```
Cho: L_power = 10 H
     R_power = 100 Ω

Bước 1: Áp dụng công thức
τ_power = L_power / R_power

Bước 2: Thay số
τ_power = 10 / 100 = 0.1 s

Bước 3: Chuyển đổi đơn vị
τ_power = 0.1 s = 100 ms
```

**KIỂM TRA KẾT QUẢ:**
- τ_control = 5ms << τ_power = 100ms
- Cuộn điều khiển đáp ứng nhanh hơn 20 lần
- Phù hợp với yêu cầu điều khiển nhanh, công suất ổn định

**ÁP DỤNG THỰC TẾ:**
- **Thiết kế:** Chọn L và R phù hợp để có τ mong muốn
- **Điều khiển:** τ nhỏ cho điều khiển nhanh, τ lớn cho ổn định
- **Bảo trì:** τ thay đổi có thể do hỏng hóc hoặc lão hóa
- **Tối ưu:** Cân bằng giữa tốc độ đáp ứng và độ ổn định

### Các cuộn dây trong ПДД-1,5B:

#### 1. Cuộn điều khiển (Control Winding):
```
τ_control = L_control / R_control
```

**Thông số điển hình:**
- L_control = 0.5 - 2.0 H
- R_control = 100 - 500 Ω
- **τ_control ≈ 0.005 - 0.010 s** (5-10 ms)

#### 2. Cuộn công suất (Power Winding):
```
τ_power = L_power / R_power
```

**Thông số điển hình:**
- L_power = 5.0 - 15.0 H
- R_power = 50 - 200 Ω
- **τ_power ≈ 0.05 - 0.15 s** (50-150 ms)

### Tính toán cụ thể:

**Ví dụ 1: Cuộn điều khiển**
```
Cho: L_control = 1.5 H
     R_control = 300 Ω

τ_control = 1.5 / 300 = 0.005 s = 5 ms
```

**Ví dụ 2: Cuộn công suất**
```
Cho: L_power = 10 H
     R_power = 100 Ω

τ_power = 10 / 100 = 0.1 s = 100 ms
```

### Đặc tính quá độ:

**Hàm truyền bậc 1:**
```
G(s) = K / (τs + 1)
```

**Đáp ứng bước (Step Response):**
```
y(t) = K × (1 - e^(-t/τ))
```

Trong đó:
- Tại t = τ: y = 63.2% × K
- Tại t = 3τ: y = 95% × K
- Tại t = 5τ: y = 99.3% × K (coi như ổn định)

### Thời gian đáp ứng:

| Cuộn dây | τ (ms) | 3τ (ms) | 5τ (ms) |
|----------|--------|---------|---------|
| Điều khiển | 5 | 15 | 25 |
| Công suất | 100 | 300 | 500 |

### Ý nghĩa:
- Hằng số thời gian nhỏ → Hệ thống đáp ứng nhanh
- Cuộn điều khiển có τ nhỏ → Điều khiển linh hoạt
- Cuộn công suất có τ lớn hơn → Ổn định nguồn ra

---

## 3.1.3 - Xác định diện áp ra của khuếch đại từ ở trạng thái ổn định

### Khái niệm
Điện áp ra ở trạng thái ổn định là điện áp đầu ra của khuếch đại từ khi hệ thống đã ổn định (không còn quá độ).

**GIẢI THÍCH CHI TIẾT:**

Trạng thái ổn định là trạng thái mà tất cả các đại lượng điện từ trong hệ thống đã đạt giá trị không đổi theo thời gian. Trong khuếch đại từ ПДД-1,5B, điều này có nghĩa là từ thông, dòng điện và điện áp đã ổn định sau khi có tín hiệu đầu vào.

**Ý nghĩa vật lý:**
- Điện áp ra ổn định phụ thuộc vào từ thông tổng hợp trong lõi từ
- Từ thông này được tạo bởi tổng hợp từ trường của các cuộn dây
- Do hiện tượng từ tính dư, ngay cả khi không có tín hiệu đầu vào, vẫn có điện áp ra nhỏ

**Đặc điểm quan trọng:**
- Điện áp ra không tỷ lệ tuyến tính hoàn toàn với đầu vào do bão hòa từ
- Có điện áp lệch (offset) do từ tính dư của lõi từ
- Phụ thuộc vào nhiệt độ và tần số từ hóa

### Công thức tính:

**1. Công thức tổng quát:**
```
U_out = K_u × U_in
```

**GIẢI THÍCH TỪNG KÝ HIỆU:**
- `U_out`: Điện áp đầu ra ở trạng thái ổn định (V)
- `K_u`: Hệ số khuếch đại điện áp (không đơn vị)
- `U_in`: Điện áp đầu vào (V)

**2. Công thức chi tiết hơn:**
```
U_out = (N₂/N₁) × √(Φ₁² + Φ₂² + 2×Φ₁×Φ₂×cos(θ))
```

**GIẢI THÍCH TỪNG KÝ HIỆU:**
- `N₁, N₂`: Số vòng dây cuộn sơ cấp và thứ cấp (vòng)
- `Φ₁, Φ₂`: Từ thông các cuộn (Wb)
- `θ`: Góc pha giữa các từ thông (rad)

**CƠ SỞ VẬT LÝ:**
Công thức này xuất phát từ định luật Faraday về cảm ứng điện từ:
```
E = -N × (dΦ/dt)
```
Trong đó từ thông tổng hợp Φ được tính từ tổng vector của các từ thông thành phần.

**VÍ DỤ TÍNH TOÁN TỪNG BƯỚC:**

**Trường hợp đơn giản (bỏ qua góc pha):**
```
Cho: N₁ = 100 vòng, N₂ = 2200 vòng
     Φ₁ = 0.01 Wb, Φ₂ = 0.22 Wb
     θ = 0° (cùng pha)

Bước 1: Tính tỷ số vòng dây
N₂/N₁ = 2200/100 = 22

Bước 2: Tính từ thông tổng hợp
Φ_tổng = Φ₁ + Φ₂ = 0.01 + 0.22 = 0.23 Wb

Bước 3: Tính điện áp ra
U_out = (N₂/N₁) × Φ_tổng = 22 × 0.23 = 5.06 V
```

**Trường hợp có góc pha:**
```
Cho: Φ₁ = 0.1 Wb, Φ₂ = 0.2 Wb, θ = 30°

Bước 1: Tính thành phần cos
cos(30°) = 0.866

Bước 2: Tính từ thông tổng hợp
Φ_tổng = √(0.1² + 0.2² + 2×0.1×0.2×0.866)
Φ_tổng = √(0.01 + 0.04 + 0.0346) = √0.0846 = 0.291 Wb

Bước 3: Tính điện áp ra
U_out = 22 × 0.291 = 6.4 V
```

**KIỂM TRA KẾT QUẢ:**
- Điện áp ra tăng khi từ thông tăng
- Góc pha ảnh hưởng đến từ thông tổng hợp
- Tỷ số vòng dây quyết định hệ số khuếch đại

**ÁP DỤNG THỰC TẾ:**
- **Thiết kế:** Chọn số vòng dây phù hợp để có điện áp ra mong muốn
- **Điều chỉnh:** Thay đổi từ thông để điều chỉnh điện áp ra
- **Kiểm tra:** Đo điện áp ra để đảm bảo hệ thống hoạt động đúng
- **Bảo trì:** Điện áp ra giảm có thể do lão hóa lõi từ hoặc hỏng cuộn dây

### Đối với ПДД-1,5B:

**Chế độ làm việc tuyến tính:**
```
U_out = K_u × U_in + U_offset
```

Trong đó:
- K_u = 22 (hệ số khuếch đại)
- U_offset = 10-20V (điện áp lệch do từ tính dư)

### Tính toán cụ thể:

**Trường hợp 1: Không tải (no-load)**
```
U_in = 0V
U_out = U_offset ≈ 15V
```

**Trường hợp 2: Tải định mức (rated load)**
```
U_in = 10V
U_out = 22 × 10 + 15 = 235V
```

**Trường hợp 3: Tải 50%**
```
U_in = 5V
U_out = 22 × 5 + 15 = 125V
```

### Đồ thị đặc tính:

```
U_out (V)
   |
240|        ●
   |       /
   |      /
   |     /
120|    ●
   |   /
   |  /
 15| ●___________
   |_____________ U_in (V)
   0    5      10
```

### Công thức xét đến bão hòa từ:

```
U_out = U_max × tanh(K_u × U_in / U_max)
```

Trong đó:
- U_max ≈ 240V (điện áp bão hòa)
- tanh: hàm tangent hyperbolic

### Bảng tra điện áp ra theo điện áp vào:

| U_in (V) | U_out lý tưởng (V) | U_out thực tế (V) | Ghi chú |
|----------|-------------------|-------------------|---------|
| 0 | 0 | 15 | Điện áp dư |
| 1 | 22 | 37 | Vùng tuyến tính |
| 2 | 44 | 59 | Vùng tuyến tính |
| 3 | 66 | 81 | Vùng tuyến tính |
| 4 | 88 | 103 | Vùng tuyến tính |
| 5 | 110 | 125 | Vùng tuyến tính |
| 6 | 132 | 147 | Vùng tuyến tính |
| 7 | 154 | 169 | Vùng tuyến tính |
| 8 | 176 | 191 | Vùng tuyến tính |
| 9 | 198 | 213 | Bắt đầu bão hòa |
| 10 | 220 | 235 | Gần bão hòa |

### Ý nghĩa:
- Điện áp ra tỷ lệ tuyến tính với điện áp vào trong vùng làm việc
- Có điện áp lệch do từ tính dư
- Cần tính đến hiện tượng bão hòa từ ở điện áp cao

---

## 3.1.4 - Xác định sức từ động của cuộn dây điều khiển YCM-2 (F₂)

### Khái niệm
Sức từ động (Magnetomotive Force - MMF) là đại lượng đặc trưng cho khả năng tạo ra từ trường của cuộn dây.

**GIẢI THÍCH CHI TIẾT:**

Sức từ động F là một đại lượng cơ bản trong từ học, tương tự như sức điện động trong điện học. Nó đặc trưng cho khả năng của cuộn dây tạo ra từ trường trong mạch từ.

**Ý nghĩa vật lý:**
- F càng lớn → Từ trường càng mạnh → Từ thông càng lớn
- F tỷ lệ thuận với số vòng dây và dòng điện
- F là nguyên nhân tạo ra từ trường, tương tự như điện áp tạo ra dòng điện

**Đơn vị đo:**
- Ampere-turn (At) hoặc A.vòng
- 1 At = 1 A × 1 vòng dây
- Đây là đơn vị chuẩn trong tính toán từ học

**Nguyên lý hoạt động:**
Khi có dòng điện chạy qua cuộn dây, nó tạo ra từ trường theo định luật Ampère. Sức từ động F chính là "áp lực" đẩy từ thông đi qua mạch từ.

### Công thức tính:

**1. Công thức cơ bản:**
```
F₂ = N₂ × I₂
```

**GIẢI THÍCH TỪNG KÝ HIỆU:**
- `F₂`: Sức từ động cuộn YCM-2 (At)
- `N₂`: Số vòng dây cuộn YCM-2 (vòng)
- `I₂`: Dòng điện qua cuộn YCM-2 (A)

**CƠ SỞ VẬT LÝ:**
Công thức này xuất phát từ định luật Ampère:
```
∮H·dl = I_total
```
Trong đó I_total = N × I là tổng dòng điện đi qua tất cả các vòng dây.

**VÍ DỤ TÍNH TOÁN TỪNG BƯỚC:**

**Ví dụ 1: Tính trực tiếp từ dòng điện**
```
Cho: N₂ = 1000 vòng
     I₂ = 1.0 A

Bước 1: Áp dụng công thức cơ bản
F₂ = N₂ × I₂

Bước 2: Thay số
F₂ = 1000 × 1.0 = 1000 At

Bước 3: Kiểm tra kết quả
F₂ = 1000 At có nghĩa là cuộn dây tạo ra sức từ động 1000 Ampere-turn
```

**Ví dụ 2: Tính từ điện áp và điện trở**
```
Cho: U₂ = 220V
     R₂ = 220 Ω
     N₂ = 1000 vòng

Bước 1: Tính dòng điện theo định luật Ohm
I₂ = U₂ / R₂ = 220 / 220 = 1.0 A

Bước 2: Tính sức từ động
F₂ = N₂ × I₂ = 1000 × 1.0 = 1000 At

Bước 3: Kiểm tra logic
Dòng điện 1A qua 1000 vòng dây tạo ra F₂ = 1000 At ✓
```

**Ví dụ 3: Tính với dòng điện khác**
```
Cho: N₂ = 1000 vòng
     I₂ = 0.5 A (50% tải)

Bước 1: Áp dụng công thức
F₂ = N₂ × I₂

Bước 2: Thay số
F₂ = 1000 × 0.5 = 500 At

Bước 3: So sánh với định mức
F₂_50% = 500 At = 50% × F₂_định_mức ✓
```

**KIỂM TRA KẾT QUẢ:**
- F₂ tỷ lệ thuận với cả N₂ và I₂
- Đơn vị At = A × vòng
- Giá trị hợp lý cho cuộn điều khiển máy phát

**ÁP DỤNG THỰC TẾ:**
- **Thiết kế:** Chọn N₂ và I₂ để có F₂ mong muốn
- **Điều khiển:** Thay đổi U₂ để điều chỉnh I₂ và F₂
- **Kiểm tra:** Đo I₂ để tính F₂ và đánh giá hiệu suất
- **Bảo trì:** F₂ giảm có thể do hỏng cuộn dây hoặc giảm điện áp nguồn

### Thông số cuộn YCM-2:

**Thông số điển hình:**
- Số vòng dây: N₂ = 800 - 1200 vòng
- Dòng điện định mức: I₂ = 0.5 - 1.5 A
- Điện áp định mức: U₂ = 220V
- Điện trở: R₂ = 150 - 300 Ω

### Tính toán cụ thể:

**Ví dụ 1: Chế độ định mức**
```
Cho: N₂ = 1000 vòng
     I₂ = 1.0 A

F₂ = 1000 × 1.0 = 1000 At
```

**Ví dụ 2: Từ điện áp định mức**
```
Cho: U₂ = 220V
     R₂ = 220 Ω
     
I₂ = U₂ / R₂ = 220 / 220 = 1.0 A

F₂ = N₂ × I₂ = 1000 × 1.0 = 1000 At
```

### Quan hệ F₂ với điện áp điều khiển:

```
F₂ = N₂ × (U₂/R₂) = (N₂/R₂) × U₂
```

Đặt: K_F2 = N₂/R₂ (hệ số sức từ động)

```
F₂ = K_F2 × U₂
```

### Ví dụ tính toán K_F2:

```
Cho: N₂ = 1000 vòng
     R₂ = 220 Ω

K_F2 = 1000 / 220 = 4.545 At/V

Khi U₂ = 220V:
F₂ = 4.545 × 220 = 1000 At
```

### Đặc tính F₂ theo điện áp:

| U₂ (V) | I₂ (A) | F₂ (At) | % F_max |
|--------|--------|---------|---------|
| 0 | 0 | 0 | 0% |
| 50 | 0.227 | 227 | 22.7% |
| 100 | 0.455 | 455 | 45.5% |
| 150 | 0.682 | 682 | 68.2% |
| 200 | 0.909 | 909 | 90.9% |
| 220 | 1.000 | 1000 | 100% |

### Ảnh hưởng của F₂ đến hệ thống:

**1. Điều khiển từ thông máy phát:**
```
Φ_MF = f(F₂ - F₁)
```

**2. Điều khiển điện áp máy phát:**
```
U_MF = K_Φ × Φ_MF = K_Φ × f(F₂ - F₁)
```

### Ý nghĩa:
- F₂ tỷ lệ thuận với dòng điện qua cuộn YCM-2
- F₂ điều khiển từ thông và điện áp máy phát
- Cuộn YCM-2 là cuộn điều khiển chính trong hệ thống

---

## 3.1.5 - Xác định sức từ động của cuộn YCM-1 (F₁)

### Khái niệm
Cuộn YCM-1 là cuộn phản hồi âm, tạo sức từ động ngược chiều với YCM-2 để ổn định hệ thống.

**GIẢI THÍCH CHI TIẾT:**

Cuộn YCM-1 có vai trò đặc biệt quan trọng trong hệ thống điều khiển máy phát. Nó hoạt động như một bộ phản hồi âm để tự động điều chỉnh điện áp máy phát khi tải thay đổi.

**Ý nghĩa vật lý:**
- YCM-1 tạo ra từ trường ngược chiều với YCM-2
- Khi tải tăng → I₁ tăng → F₁ tăng → Từ thông tổng giảm → Điện áp máy phát giảm
- Đây là cơ chế tự động ổn định điện áp

**Nguyên lý phản hồi âm:**
```
Tải tăng → I_tải tăng → I₁ tăng → F₁ tăng → F_tổng giảm → U_MF giảm
```
Điều này ngăn chặn điện áp máy phát tăng quá cao khi tải giảm.

**Đặc điểm thiết kế:**
- Số vòng dây ít hơn YCM-2 (N₁ < N₂)
- Dòng điện lớn hơn YCM-2 (I₁ > I₂)
- Mắc nối tiếp với mạch tải để phản ánh dòng tải

### Công thức tính:

**1. Công thức cơ bản:**
```
F₁ = N₁ × I₁
```

**GIẢI THÍCH TỪNG KÝ HIỆU:**
- `F₁`: Sức từ động cuộn YCM-1 (At)
- `N₁`: Số vòng dây cuộn YCM-1 (vòng)
- `I₁`: Dòng điện qua cuộn YCM-1 (A)

**2. Quan hệ với dòng tải:**
```
I₁ = α × I_tải
```

**GIẢI THÍCH TỪNG KÝ HIỆU:**
- `α`: Hệ số phân dòng (không đơn vị)
- `I_tải`: Dòng điện tải của máy phát (A)

**CƠ SỞ VẬT LÝ:**
Cuộn YCM-1 được mắc nối tiếp với mạch tải nên dòng điện qua nó tỷ lệ với dòng tải. Hệ số α phụ thuộc vào cách đấu dây và tỷ số biến dòng.

**VÍ DỤ TÍNH TOÁN TỪNG BƯỚC:**

**Ví dụ 1: Không tải**
```
Cho: I_tải = 0 A
     α = 0.1
     N₁ = 100 vòng

Bước 1: Tính dòng điện YCM-1
I₁ = α × I_tải = 0.1 × 0 = 0 A

Bước 2: Tính sức từ động
F₁ = N₁ × I₁ = 100 × 0 = 0 At

Bước 3: Ý nghĩa
Không tải → Không có phản hồi âm → Điện áp máy phát cao nhất
```

**Ví dụ 2: Tải 50%**
```
Cho: I_tải = 175 A (50% của 350A)
     α = 0.1
     N₁ = 100 vòng

Bước 1: Tính dòng điện YCM-1
I₁ = α × I_tải = 0.1 × 175 = 17.5 A

Bước 2: Tính sức từ động
F₁ = N₁ × I₁ = 100 × 17.5 = 1750 At

Bước 3: So sánh với YCM-2
F₁ = 1750 At > F₂ = 1000 At
→ Phản hồi âm mạnh → Điện áp máy phát giảm
```

**Ví dụ 3: Tải đầy**
```
Cho: I_tải = 350 A (100%)
     α = 0.1
     N₁ = 100 vòng

Bước 1: Tính dòng điện YCM-1
I₁ = α × I_tải = 0.1 × 350 = 35 A

Bước 2: Tính sức từ động
F₁ = N₁ × I₁ = 100 × 35 = 3500 At

Bước 3: Phân tích hệ thống
F_tổng = F₂ - F₁ = 1000 - 3500 = -2500 At
→ Phản hồi âm rất mạnh → Điện áp máy phát giảm đáng kể
```

**KIỂM TRA KẾT QUẢ:**
- F₁ tỷ lệ thuận với I_tải
- F₁ tăng khi tải tăng (phản hồi âm)
- Giá trị F₁ hợp lý cho cuộn phản hồi

**ÁP DỤNG THỰC TẾ:**
- **Thiết kế:** Chọn α và N₁ để có độ điều áp mong muốn
- **Điều chỉnh:** Thay đổi α để điều chỉnh độ nhạy phản hồi
- **Kiểm tra:** Đo I₁ để đánh giá hoạt động phản hồi
- **Bảo trì:** F₁ không đúng có thể do hỏng cuộn dây hoặc mạch phân dòng

### Thông số cuộn YCM-1:

**Thông số điển hình:**
- Số vòng dây: N₁ = 50 - 200 vòng (ít hơn YCM-2)
- Dòng điện: I₁ = 5 - 15 A (lớn hơn YCM-2)
- Kết nối: Nối tiếp với mạch tải

### Tính toán cụ thể:

**Ví dụ 1: Chế độ không tải**
```
I_tải = 0 A
=> I₁ = 0 A
=> F₁ = 0 At
```

**Ví dụ 2: Chế độ tải 50%**
```
Cho: N₁ = 100 vòng
     I_tải = 50 A
     α = 0.1

I₁ = 0.1 × 50 = 5 A
F₁ = 100 × 5 = 500 At
```

**Ví dụ 3: Chế độ tải đầy**
```
Cho: N₁ = 100 vòng
     I_tải = 100 A
     α = 0.1

I₁ = 0.1 × 100 = 10 A
F₁ = 100 × 10 = 1000 At
```

### Quan hệ F₁ với tải:

```
F₁ = N₁ × α × I_tải = K_F1 × I_tải
```

Trong đó: K_F1 = N₁ × α

### Ví dụ tính K_F1:

```
Cho: N₁ = 100 vòng
     α = 0.1

K_F1 = 100 × 0.1 = 10 At/A

Khi I_tải = 80A:
F₁ = 10 × 80 = 800 At
```

### Đặc tính F₁ theo dòng tải:

| I_tải (A) | I₁ (A) | F₁ (At) | % F_max |
|-----------|--------|---------|---------|
| 0 | 0 | 0 | 0% |
| 20 | 2 | 200 | 20% |
| 40 | 4 | 400 | 40% |
| 60 | 6 | 600 | 60% |
| 80 | 8 | 800 | 80% |
| 100 | 10 | 1000 | 100% |

### Sức từ động tổng hợp:

```
F_tổng = F₂ - F₁
```

**Ví dụ:**
```
F₂ = 1000 At (từ điều khiển)
F₁ = 600 At (từ phản hồi tải)
=> F_tổng = 1000 - 600 = 400 At
```

### Nguyên lý hoạt động:

1. **Không tải:** F₁ = 0 → F_tổng = F₂ (lớn nhất)
2. **Có tải:** F₁ tăng → F_tổng giảm → Điện áp máy phát giảm
3. **Tải nặng:** F₁ lớn → F_tổng nhỏ → Hạn chế quá tải

### Ý nghĩa:
- F₁ tạo phản hồi âm theo tải
- Giúp ổn định điện áp khi tải thay đổi
- Bảo vệ hệ thống khỏi quá tải

---

## 3.1.6 - Xác định sức từ động của cuộn YCM-6 (F₆)

### Khái niệm
Cuộn YCM-6 là cuộn kích từ độc lập, cung cấp từ thông ban đầu cho máy phát.

**GIẢI THÍCH CHI TIẾT:**

Cuộn YCM-6 có vai trò đặc biệt quan trọng trong hệ thống máy phát DC. Nó hoạt động như một nguồn từ thông cơ bản, độc lập với các cuộn điều khiển khác.

**Ý nghĩa vật lý:**
- YCM-6 tạo ra từ thông cố định, không phụ thuộc vào tải
- Cung cấp từ thông nền để máy phát có thể tự kích từ
- Đảm bảo máy phát luôn có từ thông tối thiểu để hoạt động

**Nguyên lý hoạt động:**
```
Nguồn DC độc lập → YCM-6 → Từ thông cố định → Điện áp máy phát cơ bản
```

**Đặc điểm quan trọng:**
- Độc lập với mạch điều khiển chính
- Không thay đổi theo tải
- Có thể điều chỉnh thủ công để tối ưu hệ thống
- Quan trọng cho quá trình khởi động máy phát

**So sánh với các cuộn khác:**
- YCM-2: Điều khiển chính (thay đổi theo tín hiệu)
- YCM-1: Phản hồi âm (thay đổi theo tải)
- YCM-6: Kích từ cơ bản (không đổi)

### Công thức tính:

**1. Công thức cơ bản:**
```
F₆ = N₆ × I₆
```

**GIẢI THÍCH TỪNG KÝ HIỆU:**
- `F₆`: Sức từ động cuộn YCM-6 (At)
- `N₆`: Số vòng dây cuộn YCM-6 (vòng)
- `I₆`: Dòng điện qua cuộn YCM-6 (A)

**2. Quan hệ với nguồn cấp:**
```
I₆ = U₆ / R₆
```

**GIẢI THÍCH TỪNG KÝ HIỆU:**
- `U₆`: Điện áp cấp cho YCM-6 (V)
- `R₆`: Điện trở cuộn YCM-6 (Ω)

**CƠ SỞ VẬT LÝ:**
Cuộn YCM-6 được cấp nguồn từ nguồn DC độc lập, thường là máy phát phụ hoặc chỉnh lưu riêng. Dòng điện qua cuộn này không đổi và không phụ thuộc vào tải của máy phát chính.

**VÍ DỤ TÍNH TOÁN TỪNG BƯỚC:**

**Ví dụ 1: Tính từ thông số định mức**
```
Cho: N₆ = 600 vòng
     U₆ = 110V DC
     R₆ = 110 Ω

Bước 1: Tính dòng điện theo định luật Ohm
I₆ = U₆ / R₆ = 110 / 110 = 1.0 A

Bước 2: Tính sức từ động
F₆ = N₆ × I₆ = 600 × 1.0 = 600 At

Bước 3: Ý nghĩa
F₆ = 600 At cung cấp từ thông cơ bản cho máy phát
```

**Ví dụ 2: Tính với điện áp khác**
```
Cho: N₆ = 600 vòng
     U₆ = 55V DC (50% điện áp)
     R₆ = 110 Ω

Bước 1: Tính dòng điện
I₆ = U₆ / R₆ = 55 / 110 = 0.5 A

Bước 2: Tính sức từ động
F₆ = N₆ × I₆ = 600 × 0.5 = 300 At

Bước 3: So sánh với định mức
F₆_50% = 300 At = 50% × F₆_định_mức
```

**Ví dụ 3: Tính với điện trở khác**
```
Cho: N₆ = 600 vòng
     U₆ = 110V DC
     R₆ = 137.5 Ω (tăng 25%)

Bước 1: Tính dòng điện
I₆ = U₆ / R₆ = 110 / 137.5 = 0.8 A

Bước 2: Tính sức từ động
F₆ = N₆ × I₆ = 600 × 0.8 = 480 At

Bước 3: Phân tích ảnh hưởng
F₆ giảm 20% → Từ thông cơ bản giảm → Điện áp máy phát giảm
```

**KIỂM TRA KẾT QUẢ:**
- F₆ tỷ lệ thuận với U₆ và tỷ lệ nghịch với R₆
- F₆ không phụ thuộc vào tải máy phát
- Giá trị F₆ hợp lý cho cuộn kích từ cơ bản

**ÁP DỤNG THỰC TẾ:**
- **Thiết kế:** Chọn U₆ và R₆ để có F₆ mong muốn
- **Điều chỉnh:** Thay đổi U₆ hoặc R₆ để điều chỉnh F₆
- **Kiểm tra:** Đo I₆ để đánh giá hoạt động cuộn kích từ
- **Bảo trì:** F₆ giảm có thể do hỏng nguồn cấp hoặc cuộn dây

### Thông số cuộn YCM-6:

**Thông số điển hình:**
- Số vòng dây: N₆ = 500 - 800 vòng
- Dòng điện: I₆ = 0.5 - 1.0 A (dòng không đổi)
- Điện áp: U₆ = 110V DC
- Điện trở: R₆ = 100 - 150 Ω

### Tính toán cụ thể:

**Ví dụ 1:**
```
Cho: N₆ = 600 vòng
     U₆ = 110V
     R₆ = 110 Ω

I₆ = 110 / 110 = 1.0 A
F₆ = 600 × 1.0 = 600 At
```

**Ví dụ 2:**
```
Cho: N₆ = 800 vòng
     U₆ = 110V
     R₆ = 137.5 Ω

I₆ = 110 / 137.5 = 0.8 A
F₆ = 800 × 0.8 = 640 At
```

### Đặc điểm của F₆:

**1. Không đổi theo thời gian:**
```
F₆ = const (hằng số)
```

**2. Không phụ thuộc tải:**
```
dF₆/dI_tải = 0
```

**3. Có thể điều chỉnh thủ công:**
```
F₆ = (N₆/R₆) × U₆
```
Bằng cách thay đổi U₆ hoặc R₆ (biến trở)

### So sánh các cuộn dây:

| Cuộn | Số vòng | Dòng (A) | F (At) | Chức năng |
|------|---------|----------|--------|-----------|
| YCM-1 | 100 | 0-10 | 0-1000 | Phản hồi tải |
| YCM-2 | 1000 | 0-1.0 | 0-1000 | Điều khiển chính |
| YCM-6 | 600 | 1.0 | 600 | Kích từ độc lập |

### Sức từ động tổng hợp trong máy phát:

```
F_tổng = F₂ - F₁ + F₆
```

hoặc (tùy cách đấu dây):

```
F_tổng = F₂ - F₁ - F₆
```

### Ví dụ tổng hợp:

**Trường hợp 1: Không tải**
```
F₂ = 1000 At
F₁ = 0 At
F₆ = 600 At
=> F_tổng = 1000 - 0 + 600 = 1600 At
```

**Trường hợp 2: Tải 50%**
```
F₂ = 1000 At
F₁ = 500 At
F₆ = 600 At
=> F_tổng = 1000 - 500 + 600 = 1100 At
```

**Trường hợp 3: Tải đầy**
```
F₂ = 1000 At
F₁ = 1000 At
F₆ = 600 At
=> F_tổng = 1000 - 1000 + 600 = 600 At
```

### Vai trò của F₆:

1. **Tạo từ thông ban đầu** để máy phát tự kích từ
2. **Ổn định điện áp** khi tải thay đổi lớn
3. **Bù trừ sự suy giảm** từ thông do F₁

### Điều chỉnh F₆:

**Phương pháp 1: Thay đổi U₆**
```
F₆ = (N₆/R₆) × U₆

U₆: 0 → 220V
=> F₆: 0 → 1200 At
```

**Phương pháp 2: Thay đổi R₆ (biến trở)**
```
R₆: 50 → 200 Ω
=> I₆: 2.2 → 0.55 A
=> F₆: 1320 → 330 At
```

### Ý nghĩa:
- F₆ cố định, không phụ thuộc tải
- Tạo từ trường nền cho máy phát
- Có thể điều chỉnh để tối ưu hệ thống
- Quan trọng cho quá trình khởi động máy phát

---

## TÓM TẮT PHẦN 1

### Bảng tổng hợp các thông số đã tính:

| Thông số | Ký hiệu | Giá trị điển hình | Đơn vị |
|----------|---------|-------------------|--------|
| Hệ số khuếch đại điện áp | K_u | 22 | - |
| Hệ số khuếch đại dòng | K_i | 100 | - |
| Hệ số khuếch đại công suất | K_p | 2200 | - |
| Hằng số thời gian cuộn ĐK | τ_control | 5-10 | ms |
| Hằng số thời gian cuộn CS | τ_power | 50-150 | ms |
| Điện áp ra ổn định | U_out | 0-240 | V |
| Sức từ động YCM-2 | F₂ | 0-1000 | At |
| Sức từ động YCM-1 | F₁ | 0-1000 | At |
| Sức từ động YCM-6 | F₆ | 600 | At |

### Các công thức quan trọng:

1. **Hệ số khuếch đại:** K = Y_out / X_in
2. **Hằng số thời gian:** τ = L / R
3. **Điện áp ra:** U_out = K_u × U_in + U_offset
4. **Sức từ động:** F = N × I
5. **Sức từ động tổng:** F_tổng = F₂ - F₁ + F₆

### Lưu ý khi áp dụng:

- Các giá trị trên là điển hình, cần đo đạc thực tế cho chính xác
- Chú ý đến hiện tượng bão hòa từ ở dải cao
- Xét đến nhiệt độ ảnh hưởng đến điện trở
- Kiểm tra chiều đấu dây các cuộn YCM

---

**HẾT PHẦN 1**

Tiếp theo: [Phần 2 - Tính toán 3.1.7 đến 3.1.12](chuong3_phan2.md)

