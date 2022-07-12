//import SwiftUI
//
//import MusicScore
//import MusicSymbol
//import CoreMIDI
////https://github.com/dn-m/NotationModel
//

//struct ContentView: View {
//    let musicScore = MusicScore(url: ScoreSamples.url_spring1st)!
//    let noteLength = NoteLength.self
//    
//    let char5: Character = "\u{1F431}"
//    let quarter: Character = "\u{2669}"
//    let half: Character = "\u{1D15E}"
//    
//    var still_day6: URL {
//        return Bundle.main.url(forResource: "still_day6",
//                                 withExtension:"mid")!
//    }
//    var body: some View {
//        VStack {
//            Text("Hello, world!")
////            Canvas { context, size in
////
////            }
//            ZStack {
//                VStack {
//                    Divider().frame(height: 2).overlay(.black)
//                    Divider().frame(height: 2).overlay(.black)
//                    Divider().frame(height: 2).overlay(.black)
//                    Divider().frame(height: 2).overlay(.black)
//                    Divider().frame(height: 2).overlay(.black)
//                }.font(.largeTitle)
////                Canvas { context, size in
////                    context.withCGContext { cgContext in
////                        let rect = CGRect(origin: 0, size: size)
////                    }
////                    context.withCGContext { cgContext in
////                        let rect = CGRect(origin: .zero, size: size).insetBy(dx: 40, dy: 40)
////                        let path = CGPath(ellipseIn: rect, transform: nil)
////                        cgContext.addPath(path)
////                        cgContext.setStrokeColor(UIColor.black.cgColor)
////                        cgContext.setFillColor(UIColor.red.cgColor)
////                        cgContext.setLineWidth(24)
////                        cgContext.setAlpha(0.5)
////                        cgContext.setLineDash(phase: 3, lengths: [2*Double.pi*15])
////                        cgContext.drawPath(using: .eoFillStroke)
////                    }
//                //                }
//                HStack {
//                    ForEach(testAccessMeasureAndNotes(), id: \.self) { i in
//                        switch i.duration {
//                        case noteLength.oneSixteenth.rawValue:
//                            Image("sixteenth")
//                                .resizable()
//                                .frame(width: 45, height: 45)
//                                .modifier(NoteUpWholeStep(howManyFromF: -matchKeyToOffset(pitch: i.pitch)))
//                        case noteLength.oneEighth.rawValue:
//                            Image("eighth")
//                                .resizable()
//                                .frame(width: 45, height: 45)
//                                .modifier(NoteUpWholeStep(howManyFromF: matchKeyToOffset(pitch: i.pitch)))
//                        case noteLength.quarter.rawValue:
//                            Image("quarter")
//                                .resizable()
//                                .frame(width: 45, height: 45)
//                                .modifier(NoteUpWholeStep(howManyFromF: 2))
//                        case noteLength.half.rawValue:
//                            Image("half")
//                                .resizable()
//                                .frame(width: 45, height: 45)
//                                .modifier(NoteUpWholeStep(howManyFromF: -matchKeyToOffset(pitch: i.pitch)))
//                            //TODO: get note.pitch.key and match it with the enum. If it matches, get the corresponding offset
//                                
//                            //                    Text("\(String(quarter)) \(String(quarter))").font(.system(size: 32))
//                        case noteLength.whole.rawValue:
//                            Text("\(String(quarter)) \(String(quarter)) \(String(quarter)) \(String(quarter))")
//                        default:
//                            Text("Default")
//                        }
//                    }
//                }
//                
//            }.frame(width: UIScreen.main.bounds.width - 40, height: 300)
//            
//        }
//        .padding()
//        .onAppear {
////            print(musicScore)
////            testAccessMeasureAndNotes()
////            print(half)
////                XCTAssertEqual(musicScore.musicParts[0].notes.count, 8)
//            }
//    }
////        MusicNotation()
//        func testAccessMeasureAndNotes() -> [NoteInScore] {
//            let score = MusicScore(url: ScoreSamples.url_spring1st)!
//            
////            print(score.musicParts[0].notes[0].noteName, 8)
//            print("End beat", score.musicParts[0].measures[0].notes[0].duration)
//            
////            let violinPart = score.musicPartOf(instrument: .violin)!
//            
////            XCTAssertEqual(score.musicParts[0].notes[0].noteName, "A3")
////            XCTAssertEqual(score.musicParts[0].notes[1].noteName, "C4")
////
////            XCTAssertEqual(score.musicParts[0].measures.count, 1)
////            XCTAssertEqual(score.musicParts[0].measures[0].notes[0].beats, "A3")
//            var musicDuration: [NoteInScore] = []
//            var currentElement = 0
//                print(score.musicParts[0].measures[3].notes[1].duration)
//            for i in score.musicParts[0].measures[6].notes {
//                print("pitch of note", i.note.pitch)
//                musicDuration.append(i)
//                currentElement += 1
//                if i.noteName.count == currentElement {
//                    return musicDuration
//                }
//            }
//            return []
//            
//    }
//    enum NoteLength: Double {
//        case oneSixteenth = 0.25
//        case oneEighth = 0.5
//        
//        case quarter = 1.0
//        case half = 2.0
//        case whole = 4.0
//    }
//    
//    
//    func matchKeyToOffset(pitch: Pitch) -> Double {
//        let matchKey: [MappingNoteToOffset : Double] = [
//            .D4 : -2,
//            .E4 : -1,
//            .F4 : 0,
//            .G4 : 1,
//            .A4 : 2,
//            .B4 : 3,
//            .C5 : 4,
//            .D5 : 5,
//            .E5 : 6,
//            .F5 : 7,
//            .G5 : 8,
//            .A5 : 9
//            
//        ]
//        
////        pitch order: C, D, E, F, G, A, B
////        sharps & flats
////        octave order: 3, 4, 5
////        F = 0
////        Each note increase = 5.5 CGFloat
//        _ = "A♯4"
//        for i in matchKey {
//            if String("\(pitch)") == String("\(i.key)") {
//                print(pitch)
//                return i.key.rawValue
//            }
//        }
//        return 0
//    }
//}
//
//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        QuarterNoteSymbol().frame(width: 200, height: 50)
//    }
//}
//
//struct QuarterNoteSymbol: Shape {
//    func path(in rect: CGRect) -> Path {
//        var path = Path()
//        path.move(to: CGPoint(x: rect.midX, y: rect.maxY))
//        path.addQuadCurve(to: CGPoint(x: rect.midX, y: rect.minY), control: CGPoint(x: rect.minX, y: rect.minY))
//        path.addQuadCurve(to: CGPoint(x: rect.midX, y: rect.maxY), control: CGPoint(x: rect.maxX, y: rect.minY))
//        
//        return path
//    }
//}
//
//struct NoteUpWholeStep: ViewModifier {
//    var howManyFromF: CGFloat
//    
//    func body(content: Content) -> some View {
//        content
//            .offset(y: 5.5 * howManyFromF)
//    }
//}
//
//
//
//enum MappingNoteToOffset: Double, CaseIterable {
//    case D4 = -2
//    case E4 = -1
//    case F4 = 0
//    case G4 = 1
//    case A4 = 2
//    case B4 = 3
//    //MARK: turn the thing stave upside down: reflect over y axis then reflect over x axis
//    case C5 = 4
//    case D5 = 5
//    case E5 = 6
//    case F5 = 7
//    case G5 = 8
//    case A5 = 9
//}
