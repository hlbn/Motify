//

import SwiftUI


public struct ExerciseTile: View {
    
    // MARK: - Properties
    
    private let viewObject: ExerciseVO
    
    
    // MARK: - Body
    
    public var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                switch viewObject.storageType {
                case .local:
                    Image(systemName: "icloud.slash.fill")
                        .foregroundStyle(Color.mainRed)
                case .remote:
                    Image(systemName: "checkmark.icloud.fill")
                        .foregroundStyle(Color.mainGreen)
                }
                
                Text(viewObject.title)
                    .font(.title3)
                    .bold()
                    .foregroundColor(.white)
                
                Text(viewObject.description)
                    .font(.caption)
                    .foregroundColor(.white)
                
                Text("\(viewObject.durationMinutes) \("minutes".localized.translation)")
                    .font(.footnote)
                    .bold()
                    .foregroundColor(.white)
                    .padding(.top, 4)
            }
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .foregroundColor(.white)
                .bold()
        }
        .padding(16)
        .background(Color.mainBlue)
        .cornerRadius(16)
    }
    
    
    // MARK: - Init
    
    public init(viewObject: ExerciseVO) {
        self.viewObject = viewObject
    }
}


// MARK: - Preview

#Preview {
    ExerciseTile(viewObject: .preview)
        .padding()
        .asComponentPreview()
}
