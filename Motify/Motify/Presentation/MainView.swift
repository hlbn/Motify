//

import SwiftUI
import NavigationKit


struct MainView: View {
    
    // MARK: - Properties
    
    @StateObject private var exerciseRouter = ExerciseRouter()
    
    
    // MARK: - Body
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
        .environmentObject(exerciseRouter)
    }
}


// MARK: - Preview

#Preview {
    MainView()
}
