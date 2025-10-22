> TRƯỜNG ĐẠI HỌC VINH
>
> **VIỆN KỸ THUẬT VÀ CÔNG NGHỆ**
>
> **ĐỒ ÁN 1**
>
> **CHUYÊN NGÀNH KỸ THUẬT ĐIỀU KHIỂN VÀ TỰ ĐỘNG HÓA**
>
> **ĐỀ TÀI**
>
> **NGHIÊN CỨU THIẾT KẾ MÁY XÚC ĐIỀU KHIỂN TỰ ĐỘNG**
>
> **Giảng viên hướng dẫn:**
>
> **Sinh viên thực hiện:**
>
> **HOÀNG VĂN DŨNG ( MSV: 235752021610063 )**
>
> **NGUYỄN CÔNG HOÀNG ( MSV:** **235752021610013 )**
>
> **LÊ HOÀNG VIẾT DŨNG ( MSV: 235752021610104** )
>
> **VÕ CÔNG ĐỨC ( MSV:** **235752021610102 )**
>
> **NGHỆ AN 2025**
>
> **BÁO CÁO TUẦN 1**
>
> **MỤC TIÊU TUẦN 1**
>
> **Tìm hiểu nguyên lý hoạt động cơ bản của máy xúc.**
>
> **Nghiên cứu các phương pháp điều khiển tự động (cơ -- điện -- thủy
> lực -- lập trình vi điều khiển).**
>
> **Thu thập tài liệu và xác định yêu cầu mô hình cần xây dựng.**
>
> **2. Công việc đã thực hiện**
>
> **Tìm hiểu cấu tạo chính của máy xúc: cần, tay gầu, gầu, khung, hệ
> truyền động.**
>
> **Nghiên cứu sơ bộ các loại cơ cấu chấp hành có thể sử dụng cho mô
> hình:**
>
> **Servo motor (cho các khớp nhỏ, chính xác).**
>
> **Động cơ DC + cơ cấu vít me hoặc bánh răng.**
>
> **Khảo sát các giải pháp điều khiển:**
>
> **Điều khiển thủ công bằng tay cầm (joystick).**
>
> **Điều khiển bán tự động qua vi điều khiển (Arduin, ESP32).**
>
> **Hướng tới điều khiển tự động theo lập trình sẵn.**
>
> **Thu thập các tài liệu, hình ảnh, video về mô hình máy xúc mini.**
>
> **3. Kết quả đạt được**
>
> **Đã có cái nhìn tổng quan về cấu tạo và nguyên lý máy xúc.**
>
> **Xác định được hướng tiếp cận: sử dụng Arduino + Servo motor cho các
> khớp để đảm bảo tính đơn giản, dễ lập trình.**
>
> **Lập danh sách linh kiện sơ bộ cần chuẩn bị:**
>
> **Raspberry tpi4 8gb**
>
> **Servo MG995 (hoặc loại tương đương).**
>
> **Nguồn cấp 5--6V.**
>
> **Khung mô hình (in 3D hoặc chế tạo cơ khí).**
>
> **Khó khăn gặp phải**
>
> **Chưa thống nhất được tỷ lệ kích thước mô hình.**
>
> **Việc lựa chọn servo cần tính toán lực kéo phù hợp để nâng gầu.**
>
> **Thiếu tài liệu chi tiết về sơ đồ lắp ráp cơ khí.**
>
> **Kế hoạch tuần sau**
>
> **Vẽ sơ đồ khối hệ thống điều khiển.**
>
> **Hoàn thành thiết kế 3D hoặc bản vẽ sơ bộ mô hình.**
>
> **MỤC TIÊU TUẦN 2**
>
> **1. Công việc đã thực hiện**
>
> **1.1. Xây dựng sơ đồ khối hệ thống điều khiển**
>
> **Khối chức năng Thành phần dự kiến Nhiệm vụ**
>
> **Bộ xử lý trung tâm Arduino Uno / STM32F103C8T6 Nhận lệnh và điều
> khiển toàn hệ thống**
>
> **Khối nguồn Adapter 12V + Module giảm áp 5V Cung cấp điện cho động cơ
> và vi điều khiển**
>
> **Khối truyền động Servo MG996R + DC/Step motor Tạo chuyển động cơ
> học**
>
> **Khối cảm biến Cảm biến góc, siêu âm Phản hồi vị trí và khoảng cách**
>
> **Khối giao tiếp Bluetooth HC-05 / Joystick Điều khiển thủ công và
> truyền lệnh**
>
> **1.2. Lựa chọn linh kiện phần cứng**
>
> **Hạng mục Lựa chọn Lý do**
>
> **Vi điều khiển Arduino Uno Lập trình đơn giản, dễ mua, có nhiều tài
> liệu**
>
> **Servo MG996R (x4) Mô-men xoắn mạnh, phù hợp điều khiển cổ tay và
> gầu**
>
> **Động cơ di chuyển DC motor + hộp số / Motor bánh xích Mô phỏng
> chuyển động xe xúc**
>
> **Cảm biến HC-SR04 / Potentiometer Đo khoảng cách hoặc vị trí góc**
>
> **Điều khiển tay Joystick + Bluetooth Hỗ trợ chế độ bán tự động**
>
> **1.3. Thiết kế mô hình 3D**
>
> **- Đã phác thảo cấu trúc sơ bộ bằng SolidWorks**
>
> ![](media/image2.jpeg){width="2.6875in" height="1.7025393700787401in"}
> ![](media/image3.jpeg){width="2.361123140857393in"
> height="1.7395833333333333in"}
>
> ![](media/image4.jpeg){width="2.7083333333333335in"
> height="1.9947922134733158in"}
>
> **- Khung chính chia thành 3 phần: đế xoay, cần chính, tay gầu.**
>
> **1.4. Nghiên cứu thuật toán điều khiển**
>
> **- Cơ chế điều khiển dạng chuỗi chuyển động (motion sequence).**
>
> **- Mỗi thao tác như đào → nâng → xoay → đổ sẽ được lập trình thành
> macro lệnh tự động.**
>
> **- Dự kiến dùng cấu trúc state machine (máy trạng thái) để quản lý
> quy trình.**
>
> **2. Khó khăn gặp phải**
>
> **Vấn đề Nguyên nhân Hướng xử lý**
>
> **Chưa quyết định chính xác loại động cơ di chuyển Cân nhắc giữa DC
> motor và motor bánh xích đồng bộ Thử nghiệm 2 phương án trong tuần
> tiếp theo**
>
> **Servo MG996R có thể chưa đủ mô-men xoắn ở một số khớp Thiếu tải
> trọng thực tế để kiểm tra Tính toán lại lực cần thiết và cân nhắc thêm
> trợ lực**
>
> **KẾ HOẠCH TUẦN 3**
>
> **- Hoàn thiện bản vẽ 3D chi tiết.**
>
> **- Mua linh kiện**
>
> **- Viết code điều khiển thử nghiệm cho 1 khớp servo.**
>
> **- Làm báo cáo mô phỏng chuyển động đơn giản.**
>
> **1. Công việc đã thực hiện**
>
> **1.1. Hoàn thiện bản vẽ 3D mô hình**
>
> **- Sử dụng SolidWorks / Fusion 360 để hoàn chỉnh mô hình khung máy
> xúc.**
>
> **- Các chi tiết được thiết kế theo dạng module rời (đế -- thân -- cần
> -- gầu).**
>
> **- Đã cân nhắc vị trí đặt động cơ và dây dẫn để dễ bảo trì.**
>
> **1.2. Mua sắm linh kiện**
>
> **Linh kiện Số lượng Tình trạng Ghi chú**
>
> **Arduino Uno R3 1 Đã mua Kiểm tra hoạt động tốt**
>
> **Servo MG996R 4 Đã mua Chuẩn bị test lực kéo**
>
> **Module nguồn 5V-12V 1 Đã mua Chưa đấu nối**
>
> **Motor DC + bánh xích 2 Đang đặt mua Chờ giao hàng**
>
> **Bluetooth HC-05 1 Đã mua Dùng cho điều khiển tay**
>
> **Mô Hình Máy Xúc ( Đã mua )**
>
> ![](media/image5.jpeg){width="4.21875in"
> height="4.3197080052493435in"}
>
> **1.3. Lập trình thử nghiệm servo**
>
> **- Viết chương trình điều khiển servo nâng hạ cần.**
>
> **- Thử nghiệm thành công dao động góc từ 0° đến 120° mượt mà.**
>
> **2. Khó khăn và hướng khắc phục**
>
> **Khó khăn Nguyên nhân Hướng xử lý**
>
> **Mô-men xoắn servo hơi yếu khi gắn tải Cần, gầu hơi nặng so với lý
> thuyết Giảm trọng lượng hoặc thêm trợ lực lò xo**
>
> **Dây nối nguồn và servo bị rối Lắp ráp tạm thời chưa tối ưu Bó dây
> lại và cố định theo máng dẫn**
>
> **3. Kế hoạch tuần 4**
>
> **- Lập trình điều khiển cho tất cả các khớp chuyển động.**
>
> **- Xây dựng chế độ điều khiển bán tự động hoàn chỉnh.**
>
> **- Cố định các động cơ, servo, dây dẫn theo thiết kế.**
>
> **1.** **Hoàn thiện lắp ráp cơ khí**
>
> **- Gắn cố định các bộ phận: đế, cần, gầu, khớp xoay.**
>
> **- Motor di chuyển đã được lắp với bánh xích và khung xe.**
>
> **2.** **Bố trí dây dẫn**
>
> **- Dây nguồn và dây tín hiệu được bó gọn, tách riêng để giảm nhiễu.**
>
> **- Kiểm tra điện áp ổn định (5V cho Arduino & Servo, 12V cho
> Motor).**
>
> **- Xây dựng trạng thái bán tự động: gầu đào → nâng cần → xoay → đổ.**
>
> **3 Thử nghiệm hệ thống**
>
> **- Thử nghiệm thành công chế độ điều khiển tay.**
>
> **- Thử nghiệm chế độ bán tự động hoạt động đúng chu trình cơ bản.**
>
> **- Ghi nhận cần tinh chỉnh thời gian delay giữa các khâu để mượt
> hơn.**
>
> **4 Khó khăn và hướng khắc phục**
>
> **Khó khăn Nguyên nhân Hướng xử lý**
>
> **Servo gầu đôi lúc quá tải Trọng lượng gầu và vật liệu Dùng servo lực
> mạnh hơn hoặc thêm trợ lực lò xo**
>
> **Motor di chuyển bị trượt khi tải nặng Bánh xích không bám tốt Tăng
> ma sát, bọc cao su hoặc thay bánh xích chất lượng hơn**
>
> **Dây nguồn bị nóng khi chạy lâu Dòng cấp chưa đủ Dùng dây to hơn và
> kiểm tra nguồn cấp dòng tối đa**
>
> **5 Kế hoạch tuần 5**
>
> **- Hoàn thiện chế độ tự động toàn phần.**
>
> **- Điều khiển servo và motor.**
>
> **- Tính toán cụ thể các chi tiết.**
>
> **- Chuẩn bị word slide thuyết trình sơ bộ.**
