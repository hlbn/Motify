//

import SwiftUI


public struct ExerciseTypeTile: View {
    
    // MARK: - Properties
    
    private let exercise: ExerciseVO.Exercise
    private let action: () -> Void
    
    
    // MARK: - Body
    
    public var body: some View {
        Button(action: action) {
            HStack(spacing: 16) {
                exercise.icon
                    .resizable()
                    .frame(width: 32, height: 32)
                    .foregroundColor(.white)
                    .bold()
                    .symbolEffect(.bounce, options: .nonRepeating, value: exercise.icon)
                
                Text(exercise.rawValue.localized.translation)
                    .font(.title3)
                    .bold()
                    .foregroundColor(.white)
                
                Spacer()
                
                Image(systemName: "chevron.down")
                    .foregroundColor(.white)
                    .bold()
            }
            .padding(16)
            .background(Color.content50)
            .cornerRadius(16)
        }
        .animation(.snappy, value: exercise.icon)
    }
    
    
    // MARK: - Init
    
    public init(exercise: ExerciseVO.Exercise, action: @escaping () -> Void = {}) {
        self.exercise = exercise
        self.action = action
    }
}


// MARK: - Preview

#Preview {
    ExerciseTypeTile(exercise: .none, action: { })
        .padding()
        .asComponentPreview()
}
