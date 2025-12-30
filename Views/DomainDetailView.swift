import SwiftUI

struct DomainDetailView: View {
    let domain: HybridDomain
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    // Header card
                    VStack(alignment: .leading, spacing: 16) {
                        Text(domain.name)
                            .font(.system(size: 28, weight: .bold))
                            .foregroundColor(.white)
                        
                        HStack {
                            Text("\(formatValue(domain.rawValue)) \(domain.unit)")
                                .font(.system(size: 18, weight: .semibold))
                                .foregroundColor(.gray)
                            
                            Spacer()
                            
                            Text("\(Int(domain.points)) points")
                                .font(.system(size: 18, weight: .bold))
                                .foregroundColor(colorForScore(domain.points))
                        }
                        
                        // Progress bar
                        GeometryReader { geometry in
                            ZStack(alignment: .leading) {
                                RoundedRectangle(cornerRadius: 6)
                                    .fill(Color(white: 0.2))
                                    .frame(height: 10)
                                
                                RoundedRectangle(cornerRadius: 6)
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
                                    .frame(width: geometry.size.width * CGFloat(domain.points / 100), height: 10)
                            }
                        }
                        .frame(height: 10)
                    }
                    .padding(24)
                    .background(
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color(white: 0.12))
                            .overlay(
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(Color.white.opacity(0.1), lineWidth: 1)
                            )
                    )
                    
                    // Explanation section
                    VStack(alignment: .leading, spacing: 12) {
                        Text("About")
                            .font(.system(size: 20, weight: .semibold))
                            .foregroundColor(.white)
                        
                        Text(getExplanation(for: domain))
                            .font(.system(size: 15, weight: .regular))
                            .foregroundColor(.gray)
                            .lineSpacing(4)
                    }
                    
                    // How to improve section
                    VStack(alignment: .leading, spacing: 16) {
                        Text("How to Improve")
                            .font(.system(size: 20, weight: .semibold))
                            .foregroundColor(.white)
                        
                        VStack(alignment: .leading, spacing: 12) {
                            ForEach(getImprovementTips(for: domain), id: \.self) { tip in
                                HStack(alignment: .top, spacing: 12) {
                                    Circle()
                                        .fill(Color(red: 0.4, green: 0.7, blue: 1.0))
                                        .frame(width: 6, height: 6)
                                        .padding(.top, 6)
                                    
                                    Text(tip)
                                        .font(.system(size: 15, weight: .regular))
                                        .foregroundColor(.gray)
                                        .fixedSize(horizontal: false, vertical: true)
                                }
                            }
                        }
                    }
                    
                    Spacer(minLength: 40)
                }
                .padding(20)
            }
            .background(Color.black.ignoresSafeArea())
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        dismiss()
                    }
                    .foregroundColor(Color(red: 0.4, green: 0.7, blue: 1.0))
                }
            }
        }
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
    
    private func getExplanation(for domain: HybridDomain) -> String {
        switch domain.id {
        case "sbd": return "Powerlifting SBD (Squat, Bench, Deadlift) measures your total strength relative to bodyweight. This normalized score compares your combined one-rep max across all three lifts to your bodyweight."
        case "10k": return "The 10km run test measures your aerobic endurance and running efficiency. A strong score indicates excellent cardiovascular fitness and running economy."
        case "5k": return "The 5km run combines aerobic capacity with speed endurance. This distance requires both cardiovascular fitness and the ability to maintain pace."
        case "100m": return "The 100m sprint is the ultimate test of explosive power and speed. This measures your ability to generate maximum force and acceleration."
        case "pullups": return "Strict pull-ups measure upper body pulling strength and relative strength. This is a fundamental bodyweight exercise that demonstrates upper body power."
        case "triathlon": return "Middle-distance triathlon (1.5km swim, 40km bike, 10km run) tests multi-sport endurance and transitions. This requires balanced fitness across swimming, cycling, and running."
        case "400m_swim": return "The 400m freestyle swim tests both cardiovascular endurance and swimming technique. Efficient stroke mechanics are as important as fitness."
        case "hyrox": return "HYROX is a hybrid fitness race combining running with functional exercises. It tests endurance, strength, and mental toughness across multiple domains."
        default: return "This domain measures your performance in a specific athletic discipline."
        }
    }
    
    private func getImprovementTips(for domain: HybridDomain) -> [String] {
        switch domain.id {
        case "sbd": return [
            "Focus on progressive overload: increase weight by 2.5-5% weekly",
            "Include accessory work targeting weak points in each lift",
            "Prioritize proper form and technique over maximum weight",
            "Allow adequate recovery between heavy sessions (48-72 hours)",
            "Consider periodization: cycles of volume, intensity, and deload"
        ]
        case "10k": return [
            "Build aerobic base with long slow runs (70% of max heart rate)",
            "Include tempo runs at threshold pace (2-3x per week)",
            "Add interval training: 6-8x 800m at 5k pace with recovery",
            "Focus on running economy with drills and form work",
            "Gradually increase weekly mileage by 10% per week"
        ]
        case "5k": return [
            "Mix interval training (400m-1km repeats) with tempo runs",
            "Build speed with 200m-400m intervals at faster than 5k pace",
            "Include one long run per week (60-90 minutes)",
            "Practice race pace during tempo runs",
            "Focus on even pacing and negative splits in training"
        ]
        case "100m": return [
            "Develop explosive power with plyometric exercises",
            "Include sprint-specific drills: A-skips, B-skips, high knees",
            "Work on starting technique and acceleration mechanics",
            "Incorporate weight training: squats, deadlifts, Olympic lifts",
            "Ensure full recovery between sprint sessions (48+ hours)"
        ]
        case "pullups": return [
            "Practice pull-ups 3-4 times per week with varying grips",
            "Use negatives and assisted pull-ups if needed",
            "Add volume gradually: aim for 50-100 total reps per session",
            "Strengthen supporting muscles: biceps, rear delts, lats",
            "Try weighted pull-ups once you can do 15+ bodyweight reps"
        ]
        case "triathlon": return [
            "Balance training across all three disciplines weekly",
            "Include brick workouts (bike-to-run transitions)",
            "Practice open water swimming if racing outdoors",
            "Build aerobic base in each sport before adding intensity",
            "Focus on pacing: negative splits and even effort"
        ]
        case "400m_swim": return [
            "Improve technique with drills: catch-up, one-arm, sculling",
            "Build endurance with longer intervals (200m-400m repeats)",
            "Focus on efficient breathing pattern (every 2-3 strokes)",
            "Include speed work: 50m-100m intervals at race pace",
            "Work on flip turns and streamline off walls"
        ]
        case "hyrox": return [
            "Train running and functional movements together (brick workouts)",
            "Build strength endurance: high-rep compound movements",
            "Practice transitions between running and exercises",
            "Include circuit training mimicking HYROX format",
            "Focus on pacing: maintain consistent effort across all stations"
        ]
        default: return [
            "Consistent training is key to improvement",
            "Track your progress and adjust your program accordingly",
            "Ensure adequate recovery and nutrition"
        ]
        }
    }
}

#Preview {
    DomainDetailView(domain: HybridDomain(
        id: "sbd",
        name: "Powerlifting SBD",
        unit: "xBW",
        rawValue: 3.2,
        points: 72.0,
        categoryType: .strength
    ))
}

