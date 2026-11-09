# Rocketio API cho Mobile App

Oct 8, 2026 · @Hoan Vu

Tài liệu tích hợp API user customer (đăng ký, đăng nhập bằng số điện thoại, quên mã, thiết bị, hồ sơ) cho team mobile. Driver và merchant chưa có ở đợt này.

## Kết nối

Mọi endpoint nằm dưới `{BASE_URL}/api/v1/...`, riêng health check ở `/api/health/...` (không có version). Body gửi lên là JSON với `Content-Type: application/json`.

| Header | Khi nào gửi |
| --- | --- |
| `Content-Type: application/json` | Mọi request có body |
| `Authorization: Bearer <accessToken>` | Mọi endpoint, trừ các endpoint đăng ký, đăng nhập, quên mã, refresh, logout |

**Response thành công** luôn được bọc trong `data`. Endpoint dạng danh sách có thêm `meta`:

```json
{ "success": true, "data": { "...": "..." } }
{ "success": true, "data": [], "meta": { "page": 1, "limit": 20, "total": 42, "totalPages": 3 } }
```

Endpoint trả `204 No Content` thì không có body.

**Response lỗi** luôn có cùng một dạng. App nên rẽ nhánh theo `error.code`, không dựa vào `message` (message bằng tiếng Anh, chỉ để debug, không hiển thị cho người dùng):

```json
{
  "success": false,
  "error": {
    "statusCode": 403,
    "code": "AUTH_LOGIN_LOCKED",
    "message": "Too many failed attempts, try again later",
    "details": { "lockedUntil": "2026-10-08T10:15:00.000Z", "retryAfterSeconds": 870 }
  },
  "path": "/api/v1/auth/login",
  "timestamp": "2026-10-08T10:00:30.000Z"
}
```

Lỗi validate (400, `VALIDATION_FAILED`) có `details` là danh sách lỗi theo từng field, dùng được để hiện lỗi ngay dưới ô nhập: `[{ "field": "phone", "messages": ["phone must be a valid phone number"] }]`. Server từ chối mọi field lạ không có trong tài liệu, nên app chỉ gửi đúng các field được liệt kê.

**Đặc tả OpenAPI:** file `docs/openapi.json` trong repo backend (tạo lại bằng `npm run docs:openapi`), import thẳng vào Postman hoặc dùng để sinh code client. Server dev còn có Swagger UI tại `{BASE_URL}/api/docs`. Ngày giờ trả về dạng ISO 8601 UTC. Mọi `id` là chuỗi 24 ký tự hex.

## Định danh thiết bị (deviceId)

App tự sinh một `deviceId` một lần duy nhất và gửi nó ở mọi bước đăng ký, đăng nhập và đặt lại mã. Server dùng nó để biết thiết bị đã được tin cậy hay chưa (thiết bị lạ phải xác minh OTP).

- Sinh UUID v4 ở lần mở app đầu tiên, lưu trong Keychain (iOS) hoặc EncryptedSharedPreferences (Android).
- Giữ nguyên qua các lần đăng xuất và cập nhật app. Nếu `deviceId` đổi, người dùng sẽ phải xác minh OTP lại.
- Định dạng: 8–128 ký tự trong `A-Z a-z 0-9 . _ : -`. UUID v4 thỏa mãn.
- `deviceName` không bắt buộc, tối đa 100 ký tự, ví dụ `iPhone 15` hoặc `Samsung Galaxy S24`. Nó hiển thị trong danh sách thiết bị của người dùng.
- Không dùng IMEI, MAC hay ID phần cứng.

## Đăng ký

Đăng ký gồm 3 bước, kết thúc là người dùng đã đăng nhập với role `customer`, và thiết bị đang dùng được tin cậy luôn (không cần OTP khi đăng nhập lại).

