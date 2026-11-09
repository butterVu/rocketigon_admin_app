# PRD: Cập nhật API phần Auth theo tài liệu backend

Tài liệu nguồn: `/home/ubuntu/Documents/rocket/gozon-backend/docs/auth-api.md` (cập nhật 2026-10-13; trùng bản trên artifact "Gozon API Docs"). Chuẩn response: `docs/api-response.md` cùng thư mục.
App tham chiếu: `/home/ubuntu/Documents/rocket/gozon_client_flutter` (đã cập nhật theo tài liệu này).

## 1. Tổng quan

Backend auth đã đổi: mọi request đăng ký, đăng nhập, quên mã phải gửi `app` (role của app), bước tạo phiên nên gửi `deviceName`, và có thêm mã lỗi mới (`AUTH_WRONG_APP`, `LOGIN_CODE_UNCHANGED`, `AUTH_SESSION_CHECK_UNAVAILABLE`/503). Auth của rocketigo_admin được viết trước các thay đổi này nên: không gửi `app`, không gửi `deviceName`, và không phân biệt các lỗi mới (hiện rơi vào lỗi chung).

Mục tiêu: luồng auth hiện có của rocket khớp tài liệu backend, tương tự `gozon_client_flutter`.

## 2. Goals

- Mọi endpoint cần `app` đều gửi `app = customer`.
- Đăng ký, đăng nhập, xác nhận thiết bị và đặt lại mã gửi `deviceName` (model máy, tối đa 100 ký tự), không bắt buộc.
- Ba mã lỗi mới hiện đúng thông báo, không rơi vào "lỗi không xác định".
- Có test chạy được cho request body và ánh xạ lỗi, thay cho kiểm tra tay.

## 3. User stories

- Là khách hàng, khi nhập số điện thoại của tài xế hoặc chủ quán vào app khách, tôi muốn thấy "Số điện thoại này thuộc app Tài xế…" để biết dùng sai app.
- Là khách hàng, tôi muốn danh sách "thiết bị tin cậy" hiển thị tên máy của tôi (ví dụ `Samsung SM-S921B`) để nhận ra thiết bị.
- Là khách hàng, khi hệ thống kiểm tra phiên bị tạm lỗi (503), tôi muốn app báo "Hệ thống đang bận, vui lòng thử lại" mà không đăng xuất tôi.

## 4. Yêu cầu chức năng

### 4.1 Gửi `app`

1. `AppConstants.appRole = 'customer'` (`lib/core/constants/app_constants.dart`).
2. Gửi `app` trong body của: `POST /auth/register/otp`, `/auth/register/verify`, `/auth/login`, `/auth/login-code/forgot/verify`.
3. Không gửi `app` ở `/auth/login-code/forgot/otp` (tài liệu: body chỉ có `phone`), `/auth/register/complete`, `/auth/login/verify-device`, `/auth/login/resend-otp`, `/auth/refresh`, `/auth/logout`, `/auth/login-code/forgot/reset`.

### 4.2 Gửi `deviceName`

4. `DeviceIdentity` có thêm `Future<String?> deviceName()`: Android trả `"<hãng> <model>"`, iOS trả mã phần cứng (ví dụ `iPhone15,2`), nền tảng khác trả `null`. Cắt và trim còn tối đa 100 ký tự, rỗng thì `null`. Lỗi khi đọc không được làm hỏng đăng nhập: ghi log và trả `null`.
5. Gửi `deviceName` (bỏ qua khi `null`) ở `POST /auth/register/complete`, `/auth/login`, `/auth/login-code/forgot/reset`. `verify-device` không cần.

### 4.3 Mã lỗi và thông báo

6. `ApiErrorCodes` thêm `AUTH_WRONG_APP`, `LOGIN_CODE_UNCHANGED`, `AUTH_SESSION_CHECK_UNAVAILABLE`.
7. `ApiException` có `accountRole` (đọc `details.accountRole`) và `isServiceUnavailable` (HTTP 503 hoặc mã `AUTH_SESSION_CHECK_UNAVAILABLE`).
8. `AuthFailure` thêm `wrongApp`, `loginCodeUnchanged`, `serviceUnavailable`, `notSupported`; `AuthException` có `accountRole`. `OtpFailure` thêm `wrongApp`; `OtpException` có `accountRole`.
9. Thông báo (vi và en) qua `auth_error_message.dart`: `wrongApp` nêu tên app theo role (`driver` Tài xế, `merchant` Chủ quán, `admin` Quản trị; role lạ dùng câu chung); `loginCodeUnchanged`; `serviceUnavailable`. Google sign-in (chưa có API) báo `commonComingSoon`.
10. Với `AUTH_SESSION_CHECK_UNAVAILABLE` (503) không xoá token, không chuyển về màn đăng nhập.
11. Không hiển thị `error.message` của server cho người dùng; thông báo theo `error.code`.

