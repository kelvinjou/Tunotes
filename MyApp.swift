import SwiftUI

@main
struct MyApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(OrientationInfo())
//V2CALayer()
        }
    }
}