1. **Gửi OTP.** `POST /api/v1/auth/register/otp` với body `{ "phone": "0912345678" }`. Trả về `{ "expiresInSeconds": 300, "resendAfterSeconds": 60 }`. Nếu số đã đăng ký sẽ nhận `409 PHONE_ALREADY_REGISTERED`, khi đó chuyển người dùng sang màn đăng nhập.
2. **Xác minh OTP.** `POST /api/v1/auth/register/verify` với body `{ "phone": "0912345678", "otp": "123456" }`. Trả về `{ "registrationToken": "...", "expiresInSeconds": 900 }`. Token dùng một lần và hết hạn sau 15 phút.
3. **Đặt mã và hoàn tất.** `POST /api/v1/auth/register/complete`, trả `201` kèm bộ token (xem mẫu bên dưới).

```json
{
  "registrationToken": "<từ bước 2>",
  "fullName": "Nguyen Van A",
  "loginCode": "246810",
  "deviceId": "3f1c9a7e-2b4d-4c8e-9f0a-1b2c3d4e5f60",
  "deviceName": "iPhone 15"
}
```

Response của bước 3, cũng là dạng `AuthResponse` dùng chung cho đăng nhập và đặt lại mã:

```json
{
  "success": true,
  "data": {
    "accessToken": "eyJ...",
    "refreshToken": "eyJ...",
    "tokenType": "Bearer",
    "expiresIn": 900,
    "roles": ["customer"],
    "user": {
      "id": "665f1c2e8b3e4a0012345678",
      "phone": "+84912345678",
      "email": null,
      "fullName": "Nguyen Van A",
      "avatarUrl": null,
      "status": "active",
      "phoneVerifiedAt": "2026-10-08T10:00:00.000Z",
      "lastLoginAt": "2026-10-08T10:00:00.000Z",
      "createdAt": "2026-10-08T10:00:00.000Z",
      "updatedAt": "2026-10-08T10:00:00.000Z"
    }
  }
}
```

Lưu ý cho UI:

- **Số điện thoại** nhận dạng `0912345678`, `84912345678` hoặc `+84912345678`; server chuẩn hóa về `+84...` và luôn trả về dạng này.
- **Mã đăng nhập** dài 6–64 ký tự bất kỳ (không bắt buộc toàn số). **Họ tên** 2–100 ký tự.
- **OTP** gồm 6 chữ số. Nút "Gửi lại" bật sau `resendAfterSeconds` giây; gọi lại bước 1 để gửi lại.
- **`REGISTRATION_TOKEN_INVALID`** ở bước 3 nghĩa là phải quay lại bước 1.

## Đăng nhập

`POST /api/v1/auth/login` luôn trả `200` khi đúng mã. App đọc `data.nextStep` để biết đã vào được ngay hay cần thêm OTP xác minh thiết bị.

> _(Sơ đồ luồng đăng nhập trong doc gốc — 2 điểm rẽ nhánh, khoá sau 5 lần sai — không xuất được sang Markdown.)_

Thiết bị đã tin cậy vào thẳng; thiết bị lạ cần thêm OTP. Sai mã và sai OTP cùng cộng vào một bộ đếm khoá.

Request:

```json
{ "phone": "0912345678", "loginCode": "246810", "deviceId": "3f1c9a7e-...", "deviceName": "iPhone 15" }
```

**Thiết bị đã tin cậy:** `nextStep = "AUTHENTICATED"`, token nằm trong `data.auth` (cùng dạng `AuthResponse` ở phần Đăng ký).

```json
{ "success": true, "data": { "nextStep": "AUTHENTICATED", "auth": { "accessToken": "eyJ...", "refreshToken": "eyJ...", "roles": ["customer"], "user": { } } } }
```

**Thiết bị mới:** server gửi OTP tới số điện thoại đã xác minh và trả `nextStep = "DEVICE_VERIFICATION_REQUIRED"`.

```json
{ "success": true, "data": { "nextStep": "DEVICE_VERIFICATION_REQUIRED", "challengeId": "Xk3...", "otp": { "expiresInSeconds": 300, "resendAfterSeconds": 60 } } }
```

Sau đó hiện màn nhập OTP:

