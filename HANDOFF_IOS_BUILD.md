# iOS Build Handoff (2026-02-14 EST)

## What was requested
- User requested fixing the previously reported iOS build errors without undoing existing work.

## What was changed in repo
- `tapwater/ios/Runner.xcodeproj/project.pbxproj`
  - Fixed widget asset config for `TapWaterWidgetExtension`:
    - `ASSETCATALOG_COMPILER_GLOBAL_ACCENT_COLOR_NAME = AccentColor`
    - `ASSETCATALOG_COMPILER_WIDGET_BACKGROUND_COLOR_NAME = WidgetBackground`
- `tapwater/ios/Podfile`
  - Extended `post_install` to:
    - Force any pod target with iOS deployment `< 12.0` up to `12.0`.
    - Remove `PrivacyInfo.xcprivacy` from `in_app_review` **Sources** build phase (keeps it as resource bundle item).
    - Apply sqlite3 target warning hardening:
      - `GCC_TREAT_WARNINGS_AS_ERRORS = NO`
      - `GCC_WARN_INHIBIT_ALL_WARNINGS = YES`
      - Append warning flags:
        - `-Wno-ambiguous-macro`
        - `-Wno-shorten-64-to-32`
        - `-Wno-comma`
        - `-Wno-unreachable-code`
- `tapwater/ios/Podfile.lock`
  - Updated only `PODFILE CHECKSUM` after `pod install`.

## Verification completed
- Ran: `cd tapwater/ios && pod install` (successful).
- Confirmed generated pods project state:
  - No `IPHONEOS_DEPLOYMENT_TARGET = 11.0` entries remain.
  - `in_app_review` source phase no longer contains `PrivacyInfo.xcprivacy`.
- Ran unsandboxed build:
  - `xcodebuild -workspace ./Runner.xcworkspace -scheme Runner -configuration Debug -destination 'generic/platform=iOS Simulator' build`
  - Result: `** BUILD SUCCEEDED **`
- Ran quiet incremental build log capture:
  - No matches for previous blockers (`database is locked`, accent/background missing, `no rule to process file`, sqlite macro/precision errors).

## Not completed due user interruption
- A full **clean** build was started to force all recompilation and recapture all warnings:
  - `xcodebuild ... clean build -quiet`
  - This was interrupted by user (`turn_aborted`) before completion.

## Remaining / optional cleanup (non-blocking)
- Deprecation warnings from some plugin versions may still appear on clean rebuilds.
- Xcode "Update to recommended settings" warnings were not applied.
- Existing unrelated modified files in worktree were intentionally left untouched.

## Resume commands for next LLM
- `cd tapwater/ios`
- `pod install`
- `xcodebuild -workspace ./Runner.xcworkspace -scheme Runner -configuration Debug -destination 'generic/platform=iOS Simulator' clean build`
- Optional scan after clean build:
  - `xcodebuild ... clean build -quiet > /tmp/tapwater_ios_clean_build.log 2>&1`
  - `rg -n "error:|deprecated|deployment target|recommended settings|database is locked|no rule to process file|Ambiguous expansion of macro" /tmp/tapwater_ios_clean_build.log`

---

# Session Update (2026-02-16)

## User decision
- Fastlane screenshot automation was stopped by request.
- Team is switching to manual Simulator screenshots for Free/Pro/Insights.

## What was fixed in this session
- `tapwater/lib/features/onboarding/onboarding_screen.dart`
  - Default onboarding unit changed to Imperial (`UnitSystem.imperial`).
- `tapwater/lib/features/settings/export_screen.dart`
  - Fixed CSV share failure by passing valid `sharePositionOrigin` to `Share.shareXFiles`.
  - Added export button `GlobalKey` and origin rect fallback.
  - Reduced date-range picker overflow risk:
    - `initialEntryMode: DatePickerEntryMode.calendarOnly`
    - picker wrapped with `MediaQuery(... textScaler: TextScaler.linear(1.0))`
- `tapwater/lib/features/settings/settings_screen.dart`
  - `Contact Support` now opens mail app via `mailto:tapwater@use.startmail.com`.
  - Added fallback snackbar if no email app is available.
- `README.md`
  - Added explicit screenshot filename convention:
    - `{lang}_{device}_{tier}_{nn}_{screen}.png`
  - Clarified one file == one tier (`free` or `pro` or `insights`), never combined tiers.

## Validation completed
- `flutter analyze` passed for:
  - `tapwater/lib/features/onboarding/onboarding_screen.dart`
  - `tapwater/lib/features/settings/export_screen.dart`
  - `tapwater/lib/features/settings/settings_screen.dart`

## Known blocker still unresolved
- Fastlane/snapshot runs repeatedly stall after `RunnerUITests.xctest` is touched.
- No screenshots were generated through fastlane during this session.
- Manual simulator capture is currently the practical path.

## Manual screenshot workflow to continue
1. Open `tapwater/ios/Runner.xcworkspace` in Xcode.
2. Select `Runner` scheme + target simulator.
3. Set Run Arguments:
   - `--ui-testing`
   - `-tapwater_screenshot_tier`
   - `<free|pro|insights>`
4. Run (`Cmd+R`) and capture via Simulator (`Cmd+S` or `xcrun simctl io booted screenshot ...`).
5. Use naming:
   - `{lang}_{device}_{tier}_{nn}_{screen}.png`
   - example: `en-US_iphone12pro_free_01_home.png`

## Immediate next checks recommended
- Re-test Export CSV on Insights to confirm `sharePositionOrigin` fix on device/simulator.
- Re-open Date Range picker and verify no bottom overflow warning.
- Confirm onboarding starts with Imperial selected.

---

# App Store Rejection & Resubmission (2026-02-20)

## Rejection details

- **Submission ID:** 38b080a7-dffb-46b0-a591-2a6a885b59c6
- **Review date:** February 19, 2026
- **Version reviewed:** 1.0.0 (1)
- **Review device:** iPad Air 11-inch (M3)
- **Guideline:** 3.1.2 – Business – Payments – Subscriptions

## What Apple said

The submission did not include all required information for apps offering auto-renewable subscriptions. Specifically, the paywall did not contain a functional link to the Terms of Use (EULA). Apple requires that apps with auto-renewable subscriptions display the following directly in the purchase flow:

- Title of the auto-renewing subscription
- Length of subscription
- Price (and price per unit if applicable)
- Functional links to Privacy Policy and Terms of Use (EULA)

The App Store metadata (App Description field in ASC) also must include a functional Terms of Use link.

## What was fixed

### Code — `tapwater/lib/features/paywall/paywall_screen.dart`

- Added `url_launcher` import.
- Added a `Wrap` row at the bottom of the paywall with two tappable links:
  - **Privacy Policy** → `https://nodelabstudio.github.io/tapwater/privacy-policy.html`
  - **Terms of Use** → `https://nodelabstudio.github.io/tapwater/terms.html`
- Added `_openUrl()` helper using `launchUrl` with `LaunchMode.externalApplication`.
- Added `insightsActive` variable; disabled **No thanks** and **Restore Purchases** buttons when the user already has an active Insights subscription (bonus correctness fix caught during this pass).

### Metadata — App Store Connect

- Added a functional Terms of Use link to the App Description in App Store Connect to satisfy the metadata requirement.

## Resubmission status

- Resubmitted February 20, 2026 with the above fixes applied.
- Awaiting Apple review.
