# Project Plan: TapWater (Working Name)

## Overview

TapWater is an iOS water and beverage tracking app built with Flutter (phone) and native Swift (Apple Watch) that addresses the pain points identified in competitive analysis of 3,310 App Store reviews across 519 negative reviews. The app prioritizes simplicity, honest pricing, shift worker support, and guilt-free tracking.

## Working Name Options

- TapWater -- tap to log + water (playful)
- ClearSip -- clean/transparent + sipping
- Drinkwell -- positive, health-forward
- HydroLog -- hydration + logging
- TapWater -- tap to log + water (playful)

Pick one or use "TapWater" as placeholder.

---

## Core Value Proposition

"Track your water without the guilt, the ads, or the $30/year subscription."

Every competitor either buries users in ads, forces subscriptions for basic editing, or bolts on crypto and AI. TapWater does one thing well: tracks what you drink with honest pricing and zero manipulation.

---

## Monetization Model

### Free Tier

- Basic water-only tracking (quick-add one default amount)
- Daily total view
- 3-day history
- Basic reminders (fixed intervals)
- App Store rating prompt after 2 weeks (non-aggressive, one-time)

### One-Time Purchase: $4.99 (TapWater Pro)

- Track any beverage (coffee, tea, juice, soda, etc.)
- Custom drink amounts and favorites
- Edit and delete any entry
- Backdate entries to previous days
- Adjustable day boundary (shift workers)
- Custom reminder schedule with bedtime hours
- Pin/favorite frequent drinks
- Full history (unlimited)
- Home screen widget
- Apple Watch basic logging
- No ads ever (free tier has no ads either -- this is a trust signal)

### Monthly Subscription: $1.99/mo or $14.99/yr (TapWater Insights)

- Everything in Pro, plus:
- 30/60/90-day trend charts
- Drink-type breakdown analytics (% water vs coffee vs other)
- Tag correlation insights ("you drink 30% less on weekends")
- Weekly summary notifications with trends
- CSV/PDF export
- HealthKit write-back (log to Apple Health)
- Custom themes and app icons
- Priority support

### Key Pricing Principles

- Free tier is genuinely usable, not crippled
- Pro is the main revenue driver (high volume, one-time)
- Insights is for power users who self-select (low volume, recurring)
- No ads anywhere in any tier
- No forced trials, no credit card required for free tier
- No bait-and-switch ever -- features in Pro stay in Pro

---

## Feature Breakdown

### Core Features (All Tiers)

Quick Add

- Single tap to log default amount (customizable: 8oz, 250ml, etc.)
- Large, thumb-friendly button centered on home screen
- Haptic feedback on log
- Undo button visible for 5 seconds after logging (prevents accidental entries)

Daily Progress

- Circular progress ring showing % of daily goal
- Current total vs goal displayed numerically
- Light positive messaging at milestones ("Halfway there", "Great day")
- No guilt messaging ever -- if user misses goal, no sad faces, no shame

Reminders

- Customizable interval reminders (every 30min, 1hr, 2hr, etc.)
- Respect bedtime hours (no notifications during sleep)
- Non-promotional -- reminders never include upsell messaging
- Silent notification option (badge only, no sound)

### Pro Features ($4.99 One-Time)

Multi-Beverage Tracking

- Pre-built list: water, coffee, tea, juice, soda, milk, smoothie, sports drink
- Custom beverages (user-defined name + icon + default amount)
- Hydration multiplier per drink type (coffee counts as 0.8x, etc.)
- Quick-add buttons for top 4 favorites on home screen

Data Management

- Edit any entry (amount, time, drink type)
- Delete any entry with confirmation
- Backdate entries to any previous day
- Manual time entry for drinks logged late

Adjustable Day Boundary

- Default: midnight rollover
- Custom: set day end time (e.g., 3am for night shift workers)
- Affects when daily progress resets
- No data loss on timezone changes

