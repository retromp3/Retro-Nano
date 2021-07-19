//
//  NowPlaying.swift
//  Retro Watch WatchKit Extension
//
//  Created by Sakun on 4/26/21.
//

import SwiftUI
import AVKit
import AVFoundation


struct NowPlaying: View {
    @State private var showLargeIcons = true
    var body: some View {
        Player()
    }
}
struct NowPlaying_Previews: PreviewProvider {
    static var previews: some View {
        NowPlaying()
    }
}

struct Player: View {
    @State var data : Data = .init(count: 0)
    @State var title = ""
    @State var artist = ""
    @State var player : AVAudioPlayer!
    @State var playing = false
    @State var width : CGFloat = 0
    @State var songs = ["dont-start", "free","count-on-you", "levels"]
    @State var current = 0
    @State var finish = false
    @State var del = AVdelegate()
    @State var text : String = "This is some very long text for a song"
    //@Binding var musicPlayer: MPMusicPlayerController
    @State private var isPlaying = false
    //@Binding var currentSong: Song
    var body: some View {
        ZStack{
            Image(uiImage: self.data.count == 0 ? UIImage(named: "itunes")! : UIImage(data: self.data)!)
                .resizable()
                .scaledToFit()
                .edgesIgnoringSafeArea(.all)
                .padding(.top)
                .opacity(0.5)
        GeometryReader { geometry in
            VStack {
                Text(self.title)
                    .font(Font.system(size:18).bold())
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .shadow(color: .black, radius: 0.5, x: 0.5, y: 0.5)
                    
                Text(self.artist)
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    .shadow(color: .black, radius: 0.5, x: 0.5, y: 0.5)
                    .font(.system(size:15))
                    .padding(.top,10)
            }.padding(.top,20)
            
            
            PagesContainer(contentCount: 2) {
                HStack(alignment: .center) {
                    Button(action: {
                            if self.current > 0{
                                
                                self.current -= 1
                                
                                self.ChangeSongs()
                            }
                        }) {
                            ZStack {
                                Image(systemName: "backward.fill")
                                    .resizable()
                                           .aspectRatio(contentMode: .fit)
                                    .scaleEffect(0.5)
                                    .foregroundColor(.white)
                                    .font(.system(.title))
                            }
                        }.buttonStyle(PlainButtonStyle())
                     
                        Button(action: {
                            if self.player.isPlaying{
                                
                                self.player.pause()
                                self.playing = false
                            }
                            else{
                                
                                if self.finish{
                                    
                                    self.player.currentTime = 0
                                    self.width = 0
                                    self.finish = false
                                    
                                }
                                
                                self.player.play()
                                self.playing = true
                            }
                        }) {
                            ZStack {
                            
                                Image(systemName: self.playing && !self.finish ? "pause.fill" : "play.fill")
                                    .resizable()
                                           .aspectRatio(contentMode: .fit)
                                    .scaleEffect(0.7)
                                    .foregroundColor(.white)
                                    .font(.system(.title))
                                    
                            }
                        }.buttonStyle(PlainButtonStyle())
                     
                        Button(action: {
                            if self.songs.count - 1 != self.current{
                                
                                self.current += 1
                                
                                self.ChangeSongs()
                            }
                        }) {
                            ZStack {
                                Image(systemName: "forward.fill")
                                    .resizable()
                                           .aspectRatio(contentMode: .fit)
                                    .scaleEffect(0.5)
                                    .foregroundColor(.white)
                                    .font(.system(.title))
                            }
                        }.buttonStyle(PlainButtonStyle())
                }
                
                HStack(alignment: .center) {
                    
                    ZStack(alignment: .leading) {
                    
                        Capsule().fill(Color.white.opacity(0.09)).frame(height: 8)
                        
                        Capsule().fill(Color.blue).frame(width: self.width, height: 8)
                            .gesture(DragGesture()
                            .onChanged({ (value) in
                                
                                let x = value.location.x
                                
                                self.width = x
                                
                            }).onEnded({ (value) in
                                
                                let x = value.location.x
                                
                                let screen = WKInterfaceDevice.current().screenBounds.width - 30
                                
                                let percent = x / screen
                                
                                self.player.currentTime = Double(percent) * self.player.duration
                            }))
                    }
                }
                
            }.padding(EdgeInsets(top: 100, leading: 0, bottom: -10, trailing: 0))
        }.onAppear {
            
            let url = Bundle.main.path(forResource: self.songs[self.current], ofType: "mp3")
            
            self.player = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: url!))
            
            self.player.delegate = self.del
            
            self.player.prepareToPlay()
            self.getData()
            
            Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { (_) in
                
                if self.player.isPlaying{
                    
                    let screen = WKInterfaceDevice.current().screenBounds.width - 30
                    
                    let value = self.player.currentTime / self.player.duration
                    
                    self.width = screen * CGFloat(value)
                }
            }
            
            NotificationCenter.default.addObserver(forName: NSNotification.Name("Finish"), object: nil, queue: .main) { (_) in
                
                self.finish = true
            }
        }
        }
        
    }

    
    func getData(){
        
        
        let asset = AVAsset(url: self.player.url!)
        
        for i in asset.commonMetadata{
            
            if i.commonKey?.rawValue == "artwork"{
                
                let data = i.value as! Data
                self.data = data
            }
            
            if i.commonKey?.rawValue == "title"{
                
                let title = i.value as! String
                self.title = title
            }
            if i.commonKey?.rawValue == "artist"{
                
                let artist = i.value as! String
                self.artist = artist
            }
        }
    }
    
    func ChangeSongs(){
        
        let url = Bundle.main.path(forResource: self.songs[self.current], ofType: "mp3")
        
        self.player = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: url!))
        
        self.player.delegate = self.del
        
        self.data = .init(count: 0)
        
        self.title = ""
        
        self.player.prepareToPlay()
        self.getData()
        
        self.playing = true
        
        self.finish = false
        
        self.width = 0
        
        self.player.play()
        

    }
}


class AVdelegate : NSObject,AVAudioPlayerDelegate{
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        
        NotificationCenter.default.post(name: NSNotification.Name("Finish"), object: nil)
    }
}

