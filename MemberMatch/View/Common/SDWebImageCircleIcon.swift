import SwiftUI
import SDWebImageSwiftUI

struct SDWebImageCircleIcon: View {

    let imageURL: URL?
    let width   : CGFloat
    let height  : CGFloat
    let defaultIcon: String

    init(_ imageURL: URL?, width: CGFloat, height: CGFloat, defaultIcon: String) {
        self.imageURL = imageURL
        self.width = width
        self.height = height
        self.defaultIcon = defaultIcon
    }

    var body: some View {
        if let imageURL = imageURL {

            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(.white).opacity(0.01)
                    .frame(width: width, height: height)
                WebImage(url: imageURL) {image in
                    image
                } placeholder: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundColor(.black.opacity(0.2))
                            .frame(width: width, height: height)
                        ProgressView()
                    }
                }
                .resizable()
                .scaledToFill()
                .frame(width: width, height: height)
                .clipShape(Circle())
                .shadow(radius: 1, x: 2, y: 2)
                .shadow(radius: 1, x: 2, y: 2)
                .allowsHitTesting(false)
            }

        } else {
            Circle()
                .frame(width: width, height: height)
                .foregroundStyle(.gray)
                .shadow(radius: 1, x: 1, y: 1)
                .overlay {
                    VStack(spacing: 20) {
                        Image(systemName: defaultIcon)
                            .resizable()
                            .scaledToFit()
                            .frame(width: width * 0.55)
                            .foregroundStyle(.white.opacity(0.8))
                    }
                }
        }
    }
}

#Preview {
    SDWebImageCircleIcon(nil, width: 200, height: 200, defaultIcon: "person.fill")
}