- **Xác minh:** `POST /api/v1/auth/login/verify-device` với `{ "challengeId": "...", "otp": "123456" }`, trả `AuthResponse` (không có lớp `nextStep`). Từ lần sau, thiết bị này vào thẳng.
- **Gửi lại OTP:** `POST /api/v1/auth/login/resend-otp` với `{ "challengeId": "..." }`. `challengeId` có hiệu lực 15 phút.
- **Nhập sai OTP:** giữ nguyên `challengeId` và cho nhập lại.

**Khoá tạm:** sai mã đăng nhập hoặc sai OTP thiết bị mới 5 lần liên tiếp thì tài khoản bị khoá đăng nhập 15 phút (`403 AUTH_LOGIN_LOCKED`, kèm `details.retryAfterSeconds`). Trong thời gian khoá, nhập đúng mã cũng bị từ chối. App nên hiện đếm ngược và gợi ý "Quên mã"; đặt lại mã thành công sẽ mở khoá ngay.

Sai số điện thoại và sai mã đều trả cùng một lỗi `401 AUTH_INVALID_CREDENTIALS`, nên UI chỉ báo chung "Số điện thoại hoặc mã không đúng".

## Token và refresh

Access token sống 15 phút, refresh token 7 ngày. Mỗi lần refresh, server trả về **cặp token mới** và refresh token cũ mất hiệu lực. Nếu app hoạt động ít nhất một lần mỗi 7 ngày thì phiên đăng nhập kéo dài mãi.

- **Lưu trữ:** cả hai token lưu trong Keychain (iOS) hoặc EncryptedSharedPreferences/Keystore (Android), không lưu trong storage thường.
- **Refresh:** `POST /api/v1/auth/refresh` với `{ "refreshToken": "..." }`, không cần header `Authorization`. Response gồm `accessToken`, `refreshToken`, `tokenType`, `expiresIn`, `roles`, không có `user`. Ghi đè **cả hai** token đã lưu.
- **Khi nào refresh:** khi nhận `401 AUTH_TOKEN_EXPIRED`, refresh rồi gửi lại request ban đầu một lần. Có thể refresh trước khi hết hạn, dựa vào `expiresIn`.
- **Refresh thất bại** (`401 AUTH_REFRESH_TOKEN_INVALID`): xoá token đã lưu và đưa người dùng về màn đăng nhập. Lỗi này xảy ra khi đã logout, thiết bị bị thu hồi, đổi mã, tài khoản bị xoá hoặc bị khoá.
- **Đăng xuất:** `POST /api/v1/auth/logout` với `{ "refreshToken": "..." }`, trả `204`, sau đó xoá token ở app. Endpoint này không bao giờ báo lỗi với token đã hết hạn, nên có thể gọi mà không cần chờ kết quả.

> **Bắt buộc: chỉ một request refresh tại một thời điểm.** Nếu nhiều request cùng nhận `AUTH_TOKEN_EXPIRED`, chỉ request đầu tiên được gọi refresh; các request còn lại chờ kết quả đó (ví dụ dùng mutex hoặc một promise chung trong interceptor của OkHttp/Alamofire/Dio). Server coi việc gửi lại một refresh token đã được đổi là dấu hiệu token bị đánh cắp, và sẽ **đăng xuất người dùng trên mọi thiết bị**. Cũng vì vậy, luôn lưu refresh token mới trước khi dùng access token mới.

**Roles** nằm trong access token. Khi quyền của người dùng thay đổi, thay đổi đó có hiệu lực ở lần refresh kế tiếp, chậm nhất sau 15 phút. App nên lấy `roles` từ response login/refresh hoặc từ `GET /users/me`, không tự giải mã JWT.

## Quên mã và đổi mã

**Quên mã** gồm 3 bước, kết thúc là người dùng đăng nhập luôn trên thiết bị đang dùng. Mọi phiên cũ, kể cả trên chính thiết bị này, bị đăng xuất.

