# TapWater - Hydration Tracker — Launch TODOs (Ordered)

## Current status (Feb 20, 2026)

- [x] v1.0.0 (build 1) submitted to App Store review.
- [x] Rejected Feb 19 — Guideline 3.1.2 (missing Terms of Use link in paywall + ASC description).
- [x] Fix applied: ToS and Privacy Policy links added to paywall_screen.dart; ToS link added to ASC app description.
- [x] Resubmitted Feb 20, 2026. Awaiting Apple review.

## Previous status (Feb 16, 2026)

- [x] Fastlane/snapshot automation is removed from launch flow (manual screenshots only).
- [x] Physical iPhone validation completed: CSV export works and Apple Health water write sync is working.

---

## 1) Device-first product QA (manual only)

- [x] Free tier pass on iPhone:
  - quick add (+ water), progress ring math, reminders, onboarding defaults, settings links.
- [x] Pro tier pass on iPhone:
  - non-water drinks, custom drink create/edit/delete, entry edit/delete, backdate, full history, day boundary.
- [x] Insights tier pass on iPhone:
  - analytics cards, streak calculations (`Current Streak` and `Longest Streak`), daily notes/tags, CSV export share sheet, HealthKit write sync, accent themes.
- [x] Purchase and entitlement pass:
  - paywall loads real RevenueCat offerings.
  - [x] sandbox purchase for Pro succeeded.
  - [x] sandbox subscription for Insights Monthly succeeded (after Pro).
  - [x] restore purchases tested with Sandbox caveat:
    - Pro restores correctly.
    - Insights may require repurchase in Sandbox when subscription expires (expected Sandbox behavior).
- [x] Widget pass:
  - small + medium widget reflect latest totals/recent entries after add/edit/delete.

## 2) Regression checks before metadata lock

- [x] Re-test the iPhone 12 simulator crash paths:
  - add custom drink.
  - add note/tag.
- [x] Re-test date range picker overflow behavior on smaller phones.
- [x] Re-test contact support `mailto:` flow and fallback snackbar behavior.
- [x] Paywall UX state check:
  - When Insights is active, `No thanks, continue with Free` and `Restore Purchases` are disabled (grayed out).

## 3) Manual screenshot capture (no Fastlane)

- [x] Capture screenshots manually in Simulator (Cmd+S or `xcrun simctl io booted screenshot ...`).
- [x] Capture by tier in separate passes:
  - Free: Today, History basic, Settings.
  - Pro: favorites/custom drinks/editing/full history/day boundary.
  - Insights: analytics/tags/export/accent colors.
- [x] Follow filename convention:
  - `{lang}_{device}_{tier}_{nn}_{screen}.png`
  - Example: `en-US_iphone12pro_free_01_home.png`
- [x] Keep localization/device sets complete and consistent before uploading.

## 4) App Store Connect: Prepare for Submission (full checklist)

### 4.1 App Information (General)

- [x] `Name` (max 30 chars), `Subtitle` (max 30 chars).
- [x] `Bundle ID` matches Xcode (`com.tapwater.app`).
- [x] `SKU` (internal, immutable).
- [x] `Primary Language` set correctly.
- [x] `Category` set (Primary: Health & Fitness; optional Secondary).
- [x] `Content Rights` confirmed.
- [x] `Age Rating` questionnaire completed.
- [x] `License Agreement` (Apple EULA or custom).
- [x] `Privacy Policy URL` set:
  - `https://nodelabstudio.github.io/tapwater/privacy-policy.html`
- [x] `URL for App Store Server Notifications` (optional, only if used for IAP server events).
- [x] DSA trader details handled if applicable for EU distribution.

### 4.2 iOS Version Information (Prepare for Submission page)

- [x] Localized metadata:
  - description, keywords, support URL, marketing URL (optional), promotional text (optional).
- [x] `What’s New in This Version` set.
- [x] Screenshots uploaded for required iPhone families.
- [x] Version number and copyright.
- [x] **Terms of Use link added to App Description** (fix for 3.1.2 rejection).

### 4.3 App Review Information

- [x] Contact name, email, phone are valid and monitored.
- [x] App Review notes include:
  - how to trigger Pro/Insights features.
  - HealthKit flow explanation.
  - any non-obvious navigation needed for review.

### 4.4 Pricing and Availability

