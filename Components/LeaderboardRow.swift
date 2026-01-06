import SwiftUI

struct LeaderboardRow: View {
    let entry: LeaderboardEntry
    let isUser: Bool
    
    var body: some View {
        HStack(spacing: 16) {
            // Rank
            Text("#\(entry.rank)")
                .font(.system(size: 16, weight: .bold, design: .rounded))
                .foregroundColor(isUser ? Color(red: 0.4, green: 0.7, blue: 1.0) : .gray)
                .frame(width: 50, alignment: .leading)
            
            // Avatar/Initial
            ZStack {
                Circle()
                    .fill(
                        LinearGradient(
                            colors: isUser ? [
                                Color(red: 0.4, green: 0.7, blue: 1.0),
                                Color(red: 0.6, green: 0.5, blue: 1.0)
                            ] : [
                                Color(white: 0.2),
                                Color(white: 0.15)
                            ],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .frame(width: 44, height: 44)
                
                if let avatar = entry.avatar {
                    Text(avatar)
                        .font(.system(size: 20))
                } else {
                    Text(String(entry.name.prefix(1)))
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(.white)
                }
            }
            
            // Name
            Text(entry.name)
                .font(.system(size: 16, weight: isUser ? .semibold : .regular))
                .foregroundColor(isUser ? .white : .gray)
            
            Spacer()
            
            // Delta indicator
            if let delta = entry.delta, delta != 0 {
                HStack(spacing: 4) {
                    Image(systemName: delta > 0 ? "arrow.up" : "arrow.down")
                        .font(.system(size: 12, weight: .semibold))
                    Text("\(abs(delta))")
                        .font(.system(size: 12, weight: .semibold))
                }
                .foregroundColor(delta > 0 ? .red : .green)
                .padding(.horizontal, 8)
                .padding(.vertical, 4)
                .background(
                    Capsule()
                        .fill(Color(white: 0.15))
                )
            }
            
            // Score
            Text("\(Int(entry.score))")
                .font(.system(size: 18, weight: .bold, design: .rounded))
                .foregroundColor(.white)
                .frame(width: 50, alignment: .trailing)
        }
        .padding(.vertical, 12)
        .padding(.horizontal, 16)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(isUser ? Color(white: 0.15) : Color.clear)
        )
    }
}

#Preview {
    VStack(spacing: 8) {
        LeaderboardRow(entry: LeaderboardEntry(rank: 125, name: "Athlete 125", score: 66.5, delta: 2, avatar: "🏃"), isUser: false)
        LeaderboardRow(entry: LeaderboardEntry(rank: 127, name: "You", score: 67.5, delta: nil, avatar: "👤"), isUser: true)
        LeaderboardRow(entry: LeaderboardEntry(rank: 129, name: "Athlete 129", score: 65.2, delta: -1, avatar: "💪"), isUser: false)
    }
    .padding()
    .background(Color.black)
}