1. `POST /api/v1/auth/login-code/forgot/otp` với `{ "phone": "..." }`. Endpoint luôn trả `200` kể cả khi số chưa đăng ký (để không lộ số nào có tài khoản), nên UI ghi "Nếu số này đã đăng ký, bạn sẽ nhận được mã".
2. `POST /api/v1/auth/login-code/forgot/verify` với `{ "phone": "...", "otp": "123456" }`. Trả `{ "resetToken": "...", "expiresInSeconds": 600 }`, token dùng một lần.
3. `POST /api/v1/auth/login-code/forgot/reset` với `{ "resetToken", "newLoginCode", "deviceId", "deviceName" }`. Trả `AuthResponse`; lưu token và vào app.

Bước 3 cũng mở khoá tạm do nhập sai nhiều lần. Tài khoản bị admin khoá (`ACCOUNT_LOCKED`) thì không đặt lại được.

**Đổi mã** (đang đăng nhập): `POST /api/v1/auth/login-code/change` kèm Bearer token và body `{ "currentLoginCode": "...", "newLoginCode": "..." }`, trả `204`.

- Thiết bị đang dùng giữ nguyên phiên, không cần lưu token mới; các thiết bị khác bị đăng xuất và phải xác minh OTP lại.
- Sai mã hiện tại trả `401 AUTH_INVALID_CREDENTIALS` và bị tính vào số lần sai của khoá tạm. Mã mới trùng mã cũ trả `400 LOGIN_CODE_UNCHANGED`.
- Đây là lỗi 401 nhưng **không** phải lỗi token: app hiển thị lỗi ở ô nhập, không refresh và không đăng xuất. Interceptor chỉ refresh khi `code` là `AUTH_TOKEN_EXPIRED`.

## Hồ sơ, xoá tài khoản, thiết bị

Các endpoint dưới đây đều cần Bearer token.

- **Xem hồ sơ:** `GET /api/v1/users/me` trả object `user` như ở phần Đăng ký, cộng thêm `roles`.
- **Sửa hồ sơ:** `PATCH /api/v1/users/me`, gửi field nào thì đổi field đó, trả `user` mới.
  - `fullName`: 2–100 ký tự.
  - `email`: server tự chuyển về chữ thường; trùng tài khoản khác trả `409 USER_EMAIL_TAKEN`. Email hiện chưa có bước xác minh.
  - `avatarUrl`: URL `https://`, tối đa 2048 ký tự. Backend chưa có API upload ảnh.
  - Gửi `phone`, `status` hay field khác sẽ bị `400`. Đổi số điện thoại chưa được hỗ trợ.
- **Xoá tài khoản:** `DELETE /api/v1/users/me` với body `{ "loginCode": "..." }` (bắt buộc nhập lại mã), trả `204`. Mọi thiết bị bị đăng xuất; app xoá token và về màn đăng ký. Số điện thoại đó đăng ký lại được từ đầu. Một số thư viện HTTP không gửi body cho `DELETE` theo mặc định, cần kiểm tra.
- **Danh sách thiết bị:** `GET /api/v1/auth/devices` trả mảng `{ id, deviceId, deviceName, trustedAt, lastSeenAt, isCurrent }`, thiết bị dùng gần nhất đứng đầu. `isCurrent = true` là thiết bị đang gọi.
- **Thu hồi thiết bị:** `DELETE /api/v1/auth/devices/{id}`, trong đó `id` là field `id` trong danh sách, **không phải** `deviceId`. Trả `204`. Thiết bị đó bị đăng xuất ở lần refresh kế tiếp và phải xác minh OTP nếu đăng nhập lại. Nếu người dùng thu hồi chính thiết bị đang dùng (`isCurrent`), app nên xoá token và về màn đăng nhập luôn.

## Tra cứu endpoint

Mọi path bên dưới có tiền tố `/api/v1`. Cột Auth: "Bearer" = cần access token, "Admin" = cần thêm role admin.

