//

import SwiftUI
import DesignKit


struct ExerciseTypePickerView: View {
    
    // MARK: - Properties
    
    let onTypePicked: (ExerciseVO.Exercise) -> Void
    
    
    // MARK: - Body
    
    var body: some View {
        VStack(spacing: 16) {
            ForEach(ExerciseVO.Exercise.allCases, id: \.self) { type in
                Button {
                    onTypePicked(type)
                } label: {
                    HStack {
                        type.icon
                            .resizable()
                            .frame(width: 32, height: 32)
                            .foregroundColor(Color.content50)
                            .bold()
                        
                        Text(type.rawValue.localized.translation)
                            .font(.caption, color: .contentMain)
                        
                        Spacer()
                    }
                }
                
                ThemedDivider()
            }
        }
        .padding(.horizontal, 24)
    }
    
    
    // MARK: - Init
    
    init(onTypePicked: @escaping (ExerciseVO.Exercise) -> Void) {
        self.onTypePicked = onTypePicked
    }
}


// MARK: - Preview

#Preview("ExerciseTypePickerView") {
    ExerciseTypePickerView(onTypePicked: { _ in })
}

