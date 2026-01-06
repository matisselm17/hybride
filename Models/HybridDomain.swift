import Foundation

struct HybridDomain: Identifiable, Hashable {
    let id: String
    let name: String
    let unit: String
    let rawValue: Double
    let points: Double // 0-100
    let categoryType: DomainCategory
    
    enum DomainCategory: String, CaseIterable {
        case strength = "Strength"
        case endurance = "Endurance"
        case speed = "Speed"
        case hybrid = "Hybrid"
    }
}


