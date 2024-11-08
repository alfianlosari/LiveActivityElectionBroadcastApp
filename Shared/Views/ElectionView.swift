//
//  ElectionView.swift
//  LiveElectionTutorial
//
//  Created by Alfian Losari on 08/11/24.
//

import SwiftUI

struct ElectionView: View {
    
    let election: ElectionType
    
    var body: some View {
        VStack(spacing: 12) {
            HStack {
                CircleImage(imageName: election.aImageName, bgColor: .blue)
                Text("\(election.aCount)")
                    .font(.title)
                Spacer()
                Text("\(election.bCount)")
                    .font(.title)
                CircleImage(imageName: election.bImageName, bgColor: .red)
            }
            
            CustomProgressView(leftValue: election.aPercent, rightValue: election.bPercent)
            
            HStack {
                Text(election.aName)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                Spacer()
                Text(election.bName)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
        }
    }
}

struct CircleImage: View {
    
    let imageName: String?
    let bgColor: Color
    var size: CGSize = .init(width: 40, height: 40)
    
    var body: some View {
        Image(imageName ?? "")
            .resizable()
            .background(bgColor)
            .clipShape(Circle())
            .frame(width: size.width, height: size.height)
    }
    
}

struct CustomProgressView: View {
    var leftValue: CGFloat
    var rightValue: CGFloat
    
    var body: some View {
        GeometryReader { geometry in
            let totalWidth = geometry.size.width
            let leftWidth = min(totalWidth * (leftValue), totalWidth)
            let rightWidth = min(totalWidth * (rightValue), totalWidth)
            
            ZStack {
                HStack(spacing: 0) {
                    Rectangle()
                        .fill(Color.blue)
                        .frame(width: leftWidth, height: 10)
                        .cornerRadius(5, corners: [.topLeft, .bottomLeft])
                    
                    Rectangle()
                        .fill(Color.gray.opacity(0.5))
                        .frame(width: totalWidth - leftWidth - rightWidth, height: 10)
                    
                    Rectangle()
                        .fill(Color.red)
                        .frame(width: rightWidth, height: 10)
                        .cornerRadius(5, corners: [.topRight, .bottomRight])
                }
                
                Rectangle()
                    .fill(Color.black)
                    .frame(width: 1, height: 10)
                    .position(x: totalWidth / 2, y: 5)
            }
        }
        .frame(height: 10)
    }
}

struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
}


#Preview {
    List {
        ElectionView(election: ElectionWidgetAttributes.ContentState(aName: "Kamala Harris", bName: "Donald Trump", aCount: 226, bCount: 295, aPercent: 0.4, bPercent: 0.55, aImageName: "kamalaharris", bImageName: "donaldtrump"))
    }
}