Apple Watch App

- Complication showing daily progress (ring + oz/ml count)
- Quick-add buttons for water + top 2 favorites
- Syncs to phone automatically
- Works offline (queues entries, syncs when connected)

Home Screen Widget

- Small: circular progress ring with percentage
- Medium: progress ring + last 3 entries + quick-add button
- No guilt messaging on widgets (neutral or positive only)

Favorites and Presets

- Pin up to 6 favorite drinks to home screen
- Custom amounts per favorite (e.g., "My water bottle" = 24oz)
- One-tap logging from favorites bar

### Insights Features ($1.99/mo)

Analytics Dashboard

- 7/30/60/90-day trend line charts
- Average daily intake over time
- Best/worst days with context
- Drink type breakdown (pie chart)
- Weekday vs weekend comparison

Tag System

- Pre-sleep and daily tags: exercise, travel, sick, hot day, busy day
- Tag correlation engine ("on exercise days you drink 25% more")
- Custom tags (unlimited)

Export and Integration

- CSV export of all data
- PDF weekly/monthly reports
- HealthKit write (sync intake to Apple Health)

Personalization

- Custom app icons (8+ options)
- Theme colors (light, dark, custom accent)
- Custom daily goal scheduling (different goals for different days)

---

## Technical Architecture

### Phone App: Flutter (iOS only)

State Management: Riverpod

- Clean separation of UI and business logic
- Easy to test
- Handles async data well

Local Database: Isar or Drift (SQLite)

- All data stored locally on device
- No backend server needed for v1
- Fast queries for analytics

Subscriptions: RevenueCat

- Handles both one-time IAP (Pro) and subscription (Insights)
- Receipt validation
- Restore purchases across devices
- Paywall UI components

Notifications: flutter_local_notifications

- Scheduled interval reminders
- Bedtime hour respect
- No server needed

Widgets: home_widget package

- iOS WidgetKit via Flutter bridge
- Small and medium widget sizes

HealthKit: health package

- Read daily water goal (if set in Health app)
- Write intake entries (Insights tier only)

### Watch App: Native Swift

Scope (minimal for v1):

- WatchKit app with 3-4 quick-add buttons
- Complication showing daily progress ring
- WatchConnectivity to sync entries to phone
- Offline queue for entries made without phone nearby

Communication:

- Watch -> Phone: drink entries (type, amount, timestamp)
- Phone -> Watch: daily goal, current progress, favorite drinks list, Pro status
- Uses transferUserInfo for background reliability

### Data Model

```
DrinkEntry
  id: UUID
  drinkType: String (water, coffee, tea, custom_xxx)
  amountMl: int (stored in ml, displayed in user's unit)
  timestamp: DateTime (UTC)
  isManual: bool (manual entry vs quick-add)
  source: enum (phone, watch, manual_backdate)
  createdAt: DateTime
  updatedAt: DateTime

DrinkType
  id: String (water, coffee, tea, or custom_UUID)
  name: String
  icon: String (emoji or asset name)
  hydrationMultiplier: double (1.0 for water, 0.8 for coffee, etc.)
  defaultAmountMl: int
  isFavorite: bool
  sortOrder: int
  isCustom: bool

DailyGoal
  id: UUID
  targetMl: int
  dayOfWeek: int (nullable -- null means every day)
  effectiveDate: Date

UserSettings
  unitSystem: enum (imperial, metric)
  dayBoundaryHour: int (0-23, default 0 for midnight)
  reminderIntervalMinutes: int (nullable -- null means off)
  bedtimeStart: TimeOfDay (nullable)
  bedtimeEnd: TimeOfDay (nullable)
  silentNotifications: bool

DailyTag
  id: UUID
  date: Date
  tag: String (exercise, travel, sick, hot_day, custom)
  isCustom: bool

UserPurchase
  proUnlocked: bool
  insightsActive: bool
  insightsExpiry: DateTime (nullable)
```