- [x] App price set (`Free` for this app).
- [x] Availability storefronts selected.
- [x] Distribution method confirmed (Public, not private/custom app).
- [x] Tax category verified.
- [x] Release method selected.

### 4.5 App Privacy

- [x] App Privacy questionnaire fully completed and matches actual SDK behavior.
- [x] Nutrition labels are consistent with real data collection behavior.

## 5) In-App Purchases and Subscriptions (must be review-ready)

### 5.1 Pro (non-consumable, one-time)

- [x] Product exists in ASC (non-consumable).
- [x] Product ID matches RevenueCat/offering mapping.
- [x] Metadata complete:
  - reference name, display name, description, review screenshot, review notes.
- [x] Price + availability configured.
- [x] Status is `Ready to Submit`.

### 5.2 Insights (auto-renewable subscription)

- [x] Subscription group exists and naming is final.
- [x] Product exists (`Insights Monthly`) with correct duration and pricing.
- [x] Metadata complete:
  - subscription display name, description, review screenshot, review notes.
- [x] Availability storefronts configured.
- [x] Intro offer fields complete only if intro pricing is enabled.
- [x] Status is `Ready to Submit`.

### 5.3 Submission linking rules

- [x] First IAP/subscription submission is included with a new app version submission.
- [x] App version and both monetization products are submitted in the same release window.
- [x] Paywall copy/prices in app exactly match App Store Connect products.

## 6) Build, archive, and submit

- [x] Archive in Xcode (`Runner` > Any iOS Device).
- [x] Upload to App Store Connect.
- [x] Wait for build processing, then select the correct build on the version page.
- [x] Attach IAPs/subscription to submission if prompted.
- [x] Submit for review.

## 7) Snags that can block submission (prevention list)

- [x] Localization mismatch — cleared.
- [x] Screenshot family mismatch — cleared.
- [x] Metadata mismatch — cleared.
- [x] Agreement/tax/banking not completed — cleared.
- [x] Product status not review-ready — cleared.
- [x] Storefront mismatch — cleared.
- [x] Review credentials missing — cleared.
- [x] HealthKit explanation too thin — cleared.
- [x] Export compliance answers inconsistent — cleared.
- [x] Release control mistake — cleared.
- [x] RevenueCat mapping mismatch — cleared.
- [x] Sandbox confusion during QA — cleared.
- [x] **Terms of Use link missing from paywall + ASC description — HIT (rejection 3.1.2). Fixed and resubmitted Feb 20.**

## 8) App Store review history

### v1.0.0 (build 1) — First submission

| Event | Date | Notes |
|-------|------|-------|
| Submitted | ~Feb 18, 2026 | First submission of new app |
| Rejected | Feb 19, 2026 | Guideline 3.1.2 — missing Terms of Use link in paywall and ASC description |
| Fix applied | Feb 20, 2026 | Added ToS + Privacy links to `paywall_screen.dart`; added ToS link to ASC App Description |
| Resubmitted | Feb 20, 2026 | Awaiting Apple review |

**Rejection details:**
- Submission ID: `38b080a7-dffb-46b0-a591-2a6a885b59c6`
- Review device: iPad Air 11-inch (M3)
- Root cause: Auto-renewable subscriptions require a functional EULA/Terms of Use link directly in the purchase flow and in the App Store metadata. The paywall had a Privacy Policy link but no Terms of Use link.
- Fix: `paywall_screen.dart` now shows both Privacy Policy and Terms of Use as tappable links at the bottom of the paywall. ASC App Description updated with ToS URL.

---

## Completed foundation items

- [x] HealthKit capability set in `RunnerProfile.entitlements`.
- [x] Docs hosted on GitHub Pages (privacy, terms, support).
- [x] Real policy/terms/support URLs wired in app.
- [x] App record created in App Store Connect.
- [x] RevenueCat app, products, entitlements, and offerings created.
- [x] RevenueCat API key present in `purchase_service.dart`.
- [x] App Store ID wired for in-app rate flow.
- [x] Free, Pro, and Insights feature implementation completed.
- [x] Hidden debug tier picker removed from Settings for release behavior.
- [x] Final App Store Connect copy/paste checklist added in `APP_STORE_CONNECT_COPYPASTE.md`.

## Handoff

- iOS build-specific history remains in `HANDOFF_IOS_BUILD.md`.
