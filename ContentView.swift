import SwiftUI

import MusicScore
import MusicSymbol
////https://github.com/dn-m/NotationModel
//

struct ContentView: View {
    @StateObject var orientationInfo = OrientationInfo()
    @StateObject var stateManagement = StateManagement()
    @StateObject var forDict = ForDict(songURL: ScoreSamples.url_spring1st)
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
        }.environmentObject(stateManagement)
            .environmentObject(orientationInfo)
            .environmentObject(forDict)
    }
}

class StateManagement: ObservableObject {
    @Published var paddingWidth: Double = 0
    @Published var selectedSong: URL = URL(string: "/Users/a970/Desktop/Developer/CorrectSwiftPMFormat.swiftpm/Resources/buttter.mid")!
}

struct IntroView: View {
    @EnvironmentObject var orientationInfo: OrientationInfo
    @State var letsgo: Bool = false
    @State var canStartDisplaying = false
    @State var pageIndex = 0
    @State var numberOfPages = 5
    @State var selectedTrack = -1
    @State var clef = Clef(.treble)
    @Binding var progress: CGFloat
    let gradient1 = Gradient(colors: [.purple, .yellow])
    let gradient2 = Gradient(colors: [.blue, .purple])
    var body: some View {
        if canStartDisplaying {
            GeometryReader { g in
                HStack {
                    let _ = print("selected track: ", selectedTrack)
                    CALayerCreatorWrapper(selectedTrack: $selectedTrack, startDisplaying: $canStartDisplaying, clef: $clef)
                }
            }
        } else {
            TabView(selection: $pageIndex) {
                ForEach(0..<numberOfPages, id: \.self) { page in
                    switch pageIndex {
                    case 0:
                        Intro_Page1(letsgo: $letsgo, pageIndex: $pageIndex, progress: $progress)
                    case 1:
                        ListOfSongs(pageIndex: $pageIndex, progress: $progress)
                    case 2:
                        ChooseTrackView(pageIndex: $pageIndex, selectedTrack: $selectedTrack, startDisplaying: $canStartDisplaying, chooseClef: $clef, progress: $progress)
                    case 3:
                        Text("")
                    default:
                        Text("Page whatever")
                    }

                }.onChange(of: orientationInfo.orientation) { newValue in
                    if newValue == .landscape && selectedTrack != -1 {
                        canStartDisplaying.toggle()
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

struct Intro_Page1: View {
    @Binding var letsgo: Bool
    @Binding var pageIndex: Int
    @Binding var progress: CGFloat
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
                Text("Welcome to Melodi!")
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
    @EnvironmentObject var stateManagement: StateManagement

    @EnvironmentObject var forDict: ForDict
    @Binding var pageIndex: Int
    @Binding var selectedTrack: Int
    @Binding var startDisplaying: Bool
    
    @Binding var chooseClef: Clef
    @State var isClefTreble = true
    
    @State var portraitAlertMessage: Bool = false
    @Binding var progress: CGFloat
        let gradient1 = Gradient(colors: [.purple, .yellow])
        let gradient2 = Gradient(colors: [.blue, .purple])
    
    
    var body: some View {
        NavigationView {
        ZStack {
            Rectangle()
                        .animatableGradient(fromGradient: gradient1, toGradient: gradient2, progress: progress)
                        .ignoresSafeArea()
                        .opacity(0.6)
                        
        VStack {
            
            
            ForEach(0..<ChooseMidiTrack().listOutAllNoteTracks(songURL: stateManagement.selectedSong)!.count - 1, id: \.self) { i in
                
                
                RoundedRectangle(cornerRadius: 15)
                    .foregroundColor(selectedTrack == i ? .green : .white)
                    .frame(width: 300, height: 50)
                    .overlay(
                        Text("\(forDict.key[i])")
                    )
                    .onTapGesture {
                        selectedTrack = i
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
            
            Text(orientationInfo.orientation == .portrait ? "turn your phone into landscape mode" : "")
            
            Button(action: {
                self.portraitAlertMessage = true
                if orientationInfo.orientation == .portrait {
                    print("turn phone into landscape")
                }
                if orientationInfo.orientation == .landscape {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    startDisplaying.toggle()
                    }
                }
                
            }) {
                Capsule()
                    .frame(width: 140, height: 35)
                    .overlay(
                        Text("Start displaying")
                            .foregroundColor(.white)
                    )
                    .foregroundColor(selectedTrack == -1 ? .gray.opacity(0.75) : .mint.opacity(0.95))

            }
//            .disabled((orientationInfo.orientation == .portrait) && (selectedTrack == -1) ? true : false)
            .disabled(orientationInfo.orientation == .portrait ? true : false)
            
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
        .navigationBarTitle("Choose Track")
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

class ForDict: ObservableObject {
    @Published var key: [String] = []
    @Published var value = []
    
    init(songURL: URL) {
        
        for keyValue in ChooseMidiTrack().listOutAllNoteTracks(songURL: songURL)! {
            for (key, value) in keyValue {
                print("\(key), \(value)")
                self.key.append(key)
                self.value.append(value)
            }
        }
    }
}
