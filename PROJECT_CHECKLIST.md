# TapWater - Project Checklist

## App Store Submission Checklist

- [ ] Host docs on GitHub Pages (privacy, terms, support)
- [ ] Update app with real Privacy Policy / Terms URLs
- [ ] Create app in App Store Connect
- [ ] Set up RevenueCat account + products
- [ ] Paste RevenueCat API key into purchase_service.dart
- [ ] Prepare App Store screenshots (5.5" + 6.7")
- [ ] Write App Store description + keywords
- [ ] Archive & upload build from Xcode
- [ ] Submit for review

---

## Feature Status: FREE Tier

| Feature | Status | Notes |
|---------|--------|-------|
| One-tap water logging (quick add) | DONE | +8oz button on Today screen |
| Daily progress ring | DONE | Shows percentage + total/goal |
| Daily goal setting | DONE | Configurable in Settings |
| Metric / Imperial units | DONE | Toggle in Settings |
| Onboarding flow (units, goal, reminders) | DONE | 4-step onboarding |
| Reminder notifications | DONE | Configurable interval + time window |
| Milestone messages | DONE | Motivational text based on progress |
| Favorites bar (Water only for free) | DONE | Non-water types gated behind Pro |
| Home screen widgets (small + medium) | DONE | SwiftUI WidgetKit integration |
| Light / Dark / System theme | DONE | Manual toggle in Settings |
| Launch screen (icon + name) | DONE | Storyboard with app icon |
| Privacy manifest | DONE | PrivacyInfo.xcprivacy created |
| Rate app prompt | DONE | in_app_review in Settings |
| Dynamic version display | DONE | package_info_plus in Settings |
| Privacy Policy link | DONE | URL placeholder - needs real URL |
| Terms of Service link | DONE | URL placeholder - needs real URL |
| Snackbar auto-dismiss | DONE | Manual Future.delayed fix |
| Delete All Data | DONE | Settings > Data |

## Feature Status: PRO Tier ($4.99 one-time)

| Feature | Status | Notes |
|---------|--------|-------|
| Multi-beverage tracking | DONE | 8 default types, gated in favorites + drink picker |
| Custom drink types | NOT STARTED | DB infrastructure exists, NO creation UI |
| Edit & delete entries | DONE | entry_edit_sheet.dart with full editing |
| Backdate entries | DONE | Date picker in entry edit sheet |
| Full history access | DONE | Calendar + bubble view + daily entries |
| Shift worker day boundary | DONE | Settings > Day Boundary (0-6 hours) |
| Home screen widgets | DONE | Included in free (listed as Pro on paywall) |
| Apple Watch app | NOT STARTED | Only enum entry exists |

## Feature Status: INSIGHTS Tier ($1.99/mo)

| Feature | Status | Notes |
|---------|--------|-------|
| Trend analytics & charts | PARTIAL | Weekly bar chart exists, no deeper analytics |
| Daily tags & notes | NOT STARTED | DB table + DAO exist, NO UI |
| CSV export | NOT STARTED | No code exists |
| HealthKit sync | NOT STARTED | No code exists |
| Custom themes | PARTIAL | Only Light/Dark/System, no custom colors |

---

## Infrastructure Status

| Component | Status | Notes |
|-----------|--------|-------|
| RevenueCat integration | DONE (code) | API key placeholder - needs real key |
| Purchase flow (paywall) | DONE | Fetches offerings + calls purchase() |
| Paywall gating logic | DONE | PurchaseTier enum with gate checks |
| Drift database | DONE | All tables, DAOs, migrations |
| Riverpod state management | DONE | Providers for all features |
| go_router navigation | DONE | Shell route with 3 tabs + onboarding |
| App icon | DONE | flutter_launcher_icons generated |
| Widget extension | DONE | Small + Medium iOS widgets |
| Entitlements (App Groups) | DONE | Both Runner + Widget targets |

---

## Known Issues

- Amount field in drink picker shows raw ml (250) instead of display units when imperial
- Paywall lists "Apple Watch app" but no watch app exists
- Paywall lists features not yet implemented (CSV, HealthKit, tags, custom themes)
- Consider removing unimplemented features from paywall until they ship

---

## Decision Needed

**Option A:** Ship v1.0 with current features, remove unimplemented items from paywall
**Option B:** Implement remaining features before shipping

Unimplemented Pro features: Custom drink types, Apple Watch
Unimplemented Insights features: Tags UI, CSV export, HealthKit, custom color themes
