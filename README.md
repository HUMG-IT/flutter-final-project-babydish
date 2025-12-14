# Bài tập lớn - Phát triển ứng dụng với Flutter

## Thông tin sinh viên
- **Họ và tên**: Hoàng Tuấn Anh
- **MSSV**: 2221050179
- **Lớp**: DCCTCLC67A
- **Học phần**: Phát triển ứng dụng di động đa nền tảng

---

## 1. Giới thiệu Đề tài
**Tên ứng dụng:** AI Lab Manager (Ứng dụng Quản lý Thiết bị Phòng Lab AI)

**Mô tả:**
Đây là ứng dụng di động được xây dựng bằng Flutter nhằm giải quyết vấn đề quản lý kho thiết bị phần cứng (GPU, Kit nhúng, Cảm biến, v.v.) trong các phòng Lab AI. Ứng dụng cho phép người dùng theo dõi số lượng, tình trạng hoạt động của thiết bị và đồng bộ dữ liệu theo thời gian thực (Real-time).

**Mô tả quá trình phát triển**
Quá trình xây dựng ứng dụng **AI Lab Manager** được chia thành các giai đoạn cụ thể:
1.  **Phân tích & Thiết kế:** Xác định yêu cầu quản lý thiết bị, thiết kế Model dữ liệu (`Device`) và giao diện người dùng (UI) trên giấy và Figma.
2.  **Xây dựng Giao diện (UI):** Sử dụng Flutter để code các màn hình danh sách, thêm/sửa và các Widget hiển thị trạng thái.
3.  **Tích hợp Backend:** Kết nối ứng dụng với **Firebase Firestore**. Chuyển đổi từ dữ liệu local sang dữ liệu đám mây (Cloud) để hỗ trợ đồng bộ thời gian thực (Real-time).
4.  **Quản lý trạng thái:** Áp dụng **Provider** để tách biệt logic xử lý khỏi giao diện, giúp code sạch và dễ bảo trì.
5.  **Kiểm thử & Tối ưu:** Viết Unit Test và Widget Test. Cấu hình CI/CD để tự động hóa quy trình kiểm tra lỗi.

---

## 2. Các chức năng chính (Features)
Ứng dụng đáp ứng đầy đủ các tiêu chí CRUD và quản lý trạng thái nâng cao:

1.  **Quản lý danh sách (Read):**
    * Hiển thị danh sách thiết bị trực quan với thông tin chi tiết (Tên, Loại, Số lượng).
    * Phân loại trạng thái thiết bị bằng màu sắc (Xanh: Hoạt động tốt, Đỏ: Hỏng/Bảo trì).
    * Tự động cập nhật dữ liệu khi có thay đổi từ server (Real-time).

2.  **Thêm mới thiết bị (Create):**
    * Form nhập liệu có xác thực (Validation) để đảm bảo dữ liệu đúng chuẩn.
    * Hỗ trợ nhập tên, loại, số lượng và trạng thái hoạt động.

3.  **Cập nhật thông tin (Update):**
    * Cho phép chỉnh sửa toàn bộ thông tin của thiết bị đã có.

4.  **Xóa thiết bị (Delete):**
    * Xóa thiết bị khỏi cơ sở dữ liệu.
    * Có hộp thoại (Dialog) xác nhận trước khi xóa để tránh thao tác nhầm.

---

## 3. Công nghệ và Thư viện sử dụng
Dự án áp dụng các công nghệ hiện đại theo yêu cầu đề bài:

* **Framework:** Flutter (Dart).
* **State Management:** `provider` (Quản lý trạng thái ứng dụng hiệu quả, tách biệt Logic và UI).
* **Backend / Database:** `firebase_core`, `cloud_firestore` (Lưu trữ dữ liệu đám mây NoSQL, hỗ trợ đồng bộ thời gian thực).
* **`uuid`**: Để sinh khóa chính (ID) duy nhất cho từng thiết bị.
* **`intl`**: Để định dạng hiển thị ngày tháng và số liệu.
* **`cupertino_icons`**: Bộ icon chuẩn cho giao diện đẹp mắt.
* **Testing:** `flutter_test` (Thư viện kiểm thử mặc định của Flutter).
* **CI/CD:** GitHub Actions (Tự động hóa quy trình Build và Test).

---

## 4. Hướng dẫn cài đặt và Chạy ứng dụng

Thầy có thể kiểm tra ứng dụng bằng cách thực hiện các bước sau:

### Bước 1: Tải mã nguồn
```bash
git clone [https://github.com/HUMG-IT/flutter-final-project-babydish.git](https://github.com/HUMG-IT/flutter-final-project-babydish.git)
cd flutter-final-project-babydish
```

### Bước 2: Cài đặt thư viện
```bash
flutter pub get
```
### Bước 3: Chạy ứng dụng
```bash
flutter run
```

## 5. Kết quả Kiểm thử (Testing) & CI/CD
### Kiểm thử tự động

- Dự án bao gồm các bài kiểm thử Đơn vị (Unit Test) và Giao diện (Widget Test) nằm trong thư mục test/.

- Unit Test (test/device_test.dart): Kiểm tra logic của Device Model (tạo đối tượng, chuyển đổi JSON/Map).

- Widget Test (test/widget_test.dart): Kiểm tra khả năng render của giao diện người dùng cơ bản.

Cách chạy kiểm thử:
```bash
flutter test
```
Kết quả mong đợi: All tests passed.

CI/CD với GitHub Actions
File cấu hình workflow nằm tại: .github/workflows/ci.yml

Hệ thống tự động kích hoạt mỗi khi có code được đẩy lên nhánh main.

Trạng thái hiện tại:  Build Success (Đã vượt qua tất cả các bài test trên môi trường Ubuntu-latest).