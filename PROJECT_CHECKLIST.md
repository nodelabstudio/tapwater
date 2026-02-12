# TapWater - Hydration Tracker — Project Checklist

## App Store Submission Checklist

- [x] Host docs on GitHub Pages (privacy, terms, support)
      - Site: https://nodelabstudio.github.io/tapwater/
      - Privacy: https://nodelabstudio.github.io/tapwater/privacy-policy.html
      - Terms: https://nodelabstudio.github.io/tapwater/terms.html
      - Support: https://nodelabstudio.github.io/tapwater/support.html
- [x] Update app with real Privacy Policy / Terms URLs
- [ ] Create app in App Store Connect
- [ ] Set up RevenueCat account + products
- [ ] Paste RevenueCat API key into purchase_service.dart
- [ ] Set App Store ID in settings_screen.dart _rateApp() method
- [ ] Add HealthKit capability to Runner target in Xcode
- [ ] Prepare App Store screenshots (5.5" + 6.7")
- [ ] Write App Store description + keywords (draft in APP_STORE_NOTES.md)
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
| Privacy Policy link | DONE | https://nodelabstudio.github.io/tapwater/privacy-policy.html |
| Terms of Service link | DONE | https://nodelabstudio.github.io/tapwater/terms.html |
| Snackbar auto-dismiss | DONE | Manual Future.delayed fix |
| Delete All Data | DONE | Settings > Data |

## Feature Status: PRO Tier ($4.99 one-time)

| Feature | Status | Notes |
|---------|--------|-------|
| Multi-beverage tracking | DONE | 8 default types, gated in favorites + drink picker |
| Custom drink types | DONE | Create/edit/delete via custom_drink_sheet.dart, "+" in favorites bar |
| Edit & delete entries | DONE | entry_edit_sheet.dart with full editing |
| Backdate entries | DONE | Date picker in entry edit sheet |
| Full history access | DONE | Calendar + bubble view + daily entries |
| Shift worker day boundary | DONE | Settings > Day Boundary (0-6 hours) |
| Home screen widgets | DONE | Included in free (listed as Pro on paywall) |
| Apple Watch app | DEFERRED | Deferred to v1.1, removed from paywall |

## Feature Status: INSIGHTS Tier ($1.99/mo)

| Feature | Status | Notes |
|---------|--------|-------|
| Trend analytics & charts | DONE | Weekly bar chart + streaks + averages + pie chart breakdown |
| Daily tags & notes | DONE | Add/remove tags on Today screen, gated by canUseTags |
| CSV export | DONE | Date range picker, share via share_plus, Settings > Data |
| HealthKit sync | DONE | Write water intake to Apple Health, toggle in Settings |
| Custom themes | DONE | 10 preset accent colors, gated by Insights tier |

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
| HealthKit entitlement | DONE | Info.plist usage descriptions added |

---

## Known Issues

- Amount field in drink picker: FIXED (converts ml to display units for imperial)
- Apple Watch not implemented: DEFERRED to v1.1, removed from paywall

---

## Deferred to v1.1

- Apple Watch app
- Additional chart types (monthly trends, year-over-year)
- Social sharing / achievements
