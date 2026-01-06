import SwiftUI

struct RadarChartView: View {
    let domains: [HybridDomain]
    let size: CGFloat = 200
    
    var body: some View {
        ZStack {
            // Background grid circles
            ForEach(1...5, id: \.self) { level in
                let radius = (size / 2) * CGFloat(level) / 5
                Circle()
                    .stroke(Color.white.opacity(0.1), lineWidth: 1)
                    .frame(width: radius * 2, height: radius * 2)
            }
            
            // Grid lines (spokes)
            ForEach(0..<domains.count, id: \.self) { index in
                let angle = Double(index) * 2 * .pi / Double(domains.count) - .pi / 2
                Path { path in
                    path.move(to: CGPoint(x: size / 2, y: size / 2))
                    path.addLine(to: CGPoint(
                        x: size / 2 + cos(angle) * size / 2,
                        y: size / 2 + sin(angle) * size / 2
                    ))
                }
                .stroke(Color.white.opacity(0.1), lineWidth: 1)
            }
            
            // Data polygon
            if !domains.isEmpty {
                Path { path in
                    for (index, domain) in domains.enumerated() {
                        let angle = Double(index) * 2 * .pi / Double(domains.count) - .pi / 2
                        let radius = (size / 2) * CGFloat(domain.points / 100)
                        let x = size / 2 + cos(angle) * radius
                        let y = size / 2 + sin(angle) * radius
                        
                        if index == 0 {
                            path.move(to: CGPoint(x: x, y: y))
                        } else {
                            path.addLine(to: CGPoint(x: x, y: y))
                        }
                    }
                    path.closeSubpath()
                }
                .fill(
                    LinearGradient(
                        colors: [
                            Color(red: 0.4, green: 0.7, blue: 1.0).opacity(0.3),
                            Color(red: 0.6, green: 0.5, blue: 1.0).opacity(0.3)
                        ],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .stroke(
                    LinearGradient(
                        colors: [
                            Color(red: 0.4, green: 0.7, blue: 1.0),
                            Color(red: 0.6, green: 0.5, blue: 1.0)
                        ],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    ),
                    lineWidth: 2
                )
                
                // Domain labels
                ForEach(Array(domains.enumerated()), id: \.element.id) { index, domain in
                    let angle = Double(index) * 2 * .pi / Double(domains.count) - .pi / 2
                    let labelRadius = size / 2 + 20
                    let x = size / 2 + cos(angle) * labelRadius
                    let y = size / 2 + sin(angle) * labelRadius
                    
                    Text(shortName(for: domain.name))
                        .font(.system(size: 10, weight: .medium))
                        .foregroundColor(.gray)
                        .position(x: x, y: y)
                }
            }
        }
        .frame(width: size + 80, height: size + 80)
    }
    
    private func shortName(for name: String) -> String {
        let components = name.components(separatedBy: " ")
        if components.count > 1 {
            return components.prefix(2).joined(separator: " ")
        }
        return String(name.prefix(8))
    }
}

#Preview {
    let domains = MockDataService.shared.getCurrentDomains()
    return RadarChartView(domains: domains)
        .background(Color.black)
        .padding()
}


