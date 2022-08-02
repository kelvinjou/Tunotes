import SwiftUI

import MusicScore
import MusicSymbol
////https://github.com/dn-m/NotationModel
//

struct ContentView: View {
    var body: some View {
        IntroView()
    }
}

struct IntroView: View {
    @State var pageIndex = 0
    @State var numberOfPages = 5
    var body: some View {
        TabView(selection: $pageIndex) {
            
            ForEach(0..<numberOfPages, id: \.self) { page in
                switch pageIndex {
                case 0:
                    Intro_Page1(pageIndex: $pageIndex)
                case 1:
                    Text("page 1")
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
    @Binding var pageIndex: Int
    var body: some View {
        VStack {
            Text("Welcome to Tunotes!")
            Button(action: {
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
