import SwiftUI

struct HybridDashboardView: View {
    @State private var selectedTabIndex = 0
    @State private var currentDomains: [HybridDomain] = []
    @State private var totalScore: Double = 0
    @State private var interpretation: String = ""
    @State private var selectedDomain: HybridDomain?
    
    private let tabOptions = ["Overview", "Domains", "Ranking", "History"]
    
    var body: some View {
        NavigationView {
            ZStack {
                // Background
                Color.black.ignoresSafeArea()
                
                VStack(spacing: 0) {
                    // Header
                    HybridScoreHeader()
                        .padding(.top, 8)
                    
                    // Segmented Control
                    PremiumSegmentedControl(options: tabOptions, selectedIndex: $selectedTabIndex)
                        .padding(.horizontal, 20)
                        .padding(.top, 16)
                        .padding(.bottom, 8)
                    
                    // Content
                    TabView(selection: $selectedTabIndex) {
                        OverviewTab(
                            totalScore: totalScore,
                            interpretation: interpretation,
                            domains: currentDomains
                        )
                        .tag(0)
                        
                        DomainsTab(
                            domains: currentDomains,
                            onDomainTap: { domain in
                                selectedDomain = domain
                            }
                        )
                        .tag(1)
                        
                        RankingTab()
                        .tag(2)
                        
                        HistoryTab()
                        .tag(3)
                    }
                    .tabViewStyle(.page(indexDisplayMode: .never))
                    .animation(.spring(response: 0.3, dampingFraction: 0.8), value: selectedTabIndex)
                }
            }
            .navigationBarHidden(true)
            .sheet(item: $selectedDomain) { domain in
                DomainDetailView(domain: domain)
            }
            .onAppear {
                loadData()
            }
        }
    }
    
    private func loadData() {
        currentDomains = MockDataService.shared.getCurrentDomains()
        totalScore = ScoringService.shared.calculateTotalScore(from: currentDomains)
        interpretation = ScoringService.shared.interpretScore(totalScore)
    }
}

// MARK: - Overview Tab

struct OverviewTab: View {
    let totalScore: Double
    let interpretation: String
    let domains: [HybridDomain]
    
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                // Score Card
                HybridScoreCard(score: totalScore, interpretation: interpretation)
                    .padding(.top, 8)
                
                // Radar Chart
                RadarChartView(domains: domains)
                    .padding(.vertical, 8)
                
                // Quick Stats
                QuickStatsView(domains: domains, totalScore: totalScore)
                    .padding(.horizontal, 20)
                
                Spacer(minLength: 40)
            }
        }
    }
}

struct QuickStatsView: View {
    let domains: [HybridDomain]
    let totalScore: Double
    
    var body: some View {
        VStack(spacing: 16) {
            QuickStatRow(
                label: "Strongest Domain",
                value: strongestDomain?.name ?? "—",
                valueColor: .green
            )
            
            QuickStatRow(
                label: "Weakest Domain",
                value: weakestDomain?.name ?? "—",
                valueColor: .red
            )
            
            QuickStatRow(
                label: "Rank Percentile",
                value: "Top \(estimatedPercentile)%",
                valueColor: Color(red: 0.4, green: 0.7, blue: 1.0)
            )
        }
        .padding(20)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color(white: 0.12))
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(Color.white.opacity(0.1), lineWidth: 1)
                )
        )
    }
    
    private var strongestDomain: HybridDomain? {
        domains.max(by: { $0.points < $1.points })
    }
    
    private var weakestDomain: HybridDomain? {
        domains.min(by: { $0.points < $1.points })
    }
    
    private var estimatedPercentile: Int {
        // Simple estimation based on score
        let percentile = Int((totalScore / 100) * 100)
        return max(1, min(99, 100 - percentile))
    }
}

struct QuickStatRow: View {
    let label: String
    let value: String
    let valueColor: Color
    
    var body: some View {
        HStack {
            Text(label)
                .font(.system(size: 15, weight: .regular))
                .foregroundColor(.gray)
            
            Spacer()
            
            Text(value)
                .font(.system(size: 15, weight: .semibold))
                .foregroundColor(valueColor)
        }
    }
}

// MARK: - Domains Tab

struct DomainsTab: View {
    let domains: [HybridDomain]
    let onDomainTap: (HybridDomain) -> Void
    
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                ForEach(domains) { domain in
                    DomainCard(domain: domain)
                        .contentShape(Rectangle())
                        .onTapGesture {
                            onDomainTap(domain)
                        }
                }
                .padding(.horizontal, 20)
                .padding(.top, 8)
                
                Spacer(minLength: 40)
            }
        }
    }
}

// MARK: - Ranking Tab

struct RankingTab: View {
    @State private var entries: [LeaderboardEntry] = []
    @State private var userRank = 127
    
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                // Filters (placeholder)
                HStack(spacing: 16) {
                    FilterButton(title: "Age Group", icon: "person.2.fill")
                    FilterButton(title: "Weight Class", icon: "scalemass.fill")
                    FilterButton(title: "Location", icon: "mappin.circle.fill")
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 16)
                
                // Leaderboard
                VStack(spacing: 8) {
                    ForEach(entries) { entry in
                        LeaderboardRow(entry: entry, isUser: entry.name == "You")
                            .padding(.horizontal, 20)
                    }
                }
                .padding(.bottom, 40)
            }
        }
        .onAppear {
            entries = MockDataService.shared.getLeaderboardEntries(userRank: userRank)
        }
    }
}

struct FilterButton: View {
    let title: String
    let icon: String
    
    var body: some View {
        Button(action: {
            // Filter action
        }) {
            HStack(spacing: 6) {
                Image(systemName: icon)
                    .font(.system(size: 12))
                Text(title)
                    .font(.system(size: 13, weight: .medium))
            }
            .foregroundColor(.gray)
            .padding(.horizontal, 12)
            .padding(.vertical, 8)
            .background(
                Capsule()
                    .fill(Color(white: 0.15))
            )
        }
    }
}

// MARK: - History Tab

struct HistoryTab: View {
    @State private var snapshots: [HybridSnapshot] = []
    
    var body: some View {
        ScrollView {
            VStack(spacing: 12) {
                ForEach(Array(snapshots.enumerated()), id: \.element.id) { index, snapshot in
                    let previousScore = index < snapshots.count - 1 ? snapshots[index + 1].totalScore : nil
                    HistoryRow(snapshot: snapshot, previousScore: previousScore)
                        .padding(.horizontal, 20)
                }
                .padding(.top, 8)
                
                Spacer(minLength: 40)
            }
        }
        .onAppear {
            snapshots = MockDataService.shared.getHistorySnapshots()
        }
    }
}

#Preview {
    HybridDashboardView()
}