### 4.4 Giữ nguyên (đã đúng tài liệu)

12. Envelope `{ success, data }`, 204 không body, refresh token xoay vòng, thử `refresh` một lần khi `AUTH_TOKEN_EXPIRED`, `logout` luôn xoá token local: `lib/core/network/` đã khớp, không đổi.

## 5. Non-goals

- Màn "Đổi mã đăng nhập" (`POST /auth/login-code/change`) và "Thiết bị tin cậy" (`GET /auth/devices`, `DELETE /auth/devices/:id`). Gozon có feature `login_security` cho việc này; đã chọn không làm ở PRD này.
- Luồng tài xế (`AUTH_SESSION_REPLACED`, một phiên): rocket là app khách.
- Thay đổi giao diện các màn auth.
- Google sign-in (backend chưa có).

## 6. Design considerations

Không đổi layout. Chỉ thêm chuỗi dịch (vi/en): `authWrongApp` (có `@app`), `authWrongAppUnknown`, `authRoleDriver/Merchant/Admin`, `authLoginCodeUnchanged`, `authServiceUnavailable`, `commonComingSoon`.

## 7. Technical considerations

Hiện trạng đã sửa trong working tree (chưa commit, theo cách của `gozon_client_flutter`, chỉ đổi tên log `gozon.` thành `rocket.`):

- `lib/core/constants/app_constants.dart`, `lib/core/network/api_error_codes.dart`, `api_exception.dart`.
- `lib/core/services/device_identity.dart` (thêm `deviceName`, dùng `device_info_plus: ^13.3.0`).
- `lib/features/auth/`: `auth_remote_data_source.dart`, `auth_repository_impl.dart`, `auth_exception.dart`, `auth_error_message.dart`.
- `lib/features/verify_otp/`: `otp_remote_data_source.dart`, `otp_repository_impl.dart`, `otp_exception.dart`, `verify_otp_controller.dart`.
- `lib/features/create_password/`: `password_remote_data_source.dart`, `password_repository_impl.dart`.
- `lib/app/translations/locale_keys.dart`, `app_translations.dart`.
- `pubspec.yaml`, `pubspec.lock` (thêm `device_info_plus`; `pub get` còn nâng `intl`, `matcher`, `meta`, `test_api`, `vector_math`), `macos/Flutter/GeneratedPluginRegistrant.swift` (sinh tự động).

Phần còn lại:

- Test mới (copy và chỉnh từ gozon): `test/features/auth/auth_api_requests_test.dart` (body từng endpoint có/không `app`, `deviceName`) và `auth_error_mapping_test.dart` (mã lỗi thành `AuthFailure`/`OtpFailure`, thông báo, `accountRole`). Cập nhật các `DeviceIdentity` giả trong test hiện có nếu thiếu `deviceName`.
- Chưa chạy `flutter test` toàn bộ sau thay đổi; `test/widget_test.dart` đã fail sẵn trên `main` (`pumpAndSettle timed out`).
- Quyết định về `pubspec.lock` (giữ các bản nâng bắt buộc bởi `device_info_plus` hay rà lại) và `GeneratedPluginRegistrant.swift` (giữ vì plugin mới).
- Kiểm tra với backend thật (ngrok trong `AppConstants.apiBaseUrl`): đăng ký, đăng nhập thiết bị lạ, quên mã, sai app. Chưa thực hiện.
- Không dùng mock: mọi endpoint auth đã gọi API thật (`Api...RemoteDataSource`); `grep -rn "Fake" lib` không được có Fake nào của auth.
- Lưu ý khác với gozon: rocket giữ `OtpIllustration`, `FlutterLogo` và `selection_sheet.dart` trong feature auth, không đồng bộ.

## 8. Success metrics

- Test body và ánh xạ lỗi pass; `fvm flutter analyze` chỉ còn 2 cảnh báo cũ của `packages/dragon_design/example`.
- Trên backend thật: đăng ký, đăng nhập thiết bị lạ, quên mã, đăng xuất chạy; số của tài xế nhập vào app khách báo đúng app.
- Danh sách thiết bị tin cậy trên server thấy tên máy.

## 9. Open questions

1. Có làm tiếp màn Đổi mã và Thiết bị tin cậy (feature `login_security` của gozon) ở đợt sau không?
2. `rocketigo_admin` có phải app role `customer` hay một role khác (ví dụ app riêng)? PRD giả định `customer`.
3. `pubspec.lock`: chấp nhận các bản nâng bắt buộc bởi `device_info_plus`?
4. Backend development có OTP cố định `1111`; có môi trường staging để thử OTP thật không?
