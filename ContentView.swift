import SwiftUI

import MusicScore
import MusicSymbol
////https://github.com/dn-m/NotationModel
//

struct ContentView: View {
    var body: some View {
        ScrollView(.horizontal) {
//            fillingPath()
            HStack {
                CALayerCreator()
                    .offset(y: UIScreen.main.bounds.height / 3)
                    .scaledToFit()
                    .padding(35)
                    .padding(.trailing, 1000000)
            }
            .onAppear {
                TempoResearch().testMeters()
            }
        }.frame(maxWidth: .infinity)
    }
}


        
