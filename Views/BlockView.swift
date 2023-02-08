import SwiftUI

struct BlockView : View {
    
    fileprivate let colorScheme: [(Color, Color)] = [
        // 2
        (Color(red:0.87, green:0.86, blue:0.85, opacity:1.00), Color(red:0.42, green:0.39, blue:0.35, opacity:1.00)),
        // 4
        (Color(red:0.34, green:0.54, blue:0.56, opacity:1.00), Color.white),
        // 8
        (Color(red:0.52, green:0.74, blue:0.82, opacity:1.00), Color.white),
        // 16
        (Color(red:0.32, green:0.69, blue:0.88, opacity:1.00), Color.white),
        // 32
        (Color(red:0.37, green:0.42, blue:0.67, opacity:1.00), Color.white),
        // 64
        (Color(red:0.61, green:0.73, blue:0.54, opacity:1.00), Color.white),
        // 128
        (Color(red:0.87, green:0.66, blue:0.48, opacity:1.00), Color.white),
        // 256
        (Color(red:0.94, green:0.78, blue:0.50, opacity:1.00), Color.white),
        // 512
        (Color(red:0.47, green:0.36, blue:0.52, opacity:1.00), Color.white),
        // 1024
        (Color(red:0.72, green:0.55, blue:0.60, opacity:1.00), Color.white),
        // 2048
        (Color(red:0.85, green:0.44, blue:0.57, opacity:1.00), Color.white),
    ]
    
    fileprivate let number: Int?
    
    fileprivate let textId: String?
    
    init(block: IdentifiedBlock) {
        self.number = block.number
        self.textId = "\(block.id):\(block.number)"
    }
    
    fileprivate init() {
        self.number = nil
        self.textId = ""
    }
    
    static func blank() -> Self {
        return self.init()
    }
    
    fileprivate var numberText: String {
        guard let number = number else {
            return ""
        }
        return String(number)
    }
    
    fileprivate var fontSize: CGFloat {
        let textLength = numberText.count
        if textLength < 3 {
            return 32
        } else if textLength < 4 {
            return 18
        } else {
            return 12
        }
    }
    
    fileprivate var colorPair: (Color, Color) {
        guard let number = number else {
            return (Color(red:0.23, green:0.26, blue:0.31, opacity:1.00), Color.black)
        }
        let index = Int(log2(Double(number))) - 1
        if index < 0 || index >= colorScheme.count {
            fatalError("No color for such number")
        }
        return colorScheme[index]
    }
    
    // MARK: Body
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(colorPair.0)
                .zIndex(1)

            Text(numberText)
                .font(Font.system(size: fontSize).bold())
                .foregroundColor(colorPair.1)
                .id(textId!)
                .zIndex(1000)
                .transition(AnyTransition.opacity.combined(with: .scale))
        }
        .clipped()
        .cornerRadius(6)
    }
    
}

// MARK: - Previews

#if DEBUG
struct BlockView_Previews : PreviewProvider {
    
    static var previews: some View {
        Group {
            ForEach((1...11).map { Int(pow(2, Double($0))) }, id: \.self) { i in
                BlockView(block: IdentifiedBlock(id: 0, number: i))
                    .previewLayout(.sizeThatFits)
            }
            
            BlockView.blank()
                .previewLayout(.sizeThatFits)
        }
    }
    
}
#endif
