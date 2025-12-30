import Foundation

struct LeaderboardEntry: Identifiable {
    let id = UUID()
    let rank: Int
    let name: String
    let score: Double
    let delta: Int? // Position change (optional)
    let avatar: String? // Optional avatar emoji or initial
}

