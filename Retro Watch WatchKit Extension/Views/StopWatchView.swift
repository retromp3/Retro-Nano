//
//  StopWatchView.swift
//  Retro Watch WatchKit Extension
//
//  Created by Sakun on 4/26/21.
//

import SwiftUI
import Combine

struct StopWatchButton : View {
    var actions: [() -> Void]
    var labels: [String]
    var color: Color
    var isPaused: Bool
    
    var body: some View {
        
        return Button(action: {
            if self.isPaused {
                self.actions[0]()
            } else {
                self.actions[1]()
            }
        }) {
            if isPaused {
                Text(self.labels[0])
                    .foregroundColor(Color.white)
                    .frame(width: 100,
                           height: 20)
            } else {
                Text(self.labels[1])
                    .foregroundColor(Color.white)
                    .frame(width: 100,
                           height: 20)
            }
        }
    }
}

struct StopWatchView : View {
    @ObservedObject var stopWatch = StopWatch()
    
    var body: some View {
        VStack {
            Text(self.stopWatch.stopWatchTime)
                .font(.custom("courier", size: 30))
                .frame(width: 170,
                       height: 100,
                       alignment: .center)

            HStack{
                StopWatchButton(actions: [self.stopWatch.reset, self.stopWatch.lap],
                                labels: ["Reset", "Lap"],
                                color: Color.red,
                                isPaused: self.stopWatch.isPaused())

                StopWatchButton(actions: [self.stopWatch.start, self.stopWatch.pause],
                                labels: ["Start", "Pause"],
                                color: Color.blue,
                                isPaused: self.stopWatch.isPaused())
            }

           /* VStack(alignment: .leading) {
                Text("Laps")
                    .font(.headline)
                    .padding()

                List {
                    ForEach(self.stopWatch.laps, id: \.uuid) { (lapItem) in
                        Text(lapItem.stringTime)
                    }
                }
            }*/
        }
    }
}

struct StopWatchView_Previews: PreviewProvider {
    static var previews: some View {
        StopWatchView()
    }
}
