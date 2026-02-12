import SwiftUI

struct SmallWidgetView: View {
    let data: WaterData

    private var percentText: String {
        "\(Int(data.progressPercent * 100))%"
    }

    var body: some View {
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
            .padding(.horizontal, 8)

            Text(data.displayTotal)
                .font(.caption)
                .fontWeight(.medium)
                .foregroundStyle(.secondary)

            Text("of \(data.displayGoal)")
                .font(.caption2)
                .foregroundStyle(.tertiary)
        }
        .padding(.vertical, 4)
    }
}
