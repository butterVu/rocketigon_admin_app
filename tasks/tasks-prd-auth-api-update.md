## Relevant Files

- `lib/core/constants/app_constants.dart` - `appRole = 'customer'` (đã sửa, chưa commit).
- `lib/core/network/api_error_codes.dart` - Mã lỗi mới `AUTH_WRONG_APP`, `LOGIN_CODE_UNCHANGED`, `AUTH_SESSION_CHECK_UNAVAILABLE` (đã sửa).
- `lib/core/network/api_exception.dart` - `accountRole`, `isServiceUnavailable` (đã sửa).
- `lib/core/services/device_identity.dart` - `deviceName()` và `normalizeDeviceName` (đã sửa).
- `lib/features/auth/data/datasources/auth_remote_data_source.dart` - Gửi `app`, `deviceName` (đã sửa).
- `lib/features/auth/data/repositories/auth_repository_impl.dart` - Truyền `deviceName`, ánh xạ lỗi mới (đã sửa).
- `lib/features/auth/domain/entities/auth_exception.dart` - Thêm `wrongApp`, `loginCodeUnchanged`, `serviceUnavailable`, `notSupported`, `accountRole` (đã sửa).
- `lib/features/auth/presentation/controllers/auth_error_message.dart` - Thông báo cho lỗi mới, tên app theo role (đã sửa).
- `lib/features/verify_otp/data/datasources/otp_remote_data_source.dart` - Gửi `app` (đã sửa).
- `lib/features/verify_otp/data/repositories/otp_repository_impl.dart` - Ánh xạ `wrongApp` (đã sửa).
- `lib/features/verify_otp/domain/entities/otp_exception.dart` - `OtpFailure.wrongApp`, `accountRole` (đã sửa).
- `lib/features/verify_otp/presentation/controllers/verify_otp_controller.dart` - Thông báo `wrongApp` (đã sửa).
- `lib/features/create_password/data/datasources/password_remote_data_source.dart` - Gửi `deviceName` (đã sửa).
- `lib/features/create_password/data/repositories/password_repository_impl.dart` - Truyền `deviceName` (đã sửa).
- `lib/app/translations/locale_keys.dart`, `lib/app/translations/app_translations.dart` - Chuỗi vi/en mới (đã sửa).
- `pubspec.yaml`, `pubspec.lock` - Thêm `device_info_plus` (đã sửa).
- `macos/Flutter/GeneratedPluginRegistrant.swift` - File sinh tự động do plugin mới.
- `test/features/auth/auth_api_requests_test.dart` - Test body request (tạo mới, chỉnh từ gozon).
- `test/features/auth/auth_error_mapping_test.dart` - Test ánh xạ lỗi và thông báo (tạo mới, chỉnh từ gozon).
- `test/core/services/device_identity_test.dart` - Test `deviceName`/`normalizeDeviceName` (tạo mới, chỉnh từ gozon).
- `test/features/auth/login_logic_test.dart`, `test/features/verify_otp/verify_otp_test.dart` - Test hiện có; chỉ sửa nếu hỏng sau thay đổi.
- `tasks/prd-auth-api-update.md` - Cập nhật ghi chú kết quả kiểm tra thật.

### Notes

- Thư mục tham chiếu: `/home/ubuntu/Documents/rocket/gozon_client_flutter` (đã cập nhật theo tài liệu). Khi chép test, đổi `package:gozon_client_flutter/` thành `package:rocketigo_admin/` và `gozon.` thành `rocket.`. Không chép thứ không có trong rocket (ví dụ test `login_security`).
- Chạy test: `~/fvm/versions/3.47.0/bin/flutter test test/features/auth test/core test/features/verify_otp`. `fvm flutter analyze` chỉ in "N issues found" mà không liệt kê; để xem chi tiết dùng `~/fvm/versions/3.47.0/bin/flutter analyze`. Cách này có thể sửa `pubspec.lock`; kiểm tra bằng `git diff pubspec.lock` (task 1.0 đã chốt lock, sau đó dùng `git checkout pubspec.lock` nếu lock đổi thêm).
- Không build app. Dòng ≤ 80 ký tự, doc comment `///` cho API public, không comment cuối dòng.
- Test double là class private `_Fake...` trong file test, không đặt trong `lib/`.
- `test/widget_test.dart` đã fail sẵn trên `main` (`pumpAndSettle timed out`); không tính là lỗi của việc này, chỉ ghi lại.
- Backend development có OTP cố định `1111`. URL backend nằm ở `AppConstants.apiBaseUrl` (ngrok); đổi bằng `--dart-define=API_BASE_URL=...`.
- Backend tham chiếu cục bộ: `/home/ubuntu/Documents/rocket/gozon-backend`, tài liệu `docs/auth-api.md`.

