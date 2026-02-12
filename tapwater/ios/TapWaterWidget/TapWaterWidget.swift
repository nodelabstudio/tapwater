import WidgetKit
import SwiftUI

struct WaterData {
    let totalMl: Int
    let goalMl: Int
    let progressPercent: Double
    let displayTotal: String
    let displayGoal: String
    let recentEntries: [[String: String]]

    static let placeholder = WaterData(
        totalMl: 1200,
        goalMl: 2000,
        progressPercent: 0.6,
        displayTotal: "41 oz",
        displayGoal: "68 oz",
        recentEntries: [
            ["icon": "💧", "name": "Water", "amount": "12 oz", "time": "9:30 AM"],
            ["icon": "☕", "name": "Coffee", "amount": "8 oz", "time": "8:00 AM"],
        ]
    )

    static let empty = WaterData(
        totalMl: 0,
        goalMl: 2000,
        progressPercent: 0.0,
        displayTotal: "0 ml",
        displayGoal: "2000 ml",
        recentEntries: []
    )
}

struct WaterEntry: TimelineEntry {
    let date: Date
    let data: WaterData
}

struct WaterTimelineProvider: TimelineProvider {
    private let appGroupId = "group.com.tapwater.app"

    func placeholder(in context: Context) -> WaterEntry {
        WaterEntry(date: .now, data: .placeholder)
    }

    func getSnapshot(in context: Context, completion: @escaping (WaterEntry) -> Void) {
        completion(WaterEntry(date: .now, data: context.isPreview ? .placeholder : loadData()))
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<WaterEntry>) -> Void) {
        let entry = WaterEntry(date: .now, data: loadData())
        let nextUpdate = Calendar.current.date(byAdding: .minute, value: 30, to: .now)!
        completion(Timeline(entries: [entry], policy: .after(nextUpdate)))
    }

    private func loadData() -> WaterData {
        guard let defaults = UserDefaults(suiteName: appGroupId) else {
            return .empty
        }

        let totalMl = defaults.integer(forKey: "totalMl")
        let goalMl = defaults.integer(forKey: "goalMl")
        let progressPercent = defaults.double(forKey: "progressPercent")
        let displayTotal = defaults.string(forKey: "displayTotal") ?? "0 ml"
        let displayGoal = defaults.string(forKey: "displayGoal") ?? "2000 ml"

        var recentEntries: [[String: String]] = []
        if let jsonString = defaults.string(forKey: "recentEntries"),
           let jsonData = jsonString.data(using: .utf8),
           let parsed = try? JSONSerialization.jsonObject(with: jsonData) as? [[String: String]] {
            recentEntries = parsed
        }

        return WaterData(
            totalMl: totalMl,
            goalMl: goalMl > 0 ? goalMl : 2000,
            progressPercent: progressPercent,
            displayTotal: displayTotal,
            displayGoal: displayGoal,
            recentEntries: recentEntries
        )
    }
}

struct TapWaterWidget: Widget {
    let kind = "TapWaterWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: WaterTimelineProvider()) { entry in
            TapWaterWidgetEntryView(entry: entry)
                .containerBackground(.fill.tertiary, for: .widget)
        }
        .configurationDisplayName("Hydration")
        .description("Track your daily water intake.")
        .supportedFamilies([.systemSmall, .systemMedium])
    }
}

struct TapWaterWidgetEntryView: View {
    let entry: WaterEntry

    @Environment(\.widgetFamily) var family

    var body: some View {
        switch family {
        case .systemSmall:
            SmallWidgetView(data: entry.data)
        case .systemMedium:
            MediumWidgetView(data: entry.data)
        default:
            SmallWidgetView(data: entry.data)
        }
    }
}
