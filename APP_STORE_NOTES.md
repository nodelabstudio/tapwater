# TapWater - App Store Summary & Release Notes

## App Description (Short)

Track your hydration effortlessly. No ads, no subscriptions for core features. Just tap and drink.

## App Description (Full)

TapWater is the simplest way to track your daily water and beverage intake. One tap to log a glass. A beautiful progress ring shows how close you are to your goal. No ads. No mandatory subscriptions. Just hydration tracking done right.

**Free features:**
- One-tap water logging
- Daily progress ring with goal tracking
- Customizable daily hydration goal
- Metric (ml) and Imperial (oz) units
- Smart reminder notifications
- Motivational milestone messages
- Home screen widgets (small + medium)
- Light, Dark, and System theme modes
- Rate & review, privacy policy, and support links

**Pro (one-time $4.99):**
- Track 8+ beverage types (coffee, tea, juice, milk, soda, smoothie, sports drink)
- Create your own custom drink types with custom icons, colors, and hydration factors
- Edit and delete past entries
- Backdate entries to any date
- Full history with calendar view and year-at-a-glance bubble chart
- Shift worker day boundary (set your day to start at 1-6am)

**Insights ($1.99/month, requires Pro):**
- Trend analytics: current streak, longest streak, daily average
- Beverage breakdown pie chart (90-day analysis)
- Daily notes and tags to track habits and context
- Export your data as CSV
- Apple Health sync (write water intake automatically)
- 10 custom accent color themes

## Keywords

water tracker, hydration, drink tracker, water intake, daily water, health, water reminder, beverage tracker, fluid intake, water log

## What's New in v1.0

Initial release! Track your water and beverage intake with:
- One-tap quick-add for water
- 8 built-in drink types + custom drink creation
- Beautiful progress ring and milestone messages
- Smart hydration reminders
- Home screen widgets
- Full history with calendar and year view
- Insights: streaks, averages, beverage breakdown
- Daily notes, CSV export, and Apple Health sync
- 10 accent color themes
- Light, Dark, and System appearance modes

## Links

- **Privacy Policy:** https://nodelabstudio.github.io/tapwater/privacy-policy.html
- **Terms of Service:** https://nodelabstudio.github.io/tapwater/terms.html
- **Support:** https://nodelabstudio.github.io/tapwater/support.html
- **Website:** https://nodelabstudio.github.io/tapwater/

## Technical Details

- **Platform:** iOS 17.0+
- **Framework:** Flutter 3.x with Riverpod state management
- **Database:** Drift (SQLite) - all data stored locally on device
- **Purchases:** RevenueCat (Pro = lifetime, Insights = monthly)
- **Privacy:** No analytics, no tracking, no data collection. All data stays on your device.
- **Widgets:** WidgetKit (SwiftUI) - Small and Medium sizes
- **HealthKit:** Writes dietary water only (with user permission)

## Pricing

| Tier | Price | Model |
|------|-------|-------|
| Free | $0 | Core hydration tracking |
| Pro | $4.99 | One-time (lifetime) |
| Insights | $1.99/mo | Monthly subscription (requires Pro) |

## Privacy Summary

- No data collected or transmitted
- All drink entries, settings, and goals stored locally in SQLite
- RevenueCat processes purchases (anonymous app user ID only)
- HealthKit access is optional and user-initiated
- No third-party analytics or advertising SDKs

---

## Changelog

### v1.0.0 — Initial Release

**Free Tier:**
- One-tap water logging (+8oz / +250ml quick add)
- Daily progress ring with percentage and total/goal display
- Configurable daily hydration goal (slider in Settings)
- Metric (ml) / Imperial (oz) unit toggle
- 4-step onboarding flow (units, goal, reminders setup)
- Smart reminder notifications (configurable interval and time window)
- Motivational milestone messages based on daily progress
- Favorites bar with all 8 drink types (Water free, others require Pro)
- Home screen widgets: small (progress ring) + medium (ring + recent entries)
- Light / Dark / System theme toggle
- Launch screen with app icon and name
- Privacy manifest (PrivacyInfo.xcprivacy)
- Rate app prompt (in_app_review)
- Dynamic version display (package_info_plus)
- Privacy Policy and Terms of Service links
- Delete All Data option

**Pro Tier ($4.99 one-time):**
- Multi-beverage tracking: Water, Coffee, Tea, Juice, Milk, Soda, Smoothie, Sports Drink
- Custom drink types: create with name, icon (20 options), color (12 presets), default amount, hydration factor (0-150%)
- Edit and delete drink entries
- Backdate entries to any date
- Full history: calendar strip, weekly bar chart, year-at-a-glance bubble calendar
- Shift worker day boundary (0-6 hour offset)

**Insights Tier ($1.99/month):**
- Trend analytics: current streak, longest streak, daily average (90-day lookback)
- Beverage breakdown: pie chart with legend showing consumption by drink type
- Daily tags & notes: add/remove short notes for each day
- CSV export: date range picker, generates CSV with date, time, type, amount, hydration factor
- Apple Health sync: writes water intake to HealthKit on each entry
- Custom accent color themes: 10 presets (Ocean Blue, Teal, Forest Green, Lavender, Berry, Coral, Sunset, Rose, Slate, Indigo)

**Infrastructure:**
- RevenueCat integration (API key placeholder - needs real key)
- Drift database with 5 tables, 5 DAOs, full migration strategy
- Riverpod state management throughout
- go_router navigation with shell routes (3 tabs + onboarding)
- App Groups shared container for widget data
- HealthKit entitlement with usage descriptions