## Tasks

- [x] 1.0 Rà soát và chốt phần code auth đã sửa rồi commit
  - [x] 1.1 Chạy `git status` và `git diff --stat`; xác nhận chỉ có các file liệt kê trong Relevant Files.
  - [x] 1.2 So từng file auth/verify_otp/create_password/network/services với bản gozon (`diff -r`): chỉ được khác tên log (`rocket.` thay `gozon.`), chuỗi "Rocket API" và các phần riêng của rocket (OtpIllustration, FlutterLogo, selection_sheet).
  - [x] 1.3 Đối chiếu từng endpoint trong `gozon-backend/docs/auth-api.md` mục 2 với `*_remote_data_source.dart`: endpoint nào gửi `app`, endpoint nào gửi `deviceName` (xem PRD mục 4.1 và 4.2). Sửa nếu lệch.
  - [x] 1.4 Xem `git diff pubspec.lock`: chấp nhận `device_info_plus` và `device_info_plus_platform_interface`, và các bản nâng bắt buộc (`intl`, `matcher`, `meta`, `test_api`, `vector_math`). Nếu có thay đổi ngoài danh sách này, hoàn tác bằng `git checkout pubspec.lock` rồi chạy lại `fvm flutter pub get`. Ghi quyết định vào Notes. (Quyết định: giữ các bản nâng bắt buộc bởi device_info_plus.)
  - [x] 1.5 Giữ `GeneratedPluginRegistrant.swift` (do plugin mới sinh ra); nếu diff có thay đổi không liên quan tới `device_info_plus`, ghi chú.
  - [x] 1.6 Chạy `fvm dart format` trên các file đã sửa và `~/fvm/versions/3.47.0/bin/flutter analyze`; chỉ được còn 2 cảnh báo cũ của `packages/dragon_design/example`.
  - [x] 1.7 Đóng task: chạy `flutter test test/features/auth test/features/verify_otp`; sửa nếu test cũ hỏng vì `DeviceIdentity` có thêm `deviceName()` hay `AuthFailure` có thêm giá trị. Commit theo kiểu `feat(auth): send app role and device name, handle new auth errors`.

- [x] 2.0 Test body request và `DeviceIdentity.deviceName`
  - [x] 2.1 Chép `gozon_client_flutter/test/features/auth/auth_api_requests_test.dart` sang `test/features/auth/`, đổi tên package; đọc từng test để hiểu cách giả `Dio` (chặn request, kiểm tra `data`).
  - [x] 2.2 Kiểm tra các nhóm test: `app` được gửi ở register/otp, register/verify, login, forgot/verify; không gửi ở các endpoint khác; `deviceName` được gửi ở register/complete, login, forgot/reset khi có, bỏ khi `null`, không gửi ở verify-device.
  - [x] 2.3 Chép `gozon_client_flutter/test/core/services/device_identity_test.dart` sang `test/core/services/`, đổi tên package; kiểm tra: `normalizeDeviceName` trim, cắt 100 ký tự, rỗng thành `null`; `deviceName()` trả `null` và không ném lỗi khi đọc lỗi.
  - [x] 2.4 Chạy hai file test; sửa lệch giữa rocket và gozon (nếu có) bằng cách sửa code rocket cho đúng PRD, không nới lỏng test.
  - [x] 2.5 Đóng task: format, analyze, chạy test của hai file, kịch bản tay: không cần (chỉ test). Commit `test(auth): cover app role and device name in requests`.

