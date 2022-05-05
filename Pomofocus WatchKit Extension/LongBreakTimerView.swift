//
//  LongBreakView.swift
//  Pomofocus WatchKit Extension
//
//  Created by Amy Kwak on 5/4/22.
//

import SwiftUI

struct LongBreakTimerView: View {
    
    @State var isTimerRunning = false
    @State var to:CGFloat = 0
    @State var timeDuration = 900
    @State var timer = Timer.publish(every: 1, on: .main, in:.common).autoconnect()
    
    var body: some View {
        ZStack {
            VStack {
                Text("Long Break")
                    .padding(.horizontal, 10.0)
                    .background(Color("TitleBackgroundColor"))
                    .cornerRadius(5.0)
                    .padding(.top, 12.0)
                    .padding(.bottom, 5.0)
                Text("\(self.timeDuration, specifier: formatTime())")
                    .font(.system(size: 50))
                    .padding(.top, -3.0)
                Button(action: {
                    if self.timeDuration > 0 {
                        self.timeDuration -= 1
                        withAnimation(.default) {
                            self.to -= 1
                        }
                        self.isTimerRunning.toggle()
                    } else {
                        self.isTimerRunning.toggle()
                    }
                }) {
                    Text(self.isTimerRunning ? "PAUSE" : "START")
                        .font(.title3)
                        .foregroundColor(Color("LongBreakBackgroundColor"))
                }
                .frame(height: 40.0)
                .background(Color.white)
                .cornerRadius(10.0)
                .padding(.horizontal, 20.0)
                .padding(.bottom, 15.0)
            }
            .background(Color("BodyColor"))
            .cornerRadius(10.0)
            .padding(.horizontal)
        }
        .onReceive(self.timer, perform: { _ in
            if self.isTimerRunning {
                if self.timeDuration != 0 {
                    self.timeDuration -= 1
                    withAnimation(.default) {
                        self.to = CGFloat(self.timeDuration)/1500
                    }
                }
            } else {
                self.timeDuration = self.timeDuration
            }
        })
    }
    func formatTime()->String {
        let minutes = Int(timeDuration) / 60 % 60
        let seconds = Int(timeDuration) % 60
        return String(format: "%02i:%02i", minutes, seconds)
    }
}

struct LongBreakTimerView_Previews: PreviewProvider {
    static var previews: some View {
        LongBreakTimerView()
    }
}