Key design decisions:

- All amounts stored in milliliters internally, converted for display
- Day boundary is a setting, not hardcoded to midnight
- No user accounts -- everything is local
- DrinkType is extensible (users create custom types in Pro)
- DailyGoal supports per-day-of-week goals (Insights tier)

---

## App Structure (Screens)

### Tab Bar (3 tabs)

1. Today (home screen)
2. History
3. Settings

### Today Tab

- Circular progress ring (large, centered)
- Daily total / goal text
- Positive message at milestones
- Quick-add button (water, large and centered)
- Favorites bar (Pro: up to 6 drinks)
- Recent entries list (last 5, swipe to delete with Pro)
- "Log a drink" button (opens drink picker)

### History Tab

- Calendar strip (horizontal scrollable week view)
- Tap any day to see that day's entries
- Daily totals bar chart (last 7 days visible)
- Pro: edit/delete any entry, backdate
- Insights: full analytics dashboard (trends, breakdowns, tags)

### Settings Tab

- Daily goal adjustment (slider or manual input)
- Unit system (oz / ml)
- Day boundary time (Pro)
- Reminder settings (interval, bedtime hours, sound)
- Drink types management (Pro: add/edit/delete custom drinks)
- Manage subscription (Pro / Insights status)
- Restore purchases
- Privacy policy
- About / version
- Contact support (email link)

### Paywall Screen

- Shows when user taps a Pro or Insights feature
- Clean, honest layout -- no dark patterns
- Clearly shows what each tier includes
- "No thanks" button is obvious and easy to tap
- No countdown timers, no "limited time" pressure
- One-time purchase prominent, subscription secondary

### Onboarding (First Launch)

- Screen 1: "What's your daily water goal?" (slider with common presets)
- Screen 2: "How do you measure?" (oz / ml toggle)
- Screen 3: "Want reminders?" (interval picker + bedtime hours)
- Screen 4: "You're all set" (shows home screen)
- No account creation, no email, no credit card
- 4 screens max, skippable

---

## Phased Roadmap (3 Weeks)

### Week 1: Core App (Days 1-7)

Days 1-2: Project Setup

- Initialize Flutter project from scaffold
- Set up Xcode workspace with iOS + watchOS targets
- Configure Isar/Drift database with data models
- Set up Riverpod providers
- Implement DrinkEntry, DrinkType, UserSettings models
- Create repository layer (CRUD for all models)

Days 3-4: Home Screen + Logging

- Build Today tab UI (progress ring, quick-add, favorites bar)
- Implement drink logging flow (quick-add + drink picker)
- Build circular progress ring widget (animated)
- Undo functionality (5-second window after log)
- Positive milestone messages
- Recent entries list

Days 5-6: History + Editing

- Build History tab with calendar strip
- Daily entries list view
- Edit entry flow (amount, time, type)
- Delete entry with confirmation
- Backdate entry to previous day
- 7-day bar chart

Day 7: Settings + Onboarding

- Settings screen (goal, units, day boundary)
- Onboarding flow (4 screens)
- Reminder configuration UI
- Notification scheduling (flutter_local_notifications)
- Bedtime hours respect

### Week 2: Pro Features + Watch (Days 8-14)

Days 8-9: Multi-Beverage + Customization

- Drink type management (add/edit/delete custom drinks)
- Favorites system (pin/unpin, reorder)
- Favorites bar on home screen (up to 6)
- Hydration multiplier per drink type
- Custom amounts per drink type
- Day boundary setting (shift workers)

Days 10-11: RevenueCat + Paywall

- RevenueCat SDK integration
- Configure products in App Store Connect (Pro IAP + Insights subscription)
- Build paywall screen (honest, clean, no dark patterns)
- Feature gating logic (free vs Pro vs Insights)
- Restore purchases flow
- Receipt validation

Days 12-13: Apple Watch App

