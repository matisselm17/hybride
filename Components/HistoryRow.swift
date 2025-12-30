import SwiftUI

struct HistoryRow: View {
    let snapshot: HybridSnapshot
    let previousScore: Double?
    
    var body: some View {
        HStack(spacing: 16) {
            // Date
            VStack(alignment: .leading, spacing: 4) {
                Text(dateFormatter.string(from: snapshot.date))
                    .font(.system(size: 15, weight: .semibold))
                    .foregroundColor(.white)
                
                Text(relativeDateFormatter.string(from: snapshot.date))
                    .font(.system(size: 12, weight: .regular))
                    .foregroundColor(.gray)
            }
            .frame(width: 100, alignment: .leading)
            
            Spacer()
            
            // Trend indicator
            if let previous = previousScore {
                let trend = snapshot.totalScore - previous
                if abs(trend) > 0.5 {
                    HStack(spacing: 4) {
                        Image(systemName: trend > 0 ? "arrow.up.right" : "arrow.down.right")
                            .font(.system(size: 14, weight: .semibold))
                        Text(String(format: "%.1f", abs(trend)))
                            .font(.system(size: 12, weight: .semibold))
                    }
                    .foregroundColor(trend > 0 ? .green : .red)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(
                        Capsule()
                            .fill(Color(white: 0.15))
                    )
                }
            }
            
            // Badge
            Text(badgeEmoji(for: snapshot.badge))
                .font(.system(size: 24))
            
            // Score
            Text("\(Int(snapshot.totalScore))")
                .font(.system(size: 24, weight: .bold, design: .rounded))
                .foregroundColor(colorForScore(snapshot.totalScore))
                .frame(width: 60, alignment: .trailing)
        }
        .padding(.vertical, 12)
        .padding(.horizontal, 16)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color(white: 0.12))
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color.white.opacity(0.1), lineWidth: 1)
                )
        )
    }
    
    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d, yyyy"
        return formatter
    }
    
    private var relativeDateFormatter: RelativeDateTimeFormatter {
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .abbreviated
        return formatter
    }
    
    private func badgeEmoji(for badge: HybridSnapshot.BadgeLevel) -> String {
        switch badge {
        case .beginner: return "⚪"
        case .bronze: return "🟠"
        case .silver: return "⚪"
        case .gold: return "🟡"
        case .elite: return "🟣"
        }
    }
    
    private func colorForScore(_ score: Double) -> Color {
        switch score {
        case 0..<40: return Color(red: 0.9, green: 0.3, blue: 0.3)
        case 40..<60: return Color(red: 0.9, green: 0.7, blue: 0.3)
        case 60..<80: return Color(red: 0.3, green: 0.7, blue: 0.9)
        case 80...100: return Color(red: 0.4, green: 0.9, blue: 0.5)
        default: return .gray
        }
    }
}

#Preview {
    let snapshot = HybridSnapshot(
        date: Date().addingTimeInterval(-86400 * 30),
        totalScore: 67.5,
        badge: .silver,
        domains: []
    )
    
    return VStack {
        HistoryRow(snapshot: snapshot, previousScore: 65.2)
            .padding()
    }
    .background(Color.black)
}

