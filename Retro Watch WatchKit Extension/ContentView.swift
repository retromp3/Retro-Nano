//
//  ContentView.swift
//  Retro Watch WatchKit Extension
//
//  Created by Sakun on 4/26/21.
//

import SwiftUI

struct ContentView: View {
    @State private var action: Int? = 0

    var body: some View {
        NavigationView{
            ZStack{
                Image("wallpaper1")
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)
                MainPagesContainer(contentCount: 6) {
                        VStack{
                            ZStack{
                                Image("play")
                                    .resizable()
                                    .scaledToFit()
                                    .cornerRadius(20)
                                    .onTapGesture {
                                        self.action = 1
                                    }
                                NavigationLink(destination: NowPlaying(), tag: 1, selection: $action) {
                                    Text("")
                                    //EmptyView()
                                }.hidden()
                            }
                            Text("Now Playing")
                                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                                .shadow(color: .black, radius: 0.5, x: 0.5, y: 0.5)
                        }
                        VStack{
                            ZStack{
                                Image("songs")
                                    .resizable()
                                    .scaledToFit()
                                    .cornerRadius(20)
                                    .onTapGesture {
                                        self.action = 2
                                    }
                                NavigationLink(destination: NowPlaying(), tag: 2, selection: $action) {
                                }.hidden()
                            }
                            Text("Songs")
                                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                                .shadow(color: .black, radius: 0.5, x: 0.5, y: 0.5)
                        }
                        VStack{
                            ZStack{
                                Image("Playlists")
                                    .resizable()
                                    .scaledToFit()
                                    .cornerRadius(20)
                                    .onTapGesture {
                                        self.action = 3
                                    }
                                NavigationLink(destination: NowPlaying(), tag: 3, selection: $action) {
                                }.hidden()
                            }
                            Text("Playlists")
                                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                                .shadow(color: .black, radius: 0.5, x: 0.5, y: 0.5)
                        }
                            VStack{
                                ZStack{
                                    Image("Artist")
                                        .resizable()
                                        .scaledToFit()
                                        .cornerRadius(20)
                                        .onTapGesture {
                                            self.action = 4
                                        }
                                    NavigationLink(destination: ClockView(), tag: 4, selection: $action) {
                                        Text("")
                                        //EmptyView()
                                    }.hidden()
                                }
                                Text("Artists")
                                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                                    .shadow(color: .black, radius: 0.5, x: 0.5, y: 0.5)
                        }
                        VStack{
                            ZStack{
                                Image("Clock")
                                    .resizable()
                                    .scaledToFit()
                                    .cornerRadius(20)
                                    .onTapGesture {
                                        self.action = 5
                                    }
                                NavigationLink(destination: ClockView(), tag: 5, selection: $action) {
                                    Text("")
                                    //EmptyView()
                                }.hidden()
                            }
                            Text("Clock")
                                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                                .shadow(color: .black, radius: 0.5, x: 0.5, y: 0.5)
                    }
                    VStack{
                        ZStack{
                            Image("Settings")
                                .resizable()
                                .scaledToFit()
                                .cornerRadius(20)
                                .onTapGesture {
                                    self.action = 6
                                }
                            NavigationLink(destination: Settings(), tag: 6, selection: $action) {
                            }.hidden()
                        }
                        Text("Settings")
                            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                            .shadow(color: .black, radius: 0.5, x: 0.5, y: 0.5)
                }
                }
                .frame(width: 140, height: 140)
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
