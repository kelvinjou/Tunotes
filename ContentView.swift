import SwiftUI

import MusicScore
import MusicSymbol
////https://github.com/dn-m/NotationModel
//

struct ContentView: View {
    var body: some View {
        IntroView()
//            .onAppear {
//                ChooseMidiTrack().listOutAllNoteTracks()
//            }
    }
}

struct IntroView: View {
    @State var letsgo: Bool = false
    @State var startDisplaying = false
    @State var pageIndex = 0
    @State var numberOfPages = 5
    @State var selectedTrack = 0
    var body: some View {
        if startDisplaying {
            ScrollView(.horizontal) {
                HStack {
                    let _ = print("selected track: ", selectedTrack)
                    CALayerCreator(selectedTrack: selectedTrack)
                        .padding(.trailing, 185710.0)
                    Spacer()
                }
            }
////            PremadeViews()
////            NoteSequenceAsList()
        } else {
            TabView(selection: $pageIndex) {
                ForEach(0..<numberOfPages, id: \.self) { page in
                    switch pageIndex {
                    case 0:
                        Intro_Page1(letsgo: $letsgo, pageIndex: $pageIndex)
                    case 1:
                        VStack {
                            Text("Choose your track")
                            let _ = print("THIS", ChooseMidiTrack().listOutAllNoteTracks())
                            ForEach(0..<ChooseMidiTrack().listOutAllNoteTracks()!.count, id: \.self) { i in
                                Button(action: {
                                    selectedTrack = i
                                }) {
                                    Text("Track \(i + 1)")
                                }
                            }
                            
                            Button(action: {
                                //                            selectedTrack
                                startDisplaying.toggle()
                            }) {
                                Capsule()
                                    .frame(width: 140, height: 35)
                                    .overlay(
                                        Text("Start displaying")
                                            .foregroundColor(.white)
                                    )
                                    .foregroundColor(.mint)

                            }
                        }
                    case 2:
                        Text("")
                    default:
                        Text("Page whatever")
                    }

                }
            }.tabViewStyle(.page(indexDisplayMode: .never))
                .onChange(of: pageIndex) { value in
                    print(value)
                }
            UIPageControlView(currentPage: $pageIndex, numberOfPages: $numberOfPages)
                .frame(maxWidth: 0, maxHeight: 0)
                .padding(.bottom, 40)
        }
        
    }
}
        
struct UIPageControlView: UIViewRepresentable {
    @Binding var currentPage: Int
    @Binding var numberOfPages: Int
    
    func makeUIView(context: Context) -> UIPageControl {
        let uiView = UIPageControl()
        uiView.backgroundStyle = .prominent
        uiView.currentPage = currentPage
        uiView.numberOfPages = numberOfPages
        return uiView
    }
    
    func updateUIView(_ uiView: UIPageControl, context: Context) {
        uiView.currentPage = currentPage
        uiView.numberOfPages = numberOfPages
    }
}

struct Intro_Page1: View {
    @Binding var letsgo: Bool
    @Binding var pageIndex: Int
    var body: some View {
        VStack {
            Text("Welcome to Tunotes!")
            Button(action: {
//                letsgo.toggle()
                pageIndex += 1
            }) {
                Capsule()
                    .frame(width: 100, height: 35)
                    .overlay(
                        Text("Lets go!")
                            .foregroundColor(.white)
                    )
                    .foregroundColor(.mint)
                
            }
        }
        
    }
}
