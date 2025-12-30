import SwiftUI

struct DomainCard: View {
    let domain: HybridDomain
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
                // Header row
                HStack {
                    VStack(alignment: .leading, spacing: 4) {
                        Text(domain.name)
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(.white)
                        
                        Text("\(formatValue(domain.rawValue)) \(domain.unit)")
                            .font(.system(size: 13, weight: .regular))
                            .foregroundColor(.gray)
                    }
                    
                    Spacer()
                    
                    // Points
                    VStack(alignment: .trailing, spacing: 4) {
                        Text("\(Int(domain.points))")
                            .font(.system(size: 24, weight: .bold, design: .rounded))
                            .foregroundColor(colorForScore(domain.points))
                        
                        Text("pts")
                            .font(.system(size: 10, weight: .medium))
                            .foregroundColor(.gray)
                    }
                }
                
                // Progress bar
                GeometryReader { geometry in
                    ZStack(alignment: .leading) {
                        RoundedRectangle(cornerRadius: 4)
                            .fill(Color(white: 0.2))
                            .frame(height: 6)
                        
                        RoundedRectangle(cornerRadius: 4)
                            .fill(
                                LinearGradient(
                                    colors: [
                                        colorForScore(domain.points),
                                        colorForScore(domain.points).opacity(0.7)
                                    ],
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )
                            .frame(width: geometry.size.width * CGFloat(domain.points / 100), height: 6)
                            .animation(.spring(response: 0.3), value: domain.points)
                    }
                }
                .frame(height: 6)
            }
            .padding(16)
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(Color(white: 0.12))
                    .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(Color.white.opacity(0.1), lineWidth: 1)
                    )
            )
    }
    
    private func formatValue(_ value: Double) -> String {
        if value >= 100 {
            return String(format: "%.0f", value)
        } else if value >= 10 {
            return String(format: "%.1f", value)
        } else {
            return String(format: "%.2f", value)
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
    VStack {
        DomainCard(domain: HybridDomain(
            id: "test",
            name: "Powerlifting SBD",
            unit: "xBW",
            rawValue: 3.2,
            points: 72.0,
            categoryType: .strength
        ))
        .padding()
    }
    .background(Color.black)
}

