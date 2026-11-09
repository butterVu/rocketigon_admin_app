# Tasks: Khung feature quản lý Đồ ăn, Thuê xe và Tài chính

PRD nguồn: [prd-management-tabs.md](prd-management-tabs.md).

## Phạm vi

Tạo ba feature `food`, `car_rental`, `finance` với view, controller và
binding trong presentation; tích hợp ba tab vào Root. Không tạo domain,
data, API hoặc nghiệp vụ quản lý.

## Relevant Files

Các tệp hiện có dưới đây là ứng viên cần khảo sát bằng GitNexus trước khi
quyết định sửa; danh sách không phải kết luận về quan hệ gọi hoặc tác động.

- `lib/features/root/presentation/views/root_view.dart` — màn hình Root.
- `lib/features/root/presentation/controllers/root_controller.dart` — trạng thái tab.
- `lib/features/root/presentation/bindings/root_binding.dart` — binding của Root.
- `lib/features/root/presentation/widgets/root_bottom_navigation_bar.dart` — thanh tab.
- `lib/features/root/presentation/widgets/root_tab_content.dart` — nội dung tab.
- `lib/app/routes/app_routes.dart` — kiểm tra cách gắn binding tại route Root;
  chỉ sửa nếu cơ chế hiện có yêu cầu.

Các tệp dự kiến tạo:

- `lib/features/food/presentation/views/food_view.dart` — tiêu đề Đồ ăn.
- `lib/features/food/presentation/controllers/food_controller.dart` — controller Đồ ăn.
- `lib/features/food/presentation/bindings/food_binding.dart` — đăng ký controller.
- `lib/features/car_rental/presentation/views/car_rental_view.dart` — tiêu đề Thuê xe.
- `lib/features/car_rental/presentation/controllers/car_rental_controller.dart` — controller Thuê xe.
- `lib/features/car_rental/presentation/bindings/car_rental_binding.dart` — đăng ký controller.
- `lib/features/finance/presentation/views/finance_view.dart` — tiêu đề Tài chính.
- `lib/features/finance/presentation/controllers/finance_controller.dart` — controller Tài chính.
- `lib/features/finance/presentation/bindings/finance_binding.dart` — đăng ký controller.
- `test/features/root/presentation/root_navigation_test.dart` — đường dẫn dự kiến
  cho kiểm tra chuyển tab và dependency; ưu tiên bổ sung test hiện có nếu phù hợp.

## Tasks

- [x] 1.0 Khảo sát cấu trúc Root và vòng đời tab bằng GitNexus; chạy impact
  trước khi sửa các symbol liên quan và báo cáo callers, processes, risk.
  - [x] 1.1 Đọc các quy tắc và skill Flutter UI, GetX state/routing, impact
    áp dụng cho thay đổi; kiểm tra runner và độ mới của index GitNexus.
  - [x] 1.2 Dùng query cho luồng điều hướng Root và context cho các symbol
    liên quan; đọc source sau kết quả graph để xác định nơi khai báo tab,
    nội dung, tab mặc định và nơi đăng ký dependency.
  - [x] 1.3 Chạy impact upstream cho từng symbol hiện có cần chỉnh sửa;
    báo cáo callers, processes và risk trước khi sửa. Cảnh báo HIGH/CRITICAL;
    với UNKNOWN, xác minh thêm bằng tìm kiếm văn bản, không coi là an toàn.
  - [x] 1.4 Chốt danh sách tệp thực tế cần sửa và bổ sung vào Relevant Files;
    không thay đổi cơ chế điều hướng nếu không cần thiết.
- [x] 2.0 Tạo khung presentation cho ba feature Đồ ăn, Thuê xe và Tài chính,
  mỗi feature có view chỉ hiển thị tiêu đề, controller và binding riêng.
  - [x] 2.1 Tạo `food/presentation/` với FoodView, FoodController và
    FoodBinding; màn hình hiển thị “Đồ ăn”.
  - [x] 2.2 Tạo `car_rental/presentation/` với CarRentalView,
    CarRentalController và CarRentalBinding; màn hình hiển thị “Thuê xe”.
  - [x] 2.3 Tạo `finance/presentation/` với FinanceView, FinanceController
    và FinanceBinding; màn hình hiển thị “Tài chính”.
  - [x] 2.4 Dùng GetView, GetxController và binding đăng ký lazy theo quy
    ước dự án. Không thêm trạng thái giả, data/domain, API hoặc package.
- [x] 3.0 Tích hợp ba tab vào Root theo cơ chế điều hướng hiện có, bảo đảm
  đăng ký controller đúng vòng đời và giữ hành vi các tab hiện tại.
  - [x] 3.1 Thêm ba mục tab có nhãn Đồ ăn, Thuê xe, Tài chính và biểu tượng
    từ bộ hiện có; giữ thứ tự tương đối của tab cũ và ba tab mới.
  - [x] 3.2 Gắn mỗi tab với view tương ứng; bảo đảm chỉ số hoặc định danh tab
    thống nhất giữa controller, thanh điều hướng và nội dung.
  - [x] 3.3 Gắn ba binding theo vòng đời Root/tab hiện có để controller sẵn
    sàng trước khi view dùng và không đăng ký trùng khi chuyển tab.
  - [x] 3.4 Giữ tab mặc định, hành vi tab cũ và theme hiện tại; tránh hiển thị
    lặp tiêu đề nếu shell Root đã cung cấp tiêu đề.
