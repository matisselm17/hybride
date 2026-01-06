import SwiftUI

struct HybridScoreHeader: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Hybrid Score")
                .font(.system(size: 34, weight: .bold))
                .foregroundColor(.white)
            
            Text("Your comprehensive athletic performance across 8 domains")
                .font(.system(size: 15, weight: .regular))
                .foregroundColor(.gray)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, 20)
        .padding(.top, 8)
    }
}

#Preview {
    HybridScoreHeader()
        .background(Color.black)
}


