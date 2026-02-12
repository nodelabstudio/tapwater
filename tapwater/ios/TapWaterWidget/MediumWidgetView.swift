import SwiftUI

struct MediumWidgetView: View {
    let data: WaterData

    private var percentText: String {
        "\(Int(data.progressPercent * 100))%"
    }

    var body: some View {
        HStack(spacing: 16) {
            // Left: progress ring
            VStack(spacing: 6) {
                ZStack {
                    Circle()
                        .stroke(Color.gray.opacity(0.2), lineWidth: 8)

                    Circle()
                        .trim(from: 0, to: data.progressPercent)
                        .stroke(
                            Color.waterGradient,
                            style: StrokeStyle(lineWidth: 8, lineCap: .round)
                        )
                        .rotationEffect(.degrees(-90))

                    VStack(spacing: 2) {
                        Text(percentText)
                            .font(.title2)
                            .fontWeight(.bold)
                            .minimumScaleFactor(0.6)
                        Text("💧")
                            .font(.caption)
                    }
                }

                Text("\(data.displayTotal) / \(data.displayGoal)")
                    .font(.caption2)
                    .foregroundStyle(.secondary)
                    .lineLimit(1)
                    .minimumScaleFactor(0.8)
            }
            .frame(maxWidth: .infinity)

            // Right: recent entries
            VStack(alignment: .leading, spacing: 4) {
                Text("Recent")
                    .font(.caption)
                    .fontWeight(.semibold)
                    .foregroundStyle(.secondary)

                if data.recentEntries.isEmpty {
                    Spacer()
                    Text("No entries yet")
                        .font(.caption)
                        .foregroundStyle(.tertiary)
                    Spacer()
                } else {
                    ForEach(Array(data.recentEntries.prefix(3).enumerated()), id: \.offset) { _, entry in
                        HStack(spacing: 6) {
                            Text(entry["icon"] ?? "💧")
                                .font(.caption)
                            VStack(alignment: .leading, spacing: 0) {
                                Text(entry["name"] ?? "")
                                    .font(.caption2)
                                    .fontWeight(.medium)
                                    .lineLimit(1)
                                Text("\(entry["amount"] ?? "") · \(entry["time"] ?? "")")
                                    .font(.caption2)
                                    .foregroundStyle(.secondary)
                                    .lineLimit(1)
                            }
                        }
                    }
                }

                Spacer(minLength: 0)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(.vertical, 4)
    }
}
