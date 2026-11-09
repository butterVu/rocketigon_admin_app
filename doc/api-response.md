# Chuẩn response API

Mọi endpoint của Rocketio đều trả JSON theo một trong ba dạng dưới đây. Format này được áp dụng tự động ở tầng global ([response.interceptor.ts](../src/common/interceptors/response.interceptor.ts) và [all-exceptions.filter.ts](../src/common/filters/all-exceptions.filter.ts)), nên controller chỉ cần trả dữ liệu hoặc throw exception. Module mới không cần, và không được, tự bọc response.

## 1. Thành công

```json
{
  "success": true,
  "data": { "id": "665f1c2e8b3e4a0012345678", "fullName": "Nguyen Van A" }
}
```

| Field | Kiểu | Ghi chú |
| --- | --- | --- |
| `success` | `true` | Luôn có |
| `data` | object, array hoặc `null` | Giá trị handler trả về. Handler không trả gì thì là `null` |
| `meta` | object | Chỉ có ở danh sách phân trang |

### Danh sách phân trang

```json
{
  "success": true,
  "data": [{ "id": "..." }, { "id": "..." }],
  "meta": { "page": 1, "limit": 20, "total": 42, "totalPages": 3 }
}
```

- Query: `page` (từ 1, mặc định 1), `limit` (1–100, mặc định 20).
- `data` luôn là mảng; trang rỗng thì là `[]`, không phải `null`.

### Không có nội dung

Hành động không cần trả dữ liệu (logout, xoá, đổi mã) trả **`204 No Content` và không có body**. Client không được parse JSON với status 204.

## 2. Lỗi

```json
{
  "success": false,
  "error": {
    "statusCode": 409,
    "code": "USER_EMAIL_TAKEN",
    "message": "Email is already used by another account"
  },
  "path": "/api/v1/users/me",
  "timestamp": "2026-10-08T10:00:00.000Z"
}
```

| Field | Kiểu | Ghi chú |
| --- | --- | --- |
| `success` | `false` | Luôn có |
| `error.statusCode` | number | Trùng HTTP status |
| `error.code` | string | Mã ổn định, `UPPER_SNAKE_CASE`. **Client rẽ nhánh theo field này** |
| `error.message` | string | Tiếng Anh, để debug. Không hiển thị thẳng cho người dùng |
| `error.details` | any | Không bắt buộc; dữ liệu kèm theo, tuỳ từng `code` |
| `path` | string | Path của request |
| `timestamp` | string | ISO 8601 UTC |

### Lỗi validate

```json
{
  "success": false,
  "error": {
    "statusCode": 400,
    "code": "VALIDATION_FAILED",
    "message": "Validation failed",
    "details": [
      { "field": "phone", "messages": ["phone must be a valid phone number"] },
      { "field": "address.city", "messages": ["city should not be empty"] }
    ]
  },
  "path": "/api/v1/auth/register/otp",
  "timestamp": "2026-10-08T10:00:00.000Z"
}
```

- `field` dùng dấu chấm cho object lồng nhau.
- Field không có trong DTO cũng bị báo lỗi ở đây (`property x should not exist`).

### Mã lỗi chung

Mã chưa đặt riêng thì được suy ra từ HTTP status.

| HTTP | `code` mặc định | Khi nào |
| --- | --- | --- |
| 400 | `BAD_REQUEST` | Request sai mà không có mã riêng |
| 401 | `UNAUTHORIZED` | |
| 403 | `FORBIDDEN` | |
| 404 | `NOT_FOUND` | Route không tồn tại |
| 409 | `CONFLICT` / `DUPLICATE_KEY` | `DUPLICATE_KEY` khi vi phạm unique index của MongoDB |
| 429 | `TOO_MANY_REQUESTS` | Vượt rate limit; có header `Retry-After` (giây) |
| 500 | `INTERNAL_SERVER_ERROR` | Lỗi không lường trước. `message` luôn là `Internal server error`; chi tiết chỉ nằm trong log server |

Danh sách mã nghiệp vụ (auth, OTP, user...) xem ở [README](../README.md#mã-lỗi-chính).

## 3. Quy ước dữ liệu

- Tên field: `camelCase`.
- `id`: chuỗi hex 24 ký tự (ObjectId của MongoDB).
- Ngày giờ: chuỗi ISO 8601 UTC, ví dụ `2026-10-08T10:00:00.000Z`.
- Field không có giá trị được trả là `null`, không bị bỏ đi (ví dụ `"email": null`).
- Số điện thoại: E.164, ví dụ `+84912345678`.
- Response chỉ chứa field được khai báo trong ResponseDto. Field nội bộ (hash, bộ đếm, khoá) không bao giờ xuất hiện.

## 4. Áp dụng khi viết endpoint mới (backend)

**Thành công:** trả dữ liệu, không tự bọc `{ success, data }`.

```ts
@Get('me')
@ApiSuccessResponse(UserResponseDto)          // Swagger hiển thị đúng envelope
async getMe(@CurrentUser('id') id: string): Promise<UserResponseDto> {
  return UserResponseDto.from(await this.usersService.getById(id));
}
```

**Danh sách:** trả `Paginated`, interceptor tự tách thành `data` + `meta`.

```ts
@Get()
@ApiSuccessResponse(UserResponseDto, { paginated: true })
async findAll(@Query() query: QueryUsersDto): Promise<Paginated<UserResponseDto>> {
  const page = await this.usersService.findAll(query);   // Paginated.of(items, total, query)
  return page.map((user) => UserResponseDto.from(user));
}
```

**Không có nội dung:** khai báo `204`.

```ts
@Delete(':id')
@HttpCode(HttpStatus.NO_CONTENT)
@ApiNoContentResponse()
async remove(@Param() { id }: MongoIdParamDto): Promise<void> { ... }
```

**Lỗi:** throw exception có sẵn của Nest, kèm `code` riêng. Không bắt lỗi rồi tự `res.status().json()`.

```ts
throw new NotFoundException({
  code: 'ORDER_NOT_FOUND',
  message: `Order "${id}" not found`,
  details: { orderId: id },        // không bắt buộc
});
```

- Đặt `code` theo dạng `<DOMAIN>_<VẤN_ĐỀ>`: `ORDER_NOT_FOUND`, `PAYMENT_DECLINED`.
- Lỗi dùng lại nhiều nơi thì tạo class riêng, xem [credential.exceptions.ts](../src/modules/users/exceptions/credential.exceptions.ts).
- Đã công bố `code` cho client thì không đổi tên; muốn đổi ý nghĩa thì tạo mã mới.
- Không đưa thông tin nhạy cảm (stack, query, giá trị secret) vào `message` hay `details`.