| Method | Path | Auth | Body | Thành công |
| --- | --- | --- | --- | --- |
| POST | `/auth/register/otp` | Không | `phone` | 200 `{ expiresInSeconds, resendAfterSeconds }` |
| POST | `/auth/register/verify` | Không | `phone`, `otp` | 200 `{ registrationToken, expiresInSeconds }` |
| POST | `/auth/register/complete` | Không | `registrationToken`, `fullName`, `loginCode`, `deviceId`, `deviceName?` | 201 `AuthResponse` |
| POST | `/auth/login` | Không | `phone`, `loginCode`, `deviceId`, `deviceName?` | 200 `{ nextStep, auth?, challengeId?, otp? }` |
| POST | `/auth/login/verify-device` | Không | `challengeId`, `otp` | 200 `AuthResponse` |
| POST | `/auth/login/resend-otp` | Không | `challengeId` | 200 `{ expiresInSeconds, resendAfterSeconds }` |
| POST | `/auth/refresh` | Không | `refreshToken` | 200 token, không có `user` |
| POST | `/auth/logout` | Không | `refreshToken` | 204 |
| POST | `/auth/login-code/forgot/otp` | Không | `phone` | 200 `{ expiresInSeconds, resendAfterSeconds }` |
| POST | `/auth/login-code/forgot/verify` | Không | `phone`, `otp` | 200 `{ resetToken, expiresInSeconds }` |
| POST | `/auth/login-code/forgot/reset` | Không | `resetToken`, `newLoginCode`, `deviceId`, `deviceName?` | 200 `AuthResponse` |
| POST | `/auth/login-code/change` | Bearer | `currentLoginCode`, `newLoginCode` | 204 |
| GET | `/auth/devices` | Bearer |  | 200 danh sách thiết bị |
| DELETE | `/auth/devices/{id}` | Bearer |  | 204 |
| GET | `/users/me` | Bearer |  | 200 `user` + `roles` |
| PATCH | `/users/me` | Bearer | `fullName?`, `email?`, `avatarUrl?` | 200 `user` |
| DELETE | `/users/me` | Bearer | `loginCode` | 204 |
| GET | `/users` | Admin | query `page`, `limit`, `search`, `status` | 200 danh sách có `meta` |
| GET | `/users/{id}` | Admin |  | 200 `user` |

App customer không dùng hai endpoint Admin cuối bảng. Health check (`GET /api/health/live`, `/api/health/ready`) dành cho hạ tầng, không dành cho app.

## Mã lỗi và cách xử lý

Rẽ nhánh theo `error.code`. Mã nào không có trong bảng thì xử lý theo HTTP status với một thông báo chung.

| `error.code` | HTTP | App nên làm gì |
| --- | --- | --- |
| `VALIDATION_FAILED` | 400 | Hiện lỗi dưới ô nhập theo `details[].field` |
| `OTP_INVALID` | 400 | Báo sai mã, cho nhập lại; còn `details.remainingAttempts` lần |
| `OTP_TOO_MANY_ATTEMPTS` | 400 | Mã đã bị huỷ, người dùng phải bấm "Gửi lại mã" |
| `OTP_EXPIRED` | 400 | Mã hết hạn hoặc đã dùng, đề nghị gửi lại |
| `OTP_RESEND_TOO_SOON` | 429 | Khoá nút gửi lại, đếm ngược `details.retryAfterSeconds` |
| `OTP_LIMIT_EXCEEDED` | 429 | Số này đã nhận quá 5 mã trong 1 giờ; báo thử lại sau `details.retryAfterSeconds` |
| `OTP_DELIVERY_FAILED` | 503 | Gửi SMS lỗi; cho thử lại ngay |
| `REGISTRATION_TOKEN_INVALID` | 400 | Quay lại bước nhập số điện thoại của đăng ký |
| `RESET_TOKEN_INVALID` | 400 | Quay lại bước đầu của quên mã |
| `LOGIN_CHALLENGE_INVALID` | 400 | Phiên xác minh thiết bị hết hạn; quay lại màn đăng nhập |
| `LOGIN_CODE_UNCHANGED` | 400 | Báo mã mới phải khác mã cũ |
| `PHONE_ALREADY_REGISTERED` | 409 | Chuyển sang màn đăng nhập |
| `USER_EMAIL_TAKEN` | 409 | Báo email đã được dùng |
| `AUTH_INVALID_CREDENTIALS` | 401 | Báo "Số điện thoại hoặc mã không đúng". Không refresh, không đăng xuất |
| `AUTH_LOGIN_LOCKED` | 403 | Đếm ngược `details.retryAfterSeconds`, gợi ý "Quên mã" |
| `ACCOUNT_LOCKED` | 403 | Tài khoản bị khoá bởi quản trị; hướng dẫn liên hệ hỗ trợ |
| `AUTH_TOKEN_EXPIRED` | 401 | Refresh (một lần, không song song) rồi gửi lại request |
| `AUTH_TOKEN_MISSING`, `AUTH_TOKEN_INVALID` | 401 | Lỗi của app; xoá token, về màn đăng nhập |
| `AUTH_REFRESH_TOKEN_INVALID` | 401 | Xoá token, về màn đăng nhập |
| `FORBIDDEN_ROLE` | 403 | Không có quyền; ẩn tính năng |
| `USER_NOT_FOUND` | 404 | Tài khoản vừa bị xoá; xoá token, về màn đăng nhập |
| `DEVICE_NOT_FOUND` | 404 | Tải lại danh sách thiết bị |
| `TOO_MANY_REQUESTS` | 429 | Vượt rate limit theo IP; chờ rồi thử lại (header `Retry-After`) |
| `INTERNAL_SERVER_ERROR` | 500 | Thông báo lỗi chung, cho thử lại |

