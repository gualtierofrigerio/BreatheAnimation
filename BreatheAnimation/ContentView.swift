//
//  ContentView.swift
//  BreatheAnimation
//
//  Created by Gualtiero Frigerio on 08/03/2020.
//  Copyright © 2020 Gualtiero Frigerio. All rights reserved.
//

import SwiftUI

struct CustomCircle: View {
    @Binding var size:CGFloat
    @Binding var animate:Bool
    var offset:CGPoint
    
    var gradient1 = Color(UIColor.systemGray)
    var gradient2 = Color(UIColor.systemGreen)
    
    var body: some View {
        Circle()
        .fill(
            LinearGradient(gradient:
                Gradient(colors: [gradient1, gradient2]),
                           startPoint: .bottomLeading, endPoint: .topTrailing)
        )
            .frame(width: size, height: size)
            .scaleEffect(animate ? 1 : 0.4)
            .offset(x: offset.x, y: offset.y)
    }
}

struct ContentView: View {
    var offsetSize: CGFloat = 40
    @State var circleSize: CGFloat = 100
    @State var animate = false
    
    private func offsetForCircle(atIndex index:Int) -> CGPoint {
        var offset = CGPoint(x:0, y:0)
        if animate {
            switch index {
            case 0:
                offset = CGPoint(x:-offsetSize, y: 0)
            case 1:
                offset = CGPoint(x:offsetSize, y:0)
            case 2:
                offset = CGPoint(x:offsetSize / 2, y:-offsetSize)
            case 3:
                offset = CGPoint(x:offsetSize / 2, y: offsetSize)
            case 4:
                offset = CGPoint(x:-offsetSize / 2, y:-offsetSize)
            case 5:
                offset = CGPoint(x:-offsetSize / 2, y: offsetSize)
            default:
                offset = CGPoint(x:0, y:0)
            }
        }
        return offset
    }

    var body: some View {
        VStack {
            Spacer()
            ZStack {
                ZStack {
                    ForEach(0..<6) { index in
                        CustomCircle(size:self.$circleSize, animate:self.$animate,
                                     offset:self.offsetForCircle(atIndex: index))
                    }
                }
                .rotationEffect(Angle(degrees: self.animate ? 0 : 90))
                .opacity(0.8)
                .animation(Animation.easeOut(duration: 2.0).repeatForever(autoreverses: true))
                .onAppear {
                    self.animate = true
                }
            }
            Spacer()
            // Slider for debug purpose
            Group {
                Text("Circle size \(circleSize)")
                Slider(value: $circleSize, in: 50...150, step:1.0)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
