import SwiftUI

struct PremiumSegmentedControl: View {
    let options: [String]
    @Binding var selectedIndex: Int
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                // Background
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color(white: 0.15))
                    .frame(height: 44)
                
                // Selected indicator
                RoundedRectangle(cornerRadius: 12)
                    .fill(
                        LinearGradient(
                            colors: [
                                Color(red: 0.2, green: 0.5, blue: 0.9),
                                Color(red: 0.3, green: 0.4, blue: 0.95)
                            ],
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                    .frame(width: geometry.size.width / CGFloat(options.count), height: 44)
                    .offset(x: CGFloat(selectedIndex) * (geometry.size.width / CGFloat(options.count)))
                    .animation(.spring(response: 0.3, dampingFraction: 0.8), value: selectedIndex)
                
                // Labels
                HStack(spacing: 0) {
                    ForEach(Array(options.enumerated()), id: \.offset) { index, option in
                        Button(action: {
                            withAnimation(.spring(response: 0.3, dampingFraction: 0.8)) {
                                selectedIndex = index
                            }
                        }) {
                            Text(option)
                                .font(.system(size: 14, weight: .semibold))
                                .foregroundColor(selectedIndex == index ? .white : .gray)
                                .frame(maxWidth: .infinity)
                        }
                    }
                }
            }
        }
        .frame(height: 44)
    }
}

#Preview {
    struct PreviewWrapper: View {
        @State private var selected = 0
        var body: some View {
            VStack {
                PremiumSegmentedControl(options: ["Overview", "Domains", "Ranking", "History"], selectedIndex: $selected)
                    .padding()
            }
            .background(Color.black)
        }
    }
    return PreviewWrapper()
}