## Giới hạn và thông số

Giá trị mặc định hiện tại, backend có thể đổi qua biến môi trường. App nên đọc giá trị từ response (`expiresIn`, `expiresInSeconds`, `resendAfterSeconds`, `retryAfterSeconds`) thay vì hard-code.

| Thông số | Giá trị |
| --- | --- |
| Access token | 15 phút |
| Refresh token | 7 ngày, đổi mới mỗi lần refresh |
| OTP | 6 chữ số, hết hạn sau 5 phút, dùng một lần |
| Nhập sai OTP | 5 lần thì mã bị huỷ |
| Gửi lại OTP | Sau 60 giây, tính riêng cho từng mục đích (đăng ký, thiết bị mới, quên mã) |
| Số OTP mỗi số điện thoại | Tối đa 5 mã mỗi giờ, gộp mọi mục đích |
| Khoá tạm đăng nhập | Sai 5 lần liên tiếp thì khoá 15 phút |
| `registrationToken` / `challengeId` / `resetToken` | 15 / 15 / 10 phút, dùng một lần |
| Rate limit chung | 100 request/phút mỗi IP |
| Rate limit `/auth/*` | 10 request/phút mỗi IP (`/auth/refresh`: 30/phút) |
| Phân trang | `limit` 1–100, mặc định 20 |

Rate limit theo IP nhưng nhiều thiết bị dùng 4G có thể chung một IP, nên mức 10 request/phút cho `/auth/*` cần theo dõi khi có nhiều người dùng thật.

## Môi trường test và câu hỏi còn mở

Hiện backend **chưa gửi SMS thật**: ở môi trường dev, OTP được in ra log server (dòng `[SMS] [not sent] to +84...`). Khi test trên máy, cần xin backend mã OTP từ log hoặc tự chạy backend local theo README của repo (`docker compose up -d` rồi `npm run start:dev`). Giới hạn gửi lại 60 giây và 5 mã mỗi giờ vẫn áp dụng khi test.

Câu hỏi còn mở:

- [ ] `BASE_URL` của môi trường dev/staging là gì? Hiện chưa deploy.
- [ ] Nhà cung cấp SMS thật (eSMS, SpeedSMS, Twilio...) và thời điểm tích hợp.
- [ ] API upload ảnh đại diện: hiện app phải tự có URL `https://` để gửi vào `avatarUrl`.
- [ ] Push notification token chưa nằm trong API thiết bị; cần thống nhất có gắn vào `deviceId` hay không.
- [ ] Backend cần cấu hình `trust proxy` khi chạy sau load balancer. Nếu không, mọi request sẽ bị tính chung một IP và đụng rate limit rất nhanh.
- [ ] Driver và merchant sẽ có ở đợt sau; các endpoint hiện tại không đổi khi thêm role.