- Create watchOS target in Xcode (Swift)
- Build Watch UI (progress ring + 3 quick-add buttons)
- Implement WatchConnectivity (send entries to phone)
- Build platform channel in Flutter to receive Watch data
- Complication (circular progress ring)
- Offline entry queue on Watch

Day 14: Widgets

- iOS WidgetKit integration via home_widget
- Small widget (progress ring + percentage)
- Medium widget (progress ring + recent entries)
- Widget updates on each drink log

### Week 3: Polish + Submission (Days 15-21)

Days 15-16: Insights Features

- 30/60/90-day trend charts (fl_chart or syncfusion)
- Drink type breakdown (pie chart)
- Weekday vs weekend comparison
- Tag system (log daily tags, basic correlation)
- CSV export
- HealthKit write-back

Days 17-18: Polish

- Animations (progress ring fill, entry add/remove)
- Dark mode (primary theme for a hydration app)
- Accessibility pass (VoiceOver labels, Dynamic Type)
- Haptic feedback throughout
- Error handling and edge cases
- App icon design
- Splash screen

Days 19-20: Testing + App Store Prep

- Manual testing (full user flows)
- Edge cases: timezone change, day boundary rollover, Watch disconnect
- Battery testing (reminders + widget updates)
- App Store Connect setup
- Screenshots (6.7" and 6.1" iPhone + Apple Watch)
- App Store description and keywords
- Privacy nutrition labels
- Privacy policy page
- Review notes for Apple (HealthKit justification)

Day 21: Submit

- TestFlight build (internal testing)
- Fix any critical issues
- Submit to App Store review
- Prepare for potential rejection notes

---

## App Store Submission Checklist

### Required Before Submission

App Store Connect:

- App record created with bundle ID
- App name reserved (check availability early)
- Primary category: Health & Fitness
- Age rating: 4+ (no objectionable content)
- Pricing: Free (IAP and subscription configured separately)

In-App Purchases (configured in App Store Connect):

- "TapWater Pro" -- Non-consumable IAP, $4.99
- "TapWater Insights Monthly" -- Auto-renewable subscription, $1.99/mo
- "TapWater Insights Annual" -- Auto-renewable subscription, $14.99/yr
- Subscription group: "TapWater Insights"
- Free trial: 7 days on Insights (optional but recommended)

Screenshots:

- 6.7" iPhone (iPhone 15 Pro Max) -- 3-5 screenshots
- 6.1" iPhone (iPhone 15 Pro) -- 3-5 screenshots
- Apple Watch Series 9 -- 2-3 screenshots
- Focus on: home screen with progress, drink picker, history chart, Watch complication

Privacy:

- Privacy policy URL (host on simple landing page or GitHub Pages)
- Nutrition labels: Health & Fitness data collected, linked to user, on-device only
- No tracking declaration (if not using analytics, or declare PostHog if using)

HealthKit:

- Entitlement enabled in Xcode
- NSHealthShareUsageDescription in Info.plist
- NSHealthUpdateUsageDescription in Info.plist (for Insights write-back)
- Review notes: "TapWater reads the user's daily water goal from Apple Health to set a default target. With the Insights subscription, users can optionally write their drink intake back to Apple Health for centralized health tracking."

Notifications:

- Push notification entitlement (local only, no server)
- UNUserNotificationCenter authorization request
- Explain in review notes: "Notifications are local only, used for hydration reminders at user-configured intervals."

### ASO Keywords (from scraper data)

Primary keywords: water tracker, water reminder, hydration tracker, drink water
Secondary: water intake, daily water, hydration app, water log
Long-tail: shift worker hydration, custom drink tracker, water tracking simple
Differentiators: no ads water tracker, one time purchase water app, simple hydration

### App Description (Draft)

TapWater: Simple Water Tracker

Track your water and beverages without the guilt, the ads, or the $30/year subscription.