- [ ] 4.0 Kiểm tra giao diện, chuyển tab và dependency; định dạng Dart và
  chạy phân tích tĩnh cùng kiểm tra phù hợp cho điều hướng thay đổi.
  - [x] 4.1 Bổ sung hoặc điều chỉnh widget test phù hợp cho việc chọn ba tab,
    nội dung/tiêu đề tương ứng và chuyển qua lại không lỗi dependency;
    kiểm tra các tab cũ và tab mặc định vẫn giữ hành vi.
  - [x] 4.2 Chạy `fvm dart format <các tệp Dart thay đổi>`,
    `fvm flutter analyze` và `fvm flutter test <test liên quan>` khi FVM
    có sẵn; ghi rõ lỗi có sẵn hoặc kiểm tra không chạy được.
  - [ ] 4.3 Kiểm tra trực quan trên môi trường chạy sẵn có: nhãn, biểu tượng,
    trạng thái chọn và tiêu đề không lặp; báo cáo nếu chưa chạy được.
  - [x] 4.4 Rà soát phạm vi: chỉ ba feature presentation, không data/domain,
    dữ liệu mẫu, API hoặc code sinh tự động; cập nhật tiến độ task và kết quả.
  - [x] 4.5 Nếu có yêu cầu commit, đọc skill gitflow, chạy GitNexus
    detect_changes scope all trước commit và xử lý kết quả partial/truncated;
    không tự commit hoặc push trong bước tạo danh sách công việc này.

## Ghi chú

- Bước 1.1: đã đọc các skill áp dụng. Runner tồn tại và khởi động được sau
  khi cấp quyền ngoài sandbox. Index tại repository này trỏ commit
  `52e41457e7d934e30d5e9831f61e6a8af8009001`, khớp HEAD; đối chiếu SHA-256
  không thấy tệp `lib/` thay đổi hoặc tệp `lib/` mới so với metadata index.
  Lệnh `status --repo .` chưa kết thúc; chưa có kết quả query/impact và
  chưa xác nhận đầy đủ khả năng truy vấn graph. Không sửa code ứng dụng.

- Đã triển khai ba feature và tích hợp Root; kết quả kiểm tra ghi dưới đây.
- Đã chạy query, context và impact trên index hiện tại; tìm kiếm FTS bị hạn chế. Trước đó chỉ xác nhận đường dẫn, chưa chạy phân tích
  graph hoặc kết luận risk. Các kiểm tra đó thuộc nhiệm vụ 1.0 trước khi sửa.
- Dùng FVM khi có sẵn. Không thêm package hoặc sinh mã cho phạm vi này.

## Kết quả triển khai

- Người dùng yêu cầu làm toàn bộ, bỏ checkpoint xác nhận giữa các sub-task.
- Đã tạo 9 tệp presentation, sửa RootTab/RootBinding/RootTabContent và thêm khóa dịch VI/EN. RootView và thanh navigation hiện có tự sinh từ enum nên không cần sửa; không sửa route.
- Relevant Files bổ sung: lib/app/translations/locale_keys.dart và lib/app/translations/app_translations.dart (nhãn tab). Các tệp RootView, root_bottom_navigation_bar.dart và app_routes.dart chỉ khảo sát, không sửa.
- Impact: RootBinding LOW (AppPages); RootTabContent LOW (RootView.build); AppTranslations LOW (main); LocaleKeys MEDIUM (các nơi import). Không có process graph được xác định. RootTab UNKNOWN đã xác minh bằng rg ở controller, navigation bar, RootView và RootTabContent; không coi zero callers là unused.
- detect-changes scope all: 7 tệp tracked, 15 symbols, risk LOW, 0 process; không có cờ partial/truncated. Kết quả có cả thay đổi AGENTS.md/CLAUDE.md có sẵn, không phải do tác vụ này. Tệp mới chưa tracked không được kết quả này bao phủ.
- Format thành công; flutter test: 9/9 pass, gồm regression test chuyển tab và dependency.
- flutter analyze toàn repo: hai cảnh báo unused_field/unused_element trong packages/dragon_design/example/lib/main.dart, ngoài phạm vi sửa.
- 4.3 chưa chạy kiểm tra tương tác trực tiếp trên thiết bị; widget test đã render và chuyển tab thành công. Không báo đã kiểm tra thủ công.
- 4.5: đã kiểm tra graph changes; không commit/push vì người dùng chỉ yêu cầu triển khai. Sau phản hồi của người dùng về Gitflow: tạo develop từ main (repo chưa có develop), rồi chuyển sang feature/management-tabs từ develop; giữ nguyên toàn bộ thay đổi chưa commit.
- flutter analyze lib test: No issues found.

- Người dùng đã yêu cầu push và tạo PR: chuẩn bị commit phần feature, giữ AGENTS.md/CLAUDE.md/.agents ngoài commit; PR từ feature/management-tabs vào develop. Kiểm tra trực tiếp thiết bị tại 4.3 vẫn chưa thực hiện.
