//

import SwiftUI


public struct ExerciseTile: View {
    
    // MARK: - Properties
    
    private let viewObject: ExerciseVO
    private let dismissAction: () -> Void
    private let action: () -> Void
    
    
    // MARK: - Body
    
    public var body: some View {
        Button(action: action) {
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 8) {
                    HStack(spacing: 8) {
                        viewObject.exercise.icon
                            .resizable()
                            .frame(width: 32, height: 32)
                            .bold()
                            .foregroundStyle(Color.white)
                        
                        
                        Text(viewObject.exercise.localized.translation)
                            .font(.title3)
                            .bold()
                            .foregroundColor(.white)
                    }
                    
                    if let locationName = viewObject.locationName {
                        HStack(spacing: 4) {
                            Image(systemName: "mappin.and.ellipse")
                                .foregroundStyle(Color.white)
                            
                            Text(locationName)
                                .font(.caption)
                                .foregroundColor(.white)
                        }
                    }
                    
                    HStack(spacing: 4) {
                        Image(systemName: "stopwatch")
                            .foregroundStyle(Color.white)
                        
                        Text("\(viewObject.durationMinutes) \("minutes".localized.translation)")
                            .font(.footnote)
                            .bold()
                            .foregroundColor(.white)
                    }
                    
                    Text(viewObject.description)
                        .font(.caption)
                        .foregroundColor(.white)
                }
                
                Spacer()
                
                VStack(spacing: 4) {
                    switch viewObject.storageType {
                    case .local:
                        Image(systemName: "icloud.slash.fill")
                            .foregroundStyle(Color.mainRed)
                    case .remote:
                        Image(systemName: "checkmark.icloud.fill")
                            .foregroundStyle(Color.mainGreen)
                    }
                    
                    Spacer()
                    
                    Image(systemName: "pencil")
                        .foregroundColor(.white)
                        .bold()
                        .padding(.bottom, 8)
                    
                    Spacer()
                }
            }
            .padding(16)
            .background(Color.mainBlue)
            .cornerRadius(16)
            .dragDismissable(dismissAction, buttonAlignment: .trailing)
        }
    }
    
    
    // MARK: - Init
    
    public init(viewObject: ExerciseVO, action: @escaping () -> Void, dismissAction: @escaping () -> Void) {
        self.viewObject = viewObject
        self.dismissAction = dismissAction
        self.action = action
    }
}


// MARK: - Preview

#Preview {
    ExerciseTile(viewObject: .preview, action: { }, dismissAction: { })
        .padding()
        .asComponentPreview()
}