TapWater does one thing well: helps you stay hydrated. Log your drinks with a single tap, set smart reminders that respect your schedule, and see your progress at a glance.

Why TapWater?

- No ads. Not now, not ever.
- $4.99 once unlocks everything. No subscription required for core features.
- Edit and delete entries freely. Your data, your control.
- Works for shift workers. Set your own day boundary.
- Apple Watch app included. Log from your wrist.
- Track any beverage. Water, coffee, tea, and custom drinks.
- No guilt. No sad mascots. Just clean, positive tracking.

TapWater Pro ($4.99 one-time):
All beverages, custom drinks, favorites, editing, Apple Watch, widgets, custom reminders.

TapWater Insights ($1.99/mo):
Advanced analytics, trend charts, drink breakdowns, data export, HealthKit sync, custom themes.

---

## Dependencies (Flutter Packages)

| Package                        | Purpose                   |
| ------------------------------ | ------------------------- |
| flutter_riverpod               | State management          |
| isar / drift                   | Local database            |
| flutter_local_notifications    | Reminder notifications    |
| home_widget                    | iOS WidgetKit bridge      |
| health                         | HealthKit read/write      |
| purchases_flutter (RevenueCat) | IAP and subscriptions     |
| fl_chart                       | Charts and graphs         |
| shared_preferences             | Simple key-value settings |
| intl                           | Date/number formatting    |
| path_provider                  | File paths for export     |
| share_plus                     | Share/export CSV files    |
| flutter_animate                | Micro-animations          |

No backend server needed. No Firebase. No analytics SDK required for v1 (add later if wanted).

---

## Risk Register

| Risk                               | Severity | Likelihood | Mitigation                                                         |
| ---------------------------------- | -------- | ---------- | ------------------------------------------------------------------ |
| Watch app takes longer than 2 days | HIGH     | HIGH       | Keep Watch scope minimal (3 buttons + complication only)           |
| RevenueCat integration issues      | MEDIUM   | MEDIUM     | Follow their Flutter quickstart exactly, test in sandbox early     |
| App Store rejection for HealthKit  | MEDIUM   | LOW        | Only request specific entitlements needed, justify in review notes |
| Widget not updating reliably       | MEDIUM   | MEDIUM     | Use background fetch + UserDefaults shared container               |
| Day boundary logic edge cases      | LOW      | MEDIUM     | Extensive unit tests for timezone and rollover scenarios           |
| Isar/Drift migration issues        | LOW      | LOW        | Get schema right in week 1, avoid changes after                    |
| App Store name taken               | LOW      | MEDIUM     | Check availability day 1, have 3 backup names                      |

---

## What to Build in Claude Code

When you start the project in the terminal with Claude Code, use this plan as the reference document. The order of operations should be:

1. Scaffold from your existing Flutter template
2. Implement data models and database layer first (testable without UI)
3. Build the Today screen (this is the app's core loop)
4. Add history and editing
5. Integrate RevenueCat and feature gating
6. Build Watch app (native Swift)
7. Add widgets
8. Add Insights analytics
9. Polish and submit

Each step builds on the previous one and produces something testable. You can ship after step 5 if Watch and widgets take too long -- those can be a v1.1 update.

---

## Build-in-Public Content

- "I scraped 3,310 water app reviews. Here's why everyone hates their hydration tracker."
- "The $4.99 bet: why I'm not charging a subscription for a water tracker"
- "Building a water tracker in 3 weeks with Flutter (day 1)"
- "I analyzed every negative Waterllama review. They added crypto to a water app."
- "Shift workers deserve hydration apps too."
- Weekly build updates with screenshots
- Launch day thread with the full story (scraper -> analysis -> build -> ship)

---

## Pre-Build Notes

### Contact Email
- All references to `quest30@use.startmail.com` must be changed to `tapwater@use.startmail.com`
- Applies to: docs/privacy-policy.html, docs/terms.html, docs/support.html, docs/index.html, and any in-app contact/support links

### Docs Folder (docs/)
- All 4 HTML files (index.html, privacy-policy.html, terms.html, support.html) are currently branded for "Quest 30"
- These must be fully rebranded for TapWater before App Store submission:
  - Replace all "Quest 30" references with "TapWater"
  - Update email from quest30@use.startmail.com to tapwater@use.startmail.com
  - Update privacy policy content to reflect TapWater's data model (drink entries, beverage types, daily goals vs challenges/streaks)
  - Update terms of service to reflect TapWater's monetization (Pro one-time purchase + Insights subscription vs Quest 30's Pro subscription)
  - Update index.html landing page with TapWater features, tagline, and value proposition
  - Update support page with TapWater branding
  - Update gradient colors to match TapWater's brand palette

