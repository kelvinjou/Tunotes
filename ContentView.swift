import SwiftUI

import MusicScore
import MusicSymbol
////https://github.com/dn-m/NotationModel
//

struct ContentView: View {
    @EnvironmentObject var orientationInfo: OrientationInfo
    
    @State private var progress: CGFloat = 0
        let gradient1 = Gradient(colors: [.purple, .yellow])
        let gradient2 = Gradient(colors: [.blue, .purple])
    var body: some View {
        ZStack(alignment: Alignment(horizontal: .center, vertical: .top)) {
            Rectangle()
                        .animatableGradient(fromGradient: gradient1, toGradient: gradient2, progress: progress)
                        .ignoresSafeArea()
                        .opacity(0.6)
                        .onAppear {
                            withAnimation(.linear(duration: 5.0).repeatForever(autoreverses: true)) {
                                self.progress = 1.0
                            }
                            
                        }
            Text("Device is in '\(orientationInfo.orientation == .portrait ? "portrait" : "landscape")' ")
            IntroView(progress: $progress)
        }
    }
}

class StateManagement: ObservableObject {
    @Published var paddingWidth: Double = 0
}

struct IntroView: View {
    @EnvironmentObject var orientationInfo: OrientationInfo
    @StateObject var stateManagement = StateManagement()
    
    @State var letsgo: Bool = false
    @State var startDisplaying = false
    @State var pageIndex = 0
    @State var numberOfPages = 5
    @State var selectedTrack = -1
    @State var clef = Clef(.treble)
    @Binding var progress: CGFloat
    let gradient1 = Gradient(colors: [.purple, .yellow])
    let gradient2 = Gradient(colors: [.blue, .purple])
    var body: some View {
        if startDisplaying {
            GeometryReader { g in
                HStack {
                    let _ = print("selected track: ", selectedTrack)
                    CALayerCreatorWrapper(selectedTrack: $selectedTrack, startDisplaying: $startDisplaying, clef: $clef)
                }
            }
//            .task {
//                stateManagement.paddingWidth = CALayer(PremadeViews().beamsAndNoteheads(externalPitches: CALayerCreator(selectedTrack: selectedTrack, clef: Clef(.treble)).testAccessMeasureAndNotes(selectedTrack: selectedTrack), clef: clef)).bounds.width
//
//            }
        } else {
            TabView(selection: $pageIndex) {
                ForEach(0..<numberOfPages, id: \.self) { page in
                    switch pageIndex {
                    case 0:
                        Intro_Page1(letsgo: $letsgo, pageIndex: $pageIndex)
                    case 1:
                        ChooseTrackView(pageIndex: $pageIndex, selectedTrack: $selectedTrack, startDisplaying: $startDisplaying, chooseClef: $clef)
                    case 2:
                        Text("")
                    default:
                        Text("Page whatever")
                    }

                }.onChange(of: orientationInfo.orientation) { newValue in
                    if newValue == .landscape && selectedTrack != -1 {
                        startDisplaying.toggle()
                    }
                }
            }.onAppear {
                withAnimation(.linear(duration: 5.0).repeatForever(autoreverses: true)) {
                    self.progress = 1.0
                }
            }
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
    @State private var progress: CGFloat = 0
        let gradient1 = Gradient(colors: [.purple, .yellow])
        let gradient2 = Gradient(colors: [.blue, .purple])
    var body: some View {
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
                Text("Welcome to Tunotes!")
                    .bold()
                    .font(.title)
                Text("🎸🎹🎻🎷🎺")
                    .font(.title)
                    .padding(.top, 5)
                Text("Musicians! Have you ever wanted to play in a band with your friends but couldn't find any arrangements of the song on the web? In this app, you could pick any midi file and play your instrument's corresponding part!")
                    .multilineTextAlignment(.center)
                    .font(.body)
                    .padding()
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
}

struct ChooseTrackView: View {
    @EnvironmentObject var orientationInfo: OrientationInfo
    @ObservedObject var forDict = ForDict()
    @Binding var pageIndex: Int
    @Binding var selectedTrack: Int
    @Binding var startDisplaying: Bool
    
    @Binding var chooseClef: Clef
    @State var isClefTreble = true
    
    @State var portraitAlertMessage: Bool = false
    @State private var progress: CGFloat = 0
        let gradient1 = Gradient(colors: [.purple, .yellow])
        let gradient2 = Gradient(colors: [.blue, .purple])
    var body: some View {
        ZStack {
            Rectangle()
                        .animatableGradient(fromGradient: gradient1, toGradient: gradient2, progress: progress)
                        .ignoresSafeArea()
                        .opacity(0.6)
                        
        VStack {
            Text("Choose Your Track")
                .bold()
                .font(.headline)
                .padding(10)
            
            
            ForEach(0..<ChooseMidiTrack().listOutAllNoteTracks()!.count - 1, id: \.self) { i in
            
                Button(action: {
                    selectedTrack = i
                }) {
                    RoundedRectangle(cornerRadius: 10)
                        .frame(width: 150, height: 30)
                        .foregroundColor(selectedTrack == i ? Color.white : Color.secondary.opacity(0.8))
                        .overlay( Text("\(forDict.key[i])") )
                    
                }
            }
            
            Toggle(isOn: $isClefTreble) {
                Text(isClefTreble ? "Display in treble clef" : "Display in bass clef")
            }
            .padding()
            .onChange(of: isClefTreble) { value in
                if value == true {
                    chooseClef = Clef(.treble)
                }
                else {
                    chooseClef = Clef(.bass)
                }
            }
            
            Button(action: {
                self.portraitAlertMessage = true
                if orientationInfo.orientation == .portrait {
                    print("turn phone into landscape")
                }
                else {
                    startDisplaying.toggle()
                }
                
            }) {
                Capsule()
                    .frame(width: 140, height: 35)
                    .overlay(
                        Text("Start displaying")
                            .foregroundColor(.white)
                    )
                    .foregroundColor(selectedTrack == -1 ? .gray.opacity(0.75) : .mint.opacity(0.95))

            }.disabled(selectedTrack == -1 ? true : false)
            
            if orientationInfo.orientation == .portrait && self.portraitAlertMessage == true {
                Label {
                    Text("Turn Phone Into Landscape")
                } icon: {
                    Image(systemName: "iphone.landscape")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 35, height: 35)
                }
            }
        }
        }
    }
}

class ForDict: ObservableObject {
    @Published var key: [String] = []
    @Published var value = []
    
    init() {
        
        for keyValue in ChooseMidiTrack().listOutAllNoteTracks()! {
            for (key, value) in keyValue {
                print("\(key), \(value)")
                self.key.append(key)
                self.value.append(value)
            }
        }
    }
}
