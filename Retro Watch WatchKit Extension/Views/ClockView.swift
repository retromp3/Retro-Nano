//
//  ClockView.swift
//  Retro Watch WatchKit Extension
//
//  Created by Sakun on 4/26/21.
//

import SwiftUI

struct ClockView: View {
    @State var isDark = false;
    var body: some View {
        NavigationView {
            PagesContainer(contentCount: 2) {
                Clock(isDark: $isDark)
                    .preferredColorScheme(isDark ? .dark : .light)
                StopWatchView()
            }
        }
    }
}

struct ClockView_Previews: PreviewProvider {
    static var previews: some View {
        ClockView()
    }
}

struct Clock : View {
    @Binding var isDark : Bool
    var width = 250
    @State var current_time = Time(min: 0, sec: 0, hour: 0)
    @State var receiver = Timer.publish(every: 1, on: .current, in: .default).autoconnect()
    
    var body: some View {
        ZStack{
            Circle()
                .fill(Color("Color").opacity(0.1))
            
            ForEach(0..<60, id: \.self){i in
                Rectangle()
                    .fill(Color.primary)
                    .frame(width:2, height: (i%5) == 0 ? 15 : 5)
                    .offset(y: CGFloat((width-110)/2))
                    .rotationEffect(.init(degrees:Double(i)*6))
            }
            //sec
            Rectangle()
                .fill(Color.red)
                .frame(width: 2, height: CGFloat((width - 180))/2)
                .offset(y: CGFloat(-(width - 180)/2))
                .rotationEffect(.init(degrees: Double(current_time.sec) * 6))
            //min
            Rectangle()
                .fill(Color.primary)
                .frame(width: 3.5, height: CGFloat((width - 140))/3)
                .offset(y: CGFloat(-(width - 125)/4))
                .rotationEffect(.init(degrees: Double(current_time.min) * 6))
            //hr
            Rectangle()
                .fill(Color.primary)
                .frame(width: 3.5, height: CGFloat((width - 150))/4)
                .offset(y: CGFloat(-(width - 200)/2))
                .rotationEffect(.init(degrees: (Double(current_time.hour) + (Double(current_time.min)/60)) * 30))
            Circle()
                .fill(Color.primary)
                .frame(width:15, height:15)
        }
        .onAppear(perform: {
            let calendar = Calendar.current
            let min = calendar.component(.minute, from:Date())
            let sec = calendar.component(.second, from:Date())
            let hour = calendar.component(.hour, from:Date())
            
            withAnimation(Animation.linear(duration: 0.01)){
                self.current_time = Time(min: min, sec: sec, hour: hour)
            }
        })
        .onReceive(receiver) { (_) in
            let calendar = Calendar.current
            let min = calendar.component(.minute, from:Date())
            let sec = calendar.component(.second, from:Date())
            let hour = calendar.component(.hour, from:Date())
            
            withAnimation(Animation.linear(duration: 0.01)){
                self.current_time = Time(min: min, sec: sec, hour: hour)
            }
        }
        //.frame(width: width - 80, height: width - 80)
    }
}

struct Time {
    var min: Int
    var sec: Int
    var hour: Int
}
