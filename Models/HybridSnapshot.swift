import Foundation

struct HybridSnapshot: Identifiable {
    let id = UUID()
    let date: Date
    let totalScore: Double // 0-100
    let badge: BadgeLevel
    let domains: [HybridDomain]
    
    enum BadgeLevel: String {
        case beginner = "Beginner"
        case bronze = "Bronze"
        case silver = "Silver"
        case gold = "Gold"
        case elite = "Elite"
        
        var color: String {
            switch self {
            case .beginner: return "Gray"
            case .bronze: return "Orange"
            case .silver: return "Silver"
            case .gold: return "Yellow"
            case .elite: return "Purple"
            }
        }
    }
}