### Running on Simulator

```bash
# Navigate to the Flutter project
cd tapwater

# List available simulators
xcrun simctl list devices available

# Boot the iPhone 16 Pro simulator
xcrun simctl boot "iPhone 16 Pro"

# Run the app in debug mode on the simulator
flutter run -d "iPhone 16 Pro"

# Or use the specific device ID directly
flutter run -d 789D661C-FB36-435F-846E-149E2057AAF8
```

Other useful commands:

```bash
# Hot reload (while app is running): press 'r' in the terminal
# Hot restart (while app is running): press 'R' in the terminal
# Quit the running app: press 'q' in the terminal

# Run analysis
flutter analyze

# Build iOS (no codesign, for CI or checking compilation)
flutter build ios --no-codesign

# Regenerate Drift database files after schema changes
dart run build_runner build
```

### Onboarding Flow

Current order:
1. **Screen 1 (Units):** Pick ml or oz
2. **Screen 2 (Daily Goal):** Set daily goal
3. **Screen 3 (Reminders):** Enable/disable reminders
4. **Screen 4 (Welcome):** "You're all set!"

### Session Status (Feb 10, 2026)

**Completed:**
- Phase 1: Project scaffold & cleanup (template copied, dependencies set, iOS-only)
- Phase 2: Data models & Drift database (5 tables, 5 DAOs, seed data, providers)
- Phase 3: Today screen (progress ring, quick-add, favorites bar, recent entries, undo snackbar)
- Phase 4: History & editing (calendar strip, weekly bar chart, entry edit/delete sheet)
- Phase 5: Settings, onboarding & reminders (4-step onboarding, full settings, notifications)
- Phase 6: RevenueCat & feature gating (purchase service, paywall, Pro/Insights gates)
- Phase 7: Docs rebrand (all 4 HTML files updated from Quest 30 to TapWater)
- Bundle ID changed from `com.example.flutterTemplate` to `com.tapwater.app`
- App builds and runs on iPhone 16 Pro simulator with zero analysis errors
- Fixed snackbar not auto-dismissing (switched from root ScaffoldMessenger global key to context-based ScaffoldMessenger with floating behavior)
- Created root `.gitignore` covering `.claude/`, `build/`, `.dart_tool/`, iOS generated files, and macOS metadata

**Not yet built (future phases):**
- Home screen widgets (WidgetKit)
- Apple Watch app (native Swift)
- Insights analytics (trend charts, tags, CSV export, HealthKit)
- Custom drink type management screen
- Custom themes / app icons

**Ready to pick up:** Continue with polish and remaining features.

### UI Design Constraints
- **Buttons**: All buttons must have a slight border radius (not fully rounded). No pill-shaped or stadium-shaped buttons. Use a consistent, subtle border radius (e.g., 8px) across the entire app.
- **Button sizing**: All buttons should be uniform in size within their context (e.g., all action buttons same height/width, all quick-add buttons same dimensions).
- These constraints apply to: quick-add buttons, favorites bar buttons, paywall buttons, onboarding buttons, settings buttons, and any other interactive elements.
