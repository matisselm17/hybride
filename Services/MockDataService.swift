import Foundation

class MockDataService {
    static let shared = MockDataService()
    
    private init() {}
    
    /// Generate current mock domains (8 domains)
    func getCurrentDomains() -> [HybridDomain] {
        [
            HybridDomain(id: "sbd", name: "Powerlifting SBD", unit: "xBW", rawValue: 3.2, points: 72.0, categoryType: .strength),
            HybridDomain(id: "10k", name: "10km Run", unit: "time", rawValue: 42.5, points: 65.0, categoryType: .endurance),
            HybridDomain(id: "5k", name: "5km Run", unit: "time", rawValue: 19.8, points: 68.0, categoryType: .endurance),
            HybridDomain(id: "100m", name: "100m Sprint", unit: "time", rawValue: 12.8, points: 58.0, categoryType: .speed),
            HybridDomain(id: "pullups", name: "Strict Pull-ups", unit: "reps", rawValue: 28.0, points: 75.0, categoryType: .strength),
            HybridDomain(id: "triathlon", name: "Triathlon M", unit: "time", rawValue: 145.0, points: 70.0, categoryType: .hybrid),
            HybridDomain(id: "400m_swim", name: "400m Freestyle", unit: "time", rawValue: 6.5, points: 62.0, categoryType: .endurance),
            HybridDomain(id: "hyrox", name: "HYROX Full", unit: "time", rawValue: 68.0, points: 66.0, categoryType: .hybrid)
        ]
    }
    
    /// Generate mock history snapshots
    func getHistorySnapshots() -> [HybridSnapshot] {
        let calendar = Calendar.current
        var snapshots: [HybridSnapshot] = []
        
        for i in 0..<12 {
            guard let date = calendar.date(byAdding: .month, value: -i, to: Date()) else { continue }
            let domains = getCurrentDomains().map { domain in
                // Vary points slightly for historical data
                let variation = Double.random(in: -10...10)
                let newPoints = max(0, min(100, domain.points + variation))
                return HybridDomain(
                    id: domain.id,
                    name: domain.name,
                    unit: domain.unit,
                    rawValue: domain.rawValue,
                    points: newPoints,
                    categoryType: domain.categoryType
                )
            }
            let totalScore = ScoringService.shared.calculateTotalScore(from: domains)
            let badge = ScoringService.shared.badgeForScore(totalScore)
            snapshots.append(HybridSnapshot(date: date, totalScore: totalScore, badge: badge, domains: domains))
        }
        
        return snapshots.sorted { $0.date > $1.date }
    }
    
    /// Generate mock leaderboard entries
    func getLeaderboardEntries(userRank: Int = 127) -> [LeaderboardEntry] {
        var entries: [LeaderboardEntry] = []
        
        // Generate entries around user rank (±5)
        let startRank = max(1, userRank - 5)
        let endRank = userRank + 5
        
        for rank in startRank...endRank {
            let isUser = rank == userRank
            let baseScore = 67.0
            let score = baseScore - Double(abs(rank - userRank)) * 0.8 + Double.random(in: -2...2)
            
            entries.append(LeaderboardEntry(
                rank: rank,
                name: isUser ? "You" : "Athlete \(rank)",
                score: max(0, min(100, score)),
                delta: isUser ? nil : (Bool.random() ? Int.random(in: -3...3) : nil),
                avatar: isUser ? "👤" : ["🏃", "💪", "🏊", "🚴", "⚡"].randomElement()
            ))
        }
        
        return entries.sorted { $0.rank < $1.rank }
    }
}

