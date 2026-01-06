import Foundation

class ScoringService {
    static let shared = ScoringService()
    
    private init() {}
    
    /// Calculate total hybrid score from domain points (average of all domain points)
    func calculateTotalScore(from domains: [HybridDomain]) -> Double {
        guard !domains.isEmpty else { return 0 }
        let sum = domains.reduce(0) { $0 + $1.points }
        return sum / Double(domains.count)
    }
    
    /// Get badge level based on total score
    func badgeForScore(_ score: Double) -> HybridSnapshot.BadgeLevel {
        switch score {
        case 0..<20: return .beginner
        case 20..<40: return .bronze
        case 40..<60: return .silver
        case 60..<80: return .gold
        case 80...100: return .elite
        default: return .beginner
        }
    }
    
    /// Interpret score level
    func interpretScore(_ score: Double) -> String {
        let badge = badgeForScore(score)
        switch badge {
        case .beginner: return "Getting Started"
        case .bronze: return "Hybrid Bronze"
        case .silver: return "Hybrid Silver"
        case .gold: return "Hybrid Gold"
        case .elite: return "Hybrid Elite"
        }
    }
}