- [x] 3.0 Test ánh xạ mã lỗi mới và thông báo
  - [x] 3.1 Chép `gozon_client_flutter/test/features/auth/auth_error_mapping_test.dart` sang `test/features/auth/`, đổi tên package.
  - [x] 3.2 Kiểm tra các test: `AUTH_WRONG_APP` giữ `accountRole` (auth và OTP); `LOGIN_CODE_UNCHANGED`; 503 hoặc `AUTH_SESSION_CHECK_UNAVAILABLE` thành `serviceUnavailable`; các lỗi cũ vẫn ánh xạ đúng; Google sign-in báo `notSupported`; `OTP_INVALID` còn báo số lần thử còn lại.
  - [x] 3.3 Kiểm tra test tên app theo role: `driver`, `merchant`, `admin` có tên, `customer`/rỗng/lạ không có tên (dùng câu chung `authWrongAppUnknown`).
  - [x] 3.4 Thêm test cho `AuthInterceptor` (`test/core/network/auth_interceptor_test.dart`): refresh trả 503 `AUTH_SESSION_CHECK_UNAVAILABLE` thì giữ token, không gọi `onSessionExpired`; refresh bị từ chối (401) thì xoá token. Cần thêm `test/helpers/recording_http_adapter.dart` (chép từ gozon).
  - [x] 3.5 Chạy test; nếu test nào fail do khác biệt rocket/gozon, sửa code rocket cho đúng PRD.
  - [x] 3.6 Đóng task: format, analyze, `flutter test test/features/auth`; commit `test(auth): cover new auth error codes`.

- [ ] 4.0 Kiểm tra với backend thật
  - [x] 4.1 Backend ngrok (`AppConstants.apiBaseUrl`) trả lời (HTTP 400 với body rỗng). Chưa xác nhận OTP cố định `1111` vì cần gửi OTP thật tới một số.
  - [x] 4.2 `curl` chỉ ở mức validate (số điện thoại sai): `register/otp` đòi `app` (customer/driver/merchant/admin); `login` và `forgot/verify` nhận `app`, `deviceName` không bị từ chối; `forgot/otp` không đòi `app`. Chưa chạy luồng đủ (đăng ký, OTP) để không tạo dữ liệu trên backend dùng chung.
  - [ ] 4.3 Hỏi người dùng có cho chạy app trên máy (Android) không, vì dự án mặc định không build app. Chỉ làm 4.4 trở đi khi được đồng ý.
  - [ ] 4.4 Kịch bản máy: (a) đăng ký số mới, OTP `1111`, đặt tên và mã, vào Home; (b) đăng xuất rồi đăng nhập lại cùng máy: vào thẳng; (c) xoá dữ liệu app (thiết bị lạ) rồi đăng nhập: nhập OTP, vào Home; (d) quên mã, OTP, đặt mã mới, vào thẳng; (e) nhập số của tài xế/chủ quán: thấy "thuộc app Tài xế/Chủ quán"; (f) nhập sai mã 5 lần: thấy thông báo khoá tạm.
  - [ ] 4.5 Ghi kết quả từng bước (đạt, không đạt, chưa thử) vào `tasks/prd-auth-api-update.md` mục 7; bước nào chưa thử giữ chưa tích và ghi lý do.

- [ ] 5.0 Kiểm tra cuối
  - [ ] 5.1 Chạy `grep -rn "Fake" lib/features/auth lib/features/verify_otp lib/features/create_password`: không còn Fake nào của auth. Báo cáo Fake còn lại của tính năng khác.
  - [ ] 5.2 Chạy `fvm dart format` trên file đã đổi, `~/fvm/versions/3.47.0/bin/flutter analyze` (chỉ còn 2 cảnh báo cũ) và `flutter test` toàn bộ; `test/widget_test.dart` được phép fail như trước, mọi test khác phải đạt.
  - [ ] 5.3 Chạy `git checkout pubspec.lock` nếu lock đổi ngoài danh sách đã chấp nhận ở 1.4.
  - [ ] 5.4 Cập nhật PRD mục 9 (câu hỏi mở) bằng câu trả lời có được.
  - [ ] 5.5 Báo cáo cuối: file đã thêm/sửa, những gì đã kiểm tra với backend thật và chưa kiểm tra, mock còn lại.
