## Relevant Files

- `lib/features/auth/presentation/views/login_view.dart` - Becomes the single login screen (phone + code).
- `lib/features/auth/presentation/controllers/login_controller.dart` - Holds both fields, validation, submit, error and lockout state.
- `lib/features/auth/presentation/bindings/login_binding.dart` - Registers `LoginController` and `LoginUseCase`.
- `lib/features/auth/presentation/widgets/auth_phone_number_field.dart` - Phone input, reused (remove country picker part).
- `lib/features/auth/presentation/widgets/login_code_input.dart` - 6-digit hidden code input, reused (add show/hide toggle).
- `lib/features/auth/presentation/controllers/auth_error_message.dart` - Maps failures to messages; trim to login failures.
- `lib/features/auth/domain/usecases/login_with_code_use_case.dart` - Rename/reshape into `LoginUseCase` (phone + code in one call).
- `lib/features/auth/domain/usecases/logout_use_case.dart` - Kept as is.
- `lib/features/auth/domain/repositories/auth_repository.dart` - Shrink to `login` and `logout`.
- `lib/features/auth/data/repositories/auth_repository_impl.dart` - Same shrink.
- `lib/features/auth/data/datasources/auth_remote_data_source.dart` - Keep only `login` and `logout`.
- `lib/features/auth/domain/entities/login_result.dart` - Kept (`authenticated`, `deviceVerificationRequired`).
- `lib/features/auth/domain/entities/phone_number.dart` - Kept; check it no longer needs `Country`.
- `lib/features/auth/domain/entities/auth_exception.dart` - Remove `notSupported` and registration failures.
- `lib/features/verify_otp/**` - Narrow to device verification only (remove `OtpPurpose`, register/forgot branches).
- `lib/app/routes/app_routes.dart`, `lib/app/routes/app_pages.dart` - Remove `loginCode`, `registerFullName`, `createPassword`.
- `lib/core/constants/app_constants.dart` - Set `appRole = 'admin'`.
- `lib/app/translations/locale_keys.dart`, `lib/app/translations/app_translations.dart` - Remove unused keys, add new login strings.
- `lib/features/splash/**`, `lib/features/account/**` - Only check; no logic change expected.
- `test/features/auth/*`, `test/features/verify_otp/*` - No rewrite. Delete tests that no longer compile because their code was removed; keep the ones that still pass untouched.

### Notes

- Delete before you build: remove old code first (tasks 1 and 2), then build the new screen (task 3). The analyzer will point you to every leftover import.
- Do not write or rewrite tests for this change. Only delete tests whose subject was removed.
- Run the tools through fvm: `fvm flutter pub get`, `fvm dart run build_runner build --delete-conflicting-outputs`, `fvm flutter analyze`, `fvm flutter test`.
- Follow `docs/rules/core.md`: use `PrimaryButton` (no custom button), `Obx` in views, no business logic in views, lines of 80 characters or fewer.

## Tasks

- [x] 1.0 Remove registration, forgot-code, Google sign-in and country/language picker
  - [x] 1.1 Delete the screens and their bindings/controllers: `login_code_*`, `register_full_name_*` (view, controller, binding).
  - [x] 1.2 Delete use cases: `complete_registration`, `request_login_code_reset`, `sign_in_with_google`, `start_phone_auth`, `validate_full_name`.
  - [x] 1.3 Delete entities and models: `registration_credentials`, `phone_auth_step`, `country`, and `otp_dispatch` only if `LoginResult` stops using it (see 4.3).
  - [x] 1.4 Delete widgets: `social_sign_in_section`, `language_selector_button`, `selection_sheet`, `forgot_login_code_button`, `request_otp_button`. Check `auth_hero` and keep it only if it still looks right on a CMS login.
  - [x] 1.5 Cut `AuthRepository`, `AuthRepositoryImpl` and `AuthRemoteDataSource` down to `login` and `logout`. Remove `requestRegistrationOtp`, `completeRegistration`, `requestLoginCodeResetOtp`, `signInWithGoogle`.
  - [x] 1.6 Remove the routes `loginCode` and `registerFullName` from `app_routes.dart` and `app_pages.dart`.
  - [x] 1.7 Run `fvm flutter analyze` and fix the broken imports left behind.

