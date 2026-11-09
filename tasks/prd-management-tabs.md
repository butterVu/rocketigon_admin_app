# PRD: Khung feature quản lý Đồ ăn, Thuê xe và Tài chính

## 1. Tổng quan

Tạo khung presentation cho ba feature quản lý: **Đồ ăn**, **Thuê xe** và
**Tài chính**. Mỗi feature nằm trực tiếp trong `lib/features/` và được truy cập
qua một tab trên màn hình Root hiện có.

Phạm vi hiện tại chỉ chuẩn bị màn hình và cấu trúc để phát triển sau này.
Không triển khai nghiệp vụ quản lý, dữ liệu hoặc kết nối API.

## 2. Mục tiêu

- Có đúng ba feature mới: `food`, `car_rental` và `finance`.
- Mỗi feature có view, GetX controller và binding riêng.
- Người dùng chuyển đến từng feature bằng tab tương ứng trên Root.
- Mỗi màn hình hiển thị đúng tiêu đề tiếng Việt của feature.
- Không tạo tầng `domain` hoặc `data` cho ba feature này.

## 3. User stories

- Là người dùng ứng dụng quản trị, tôi muốn chọn tab Đồ ăn để mở màn hình
  quản lý Đồ ăn được chuẩn bị cho các chức năng trong tương lai.
- Là người dùng ứng dụng quản trị, tôi muốn chọn tab Thuê xe để mở màn hình
  quản lý Thuê xe.
- Là người dùng ứng dụng quản trị, tôi muốn chọn tab Tài chính để mở màn hình
  quản lý Tài chính.

## 4. Yêu cầu chức năng

1. Tạo ba thư mục feature trực tiếp trong `lib/features/`:
   `food/`, `car_rental/` và `finance/`.
2. Mỗi feature có tầng `presentation/` với các thư mục `views/`,
   `controllers/` và `bindings/`; mỗi thư mục chứa thành phần tương ứng.
3. View của từng feature chỉ hiển thị tiêu đề: “Đồ ăn”, “Thuê xe” hoặc
   “Tài chính”. Không bổ sung danh sách mẫu, biểu mẫu, số liệu hoặc thao tác
   nghiệp vụ.
4. Mỗi controller kế thừa `GetxController`. Không thêm trạng thái hoặc logic
   nghiệp vụ giả để lấp đầy cấu trúc.
5. Mỗi binding đăng ký controller của feature theo quy ước GetX của dự án.
6. Thêm ba mục điều hướng vào hệ thống tab của màn hình Root hiện có, theo
   thứ tự tương đối: Đồ ăn, Thuê xe, Tài chính.
7. Chọn tab phải mở đúng view, cập nhật trạng thái tab được chọn và bảo đảm
   controller được đăng ký trước khi view sử dụng.
8. Giữ nguyên hành vi và các mục điều hướng hiện có của Root. Không đổi tab
   mặc định chỉ để phục vụ các feature mới.
9. Tái sử dụng cách điều hướng và quản lý vòng đời tab hiện có. Không yêu cầu
   đường dẫn độc lập hoặc deep link cho ba màn hình trong phạm vi này.

### Tiêu chí nghiệm thu

- Từ Root, chọn lần lượt ba tab và thấy đúng tiêu đề tương ứng.
- Chuyển qua lại giữa các tab không gây lỗi thiếu controller hoặc đăng ký
  trùng dependency.
- Các tab hiện có vẫn truy cập được và giữ hành vi hiện tại.
- Cả ba feature có đủ view, controller, binding và không có `domain/`,
  `data/`, entity, repository, use case, model hoặc data source mới.
- Không có yêu cầu mạng phát sinh khi mở ba tab.
- Các tệp Dart thay đổi được định dạng và vượt qua kiểm tra phân tích tĩnh;
  ghi rõ nếu có lỗi tồn tại từ trước hoặc kiểm tra không chạy được.

## 5. Ngoài phạm vi

- CRUD, tìm kiếm, lọc, phân trang hoặc duyệt dữ liệu quản lý.
- Nghiệp vụ món ăn, thuê xe, giao dịch, thu chi hoặc báo cáo tài chính.
- Tầng domain và data, API, dữ liệu giả, lưu trữ hoặc sinh mã.
- Feature thứ tư.
- Thay đổi đăng nhập, phân quyền hoặc thiết kế lại Root.

## 6. Thiết kế

- Theo theme, Dragon Design và cách trình bày tab hiện có của ứng dụng.
- Nhãn tab dùng chính xác: “Đồ ăn”, “Thuê xe”, “Tài chính”.
- Dùng biểu tượng phù hợp từ bộ biểu tượng hiện có nếu Root yêu cầu icon.
- Màn hình tối giản, chỉ có tiêu đề; tránh lặp tiêu đề nếu shell của Root
  đã cung cấp tiêu đề cho nội dung đang chọn.

## 7. Ràng buộc kỹ thuật

- Tuân thủ `AGENTS.md` và `docs/rules/core.md`. Việc chỉ tạo presentation là
  giới hạn phạm vi đã được người dùng xác nhận cho yêu cầu này.
- Dùng GetX view, controller và binding theo quy ước dự án; không tạo
  controller trong `build()`.
- Không thêm package mới cho khung feature này.
- Trước khi triển khai, kiểm tra cấu trúc Root bằng GitNexus và chạy impact
  cho các symbol cần sửa; báo cáo callers, processes và risk theo hướng dẫn
  của dự án. PRD này chưa xác minh cấu trúc hoặc tác động của code hiện tại.
- Dùng FVM khi có sẵn để format, analyze và chạy kiểm tra phù hợp với phần
  điều hướng thay đổi.

## 8. Đo lường thành công

- 3/3 feature có cấu trúc presentation đầy đủ.
- 3/3 tab trên Root mở đúng màn hình.
- Không có tầng data/domain hoặc tích hợp API mới.
- Không phát sinh lỗi phân tích tĩnh hoặc lỗi điều hướng do thay đổi này.

## 9. Câu hỏi còn mở

Không còn câu hỏi về phạm vi sản phẩm. Vị trí chèn tab, biểu tượng và cách
gắn binding cụ thể sẽ theo cấu trúc Root hiện có khi triển khai; giữ nguyên
thứ tự tương đối của các tab cũ và của ba tab mới.
