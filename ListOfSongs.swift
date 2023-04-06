//
//  File.swift
//  CorrectSwiftPMFormat
//
//  Created by Kelvin J on 3/31/23.
//

import SwiftUI
import MusicScore


struct ListOfSongs: View {
    @EnvironmentObject var stateManagement: StateManagement
    @Binding var pageIndex: Int
    let list: [URL] = [
//        ScoreSamples.url_spring1st
        Bundle.main.url(forResource: "Happy Birthday", withExtension: "mid")!,
        Bundle.main.url(forResource: "Chopin nocturne op. 9, no. 2", withExtension: "mid")!,
        Bundle.main.url(forResource: "Beethoven Violin Sonata No.5 Op.24", withExtension: "mid")!,
        Bundle.main.url(forResource: "DAY6 Shoot Me", withExtension: "mid")!,
        Bundle.main.url(forResource: "DAY6 I'll Try", withExtension: "mid")!
        

    ]
    @Binding var progress: CGFloat
    let gradient1 = Gradient(colors: [.purple, .yellow])
    let gradient2 = Gradient(colors: [.blue, .purple])
    @State var selected = -1
    var body: some View {
        NavigationView {
            ZStack {
                Rectangle()
                    .animatableGradient(fromGradient: gradient1, toGradient: gradient2, progress: progress)
                    .ignoresSafeArea()
                    .opacity(0.6)
                    .onAppear {
                        withAnimation(.linear(duration: 5.0).repeatForever(autoreverses: true)) {
                            self.progress = 1.0
                        }
                    }
                VStack {
                    
                        Text("Here's a few MIDI files that you could try out and display individual instrument parts. Sometimes, it could be fustrating when you can't find music scores meant for multiple instruments. This is where Melodi comes in!")
                            .bold()
                            .padding()
                    VStack {
                        ScrollView(showsIndicators: false) {
                            ForEach(0..<list.count, id: \.self) { song in
                                RoundedRectangle(cornerRadius: 15)
                                    .foregroundColor(selected == song ? .green : .white)
                                    .frame(width: 300, height: 50)
                                    .overlay(
                                        Text(String(list[song].lastPathComponent))
                                    )
                                    .onTapGesture {
                                        selected = song
                                        stateManagement.selectedSong = list[song]
                                    }
                            }
                        }
                        .padding()
                        Button(action: {
                            
                            pageIndex += 1
                        }) {
                            Capsule()
                                .frame(width: 140, height: 35)
                                .overlay(
                                    Text("View song")
                                        .foregroundColor(.white)
                                )
                                .foregroundColor(selected == -1 ? .gray.opacity(0.75) : .mint.opacity(0.95))
                        }
                    }
                }
            }
            .navigationBarTitle("Choose Song")
            .navigationBarItems(
                leading: Button(action: {
                    pageIndex -= 1
                }) {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.primary)
                }
            )
        }
    }
}