- [x] 2.0 Remove `create_password` and narrow `verify_otp` to device verification
  - [x] 2.1 Delete the whole folder `lib/features/create_password` and the route `createPassword`.
  - [x] 2.2 In `verify_otp`, delete `OtpPurpose` and the `purpose` field of `VerifyOtpArguments`. The screen now only verifies a login device.
  - [x] 2.3 Make `challengeId` required in `VerifyOtpArguments`. Remove the `register` and `forgotPassword` branches from `OtpRepositoryImpl`, `OtpRemoteDataSource` and `OtpRepository`.
  - [x] 2.4 In `VerifyOtpController`, remove the navigation to `createPassword`. After success it saves the tokens (already done by the repository) and opens `Routes.root` with `Get.offAllNamed`.
  - [x] 2.5 Delete `VerifiedOtp.registrationToken` and other fields that only registration used. Keep what device verification needs.
  - [x] 2.6 Regenerate freezed files (see 5.2) and run `fvm flutter analyze`.

- [x] 3.0 Build the new Login screen
  - [x] 3.1 Create `LoginUseCase` (from `login_with_code_use_case.dart`): validates the phone with `PhoneNumber`, checks the code has 6 digits, then calls `AuthRepository.login`. It returns a `LoginResult`.
  - [x] 3.2 Rewrite `LoginController`: `phone` and `loginCode` as `.obs`, `canSubmit` (valid phone and 6 digits and not loading), `isLoading`, `errorMessage`, `lockedUntil` countdown, and `submit()`.
  - [x] 3.3 Rewrite `LoginView` (`GetView<LoginController>`): headline, `AuthPhoneNumberField`, `LoginCodeInput` with a show/hide toggle, then `PrimaryButton(label: ..., onPressed: ..., isLoading: ...)`.
  - [x] 3.4 Strip the country picker out of `AuthPhoneNumberField`. The number is always Vietnam; show a fixed "+84" prefix or none.
  - [x] 3.5 Show errors under the fields. Wrong credentials give one generic message. Locked accounts show a countdown from `retryAfterSeconds`, and the button stays disabled until it ends.
  - [x] 3.6 Update `LoginBinding` to register `LoginUseCase` and `LoginController`. Keep `AuthRepositoryBinding`.
  - [x] 3.7 Make sure the login screen has no register link, forgot-code link, social buttons or language selector.

- [x] 4.0 Wire the login flow end to end
  - [x] 4.1 Set `AppConstants.appRole = 'admin'` and update its doc comment (it said "customer").
  - [x] 4.2 In `LoginController.submit()`: on `LoginAuthenticated` call `Get.offAllNamed(Routes.root)`. On `LoginDeviceVerificationRequired` call `Get.toNamed(Routes.verifyOtp, arguments: VerifyOtpArguments(...))` with the `challengeId`.
  - [x] 4.3 Check whether `OtpDispatch` is still needed for the device step (resend timer). Keep it if yes, delete it if no.
  - [x] 4.4 Check `SplashController` and `CheckSessionUseCase`: valid session goes to `Routes.root`, otherwise `Routes.login`. Remove any leftover mention of removed routes.
  - [x] 4.5 Check `AccountController.logout()` and the `onSessionExpired` callback in `InitialBinding`. Both must end on `Routes.login`.
  - [x] 4.6 Trim `AuthFailure` and `AuthException` to the failures login can produce (invalid credentials, locked, network, unknown). Update `auth_error_message.dart`.

- [ ] 5.0 Clean up and verify
  - [x] 5.1 Remove unused keys from `locale_keys.dart` and `app_translations.dart`. Add the new login strings (headline, phone hint, code hint, button, generic error, locked message with countdown) in `vi_VN` and `en_US`.
  - [x] 5.2 Run `fvm dart run build_runner build --delete-conflicting-outputs` and delete orphaned `.freezed.dart` / `.g.dart` files of removed classes.
  - [x] 5.3 Delete test files or test cases that fail to compile because the code they cover was removed (login logic, registration, forgot code, `OtpPurpose`). Do not write new tests.
  - [x] 5.4 Run `grep` for `register`, `forgot`, `google`, `country`, `OtpPurpose` and `createPassword` in `lib/` and `test/`. There must be no leftovers.
  - [x] 5.5 Run `fvm flutter analyze` (no issues in `lib/` and `test/`) and `fvm flutter test` (remaining tests pass).
  - [ ] 5.6 Run the app once and check by hand: invalid input, wrong credentials, a correct login, and logout.
