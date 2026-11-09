# PRD: CMS Login (phone + code)

## 1. Introduction / Overview

Rocketigo Admin is a CMS app for operations staff. Today the auth feature is copied from the customer app: it has registration, "forgot code", Google sign-in, a country picker and a language picker. None of these make sense for a CMS, where accounts are created by an administrator.

This PRD replaces the current auth flow with a **single login screen** that has two text fields: **phone number** and **login code**. Everything else in the old flow is removed.

**Goal:** a staff member can sign in with phone number + 6-digit code, and nothing else is offered on the auth screen.

## 2. Goals

1. The auth feature exposes exactly one user-facing screen: Login.
2. All registration, forgot-code, Google sign-in and picker code is deleted (UI, use cases, data sources, models, translations, tests).
3. Existing session behavior (token storage, refresh, logout, splash session check) keeps working unchanged.
4. After the change, `flutter analyze` is clean and all remaining tests pass.

## 3. User Stories

- As an operations staff member, I want to enter my phone number and login code so that I can open the CMS.
- As a staff member on a new device, I want to confirm the device with an OTP when the server asks, so that I can still sign in.
- As a staff member who is locked out after too many wrong attempts, I want to see how long to wait, so that I know when I can try again.
- As a signed-in staff member, I want to be taken straight to the app on launch, and to sign out from the account tab.

## 4. Functional Requirements

### Login screen
1. The Login screen must show the app name/headline "Rocketigo Admin" and exactly two inputs: **Phone number** and **Login code**, plus one **primary button** (`PrimaryButton`) to sign in.
2. The phone field must accept digits only and be validated with the existing phone number rules (Vietnam number).
3. The login code field must accept exactly **6 digits**, hide the characters, and have a show/hide toggle.
4. The sign-in button must be disabled until the phone is valid and the code has 6 digits. While the request is running it must show `isLoading` and ignore further taps.
5. On submit the app must call `POST /auth/login` with `phone`, `loginCode`, `app`, `deviceId` and `deviceName`, using the existing device identity service.
6. When the response has `nextStep = AUTHENTICATED`, the app must save the tokens and open the root screen (`Routes.root`), clearing the back stack.
7. When the response has `nextStep` asking for device verification, the app must open the existing **Verify OTP** screen with the `challengeId`. After a successful verification it must save the tokens and open the root screen.
8. Errors must be shown with the existing error message mapping:
   - wrong phone or code (`AUTH_INVALID_CREDENTIALS`): one generic message, "phone or code is incorrect", without saying which one is wrong;
   - locked (`AUTH_LOGIN_LOCKED`): message with a countdown from `details.retryAfterSeconds`; the button stays disabled until it ends;
   - network or unknown errors: generic retry message.
9. The Login screen must not contain: register link, "forgot code" link, Google/social buttons, country picker, language selector.

### Removed flows
10. The following must be deleted completely, including routes, bindings, controllers, views, widgets, use cases, repository methods, data source methods, models, entities, translation keys and tests:
    - Registration (`register_full_name`, `completeRegistration`, `requestRegistrationOtp`, `RegistrationCredentials`).
    - Forgot login code (`requestLoginCodeReset`, `login_code` screen if only used for that, reset flow).
    - Google sign-in (`signInWithGoogle`, `social_sign_in_section`).
    - Country and language selection (`Country`, `selection_sheet`, `language_selector_button`).
    - The `create_password` feature, since it is only reachable from registration and reset (see Open Questions).

### Kept behavior
11. **Splash** keeps checking the stored session: valid session → root, otherwise → login.
12. **Logout** in the account tab keeps calling `POST /auth/logout` and then opens Login.
13. **Token refresh** in the network interceptor stays as is. If refresh fails, the user returns to Login.
14. **Verify OTP** is kept only for the new-device step of login. Its registration and password-reset purposes must be removed, so the screen no longer needs `OtpPurpose` branching.

## 5. Non-Goals (Out of Scope)

- Creating accounts, resetting or changing the login code (done by an administrator outside the app).
- Social login, biometric login, "remember me".
- Language switching (the app stays Vietnamese with English fallback).
- Role/permission based screens inside the CMS.
- Any change to the backend.

## 6. Design Considerations

- Use `dragon_design` components: `PrimaryButton` (never a custom styled button), existing text styles and colors.
- Layout: headline at the top, phone field, code field, sign-in button below. Keep the existing `auth_hero` only if it fits a CMS; otherwise a simple logo + title.
- Bottom sheets with the keyboard: follow the project rule in `docs/rules/core.md`.
- Strings go through `LocaleKeys` and `AppTranslations`; delete keys that become unused.

## 7. Technical Considerations

- Keep CLEAN structure: `LoginController` calls a single `LoginUseCase`; the repository exposes only `login`, `logout` (and device OTP verification stays in `verify_otp`).
- `AuthRepository`, `AuthRemoteDataSource` and their implementations must shrink to the methods still used. Update the unit tests in `test/features/auth/` and `test/features/verify_otp/` accordingly.
- Regenerate freezed/json files with `build_runner` after removing models and entities.
- `AppConstants.appRole` currently equals `customer`. It must be changed to the CMS role value.
- Check `lib/core/network` and `splash` for references to removed code before deleting.

## 8. Success Metrics

- A staff member with a valid account signs in with two fields and one tap.
- Zero references to registration, forgot code, Google sign-in or country/language picker remain in `lib/` and `test/`.
- `flutter analyze` reports no issues and `flutter test` passes.
- Error cases (wrong credentials, locked account, new device) each have a passing test.

## 9. Open Questions

1. What is the exact `app` value the backend expects for CMS accounts (for example `admin` or `operator`)?
2. Can `create_password` be deleted? It was not marked for deletion explicitly, but nothing in the new flow opens it.
3. Does the CMS backend really return `nextStep` for new devices? If not, Verify OTP can also be removed later.
4. Is the phone number still a Vietnam number only, or do staff use other country codes?
5. Should the app show a version/environment label on the login screen (for example staging)?
