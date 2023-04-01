//
//  File.swift
//  CorrectSwiftPMFormat
//
//  Created by Kelvin J on 7/14/22.
//

import MusicScore
//import MusicSymbol
import QuartzCore
import QuartzAdapter
import SwiftUI
import Rendering
import UIKit
import Path
import Pitch

//class UniversalLayer: ObservableObject {
//    @Published var layer: CALayerCreator
//}

struct CALayerCreatorWrapper: View {
    @Binding var selectedTrack: Int
    @Binding var startDisplaying: Bool
    
    @Binding var clef: Clef
    
    @State private var offset: CGFloat = 0
    @State var minWidth = 0.0
    
    @State var startScrolling = false
    
    @State private var sliderValue: Double = 0.5
    
    // MARK: make this into a tuple: notStarted, rendering, and finished render
    @State var doneRendering: Bool = false
    var body: some View {
        let movedOffset = self.offset
        ZStack(alignment: Alignment.bottom) {
            let layer = CALayerCreator(selectedTrack: selectedTrack, clef: clef, doneRendering: $doneRendering)
            //            ZStack(alignment: Alignment.bottomLeading) {
            ScrollView(.horizontal) {
//                GeometryReader { proxy in
//                    let anotherOffset = proxy.frame(in: .named("scroll")).minY
//                    let _ = print(anotherOffset)
                
                    layer
                        .padding(.trailing, minWidth)
                        .offset(x: self.offset, y: 0)
                        .onAppear {
                            minWidth = CALayer(PremadeViews().beamsAndNoteheads(externalPitches: layer.testAccessMeasureAndNotes(selectedTrack: selectedTrack), clef: Clef(.treble))).bounds.width
                            
//                        }
//                        .coordinateSpace(name: "scroll")
                }
                
            }
            HStack {
                Button(action: {
                    print("pressed")
                    startDisplaying = false
                }) {
                    Circle()
                        .frame(width: 40, height: 40)
                        .foregroundColor(.white)
                        .overlay(
                            Image(systemName: "chevron.left")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 20, height: 20)
                            
                        )
                        .opacity(0.85)

                    
                }
//                Spacer()
//
//                Button(action: {
//                    withAnimation {
//
//                        self.offset = -self.offset
//                    }
//                }) {
//                Capsule()
//                    .foregroundColor(.white)
//                    .frame(width: 170, height: 50)
//                    .overlay(Text("Back to Beginning"))
//                    .opacity(0.85)
//
//                }
                
                Spacer()
                HStack(spacing: 15) {
                    Button(action: {
                        withAnimation {
                            startScrolling.toggle()
                            Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { timer in
                                self.offset -= sliderValue * 2.25
                                if !self.startScrolling {
                                    timer.invalidate()
                                }
                            }
                        }
                    }) {
                        Circle()
                            .frame(width: 50, height: 50)
                            .foregroundColor(.white)
                            .overlay(
                                Image(systemName: startScrolling ? "pause.fill" : "play.fill")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 25, height: 25)
                                
                            )
                            .opacity(0.85)
                            .padding()
                    }
                    
                    
                    
                    Text("Adjust autoscroll")
                    Slider(value: $sliderValue, in: 0...1)
                        .frame(width: 200)
                }
            }.padding()
        }
        
        
    }
}

struct CALayerCreator: UIViewRepresentable {
    var selectedTrack: Int
    var clef: Clef
    
    var observation: NSKeyValueObservation?
    @Binding var doneRendering: Bool
    func makeUIView(context: Context) -> some UIView {
        let scrollView: UIScrollView = {
               let view = UIScrollView()
               view.translatesAutoresizingMaskIntoConstraints = false
               return view
           }()
        let rect = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width / 2, height: UIScreen.main.bounds.height / 2))
        
        rect.addSubview(scrollView)
                
                // constrain the scroll view to 8-pts on each side
                scrollView.leftAnchor.constraint(equalTo: rect.leftAnchor, constant: 8.0).isActive = true
                scrollView.topAnchor.constraint(equalTo: rect.topAnchor, constant: 8.0).isActive = true
                scrollView.rightAnchor.constraint(equalTo: rect.rightAnchor, constant: -8.0).isActive = true
                scrollView.bottomAnchor.constraint(equalTo: rect.bottomAnchor, constant: -8.0).isActive = true
    
//          MARK: for singular composite
        lazy var layer2 = CALayer(PremadeViews().beamsAndNoteheads(externalPitches: testAccessMeasureAndNotes(selectedTrack: selectedTrack), clef: clef))


        rect.layer.addSublayer(layer2)
        
        CATransaction.begin()
        CATransaction.setCompletionBlock({
            print("Layer rendering completed!")
            doneRendering = true
        })
        layer2.displayIfNeeded() // Trigger rendering of layer
        CATransaction.commit()
        
        return rect

        
    
    }
    func imageFromLayer(layer:CALayer) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(layer.frame.size, layer.isOpaque, 0)
        layer.render(in: UIGraphicsGetCurrentContext()!)
        let outputImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return outputImage!
    }
    func updateUIView(_ uiView: UIViewType, context: Context) {}
    
    func testAccessMeasureAndNotes(selectedTrack: Int) -> [NoteModel] {
        
        let score = MusicScore(url: ScoreSamples.url_spring1st)!
        
        var noteModelArray: [NoteModel] = []
        var numberOfNotes: Int = 0
        var currentElement = 0
        for j in 0..<score.musicParts[selectedTrack].measures.count {
            for i in score.musicParts[selectedTrack].measures[j].notes {
                
                let fullDesc = i.note.pitch.key.description
                let notePitch = fullDesc[0]
                let rawAccidental = fullDesc[1]
                
                var accidental: Pitch.Spelling.Modifier = .natural
                rawAccidental.map { value in
                    if value == "♯" {
                        accidental = .sharp
                    }
                }
                
                var noteModel = NoteModel(spelledPitch: SpelledPitch(.b, .natural), duration: 0)
                Keys.allCases.forEach {
                    if notePitch == $0.rawValue {
                        noteModel = NoteModel(
                            spelledPitch: SpelledPitch(
                                spelling: Keys(rawValue: notePitch)!.keyMapping,
                                octave: i.note.pitch.octave),
                            duration: i.duration,
                            measureNum: j
                        )
                    }
                }
                
                noteModelArray.append(noteModel)
                numberOfNotes += 1
                currentElement += 1
                if currentElement == score.musicParts[0].notes.count {
                    return noteModelArray
                }
            }
            print("this is measure", j , "which is after ")
        }
        return []
        
    }
    
    func drawLine(position: CGFloat) -> CAShapeLayer {
        // Create a CAShapeLayer
                let shapeLayer = CAShapeLayer()

                // The Bezier path that we made needs to be converted to
                // a CGPath before it can be used on a layer.
                shapeLayer.path = drawUIBezierPath().cgPath

                // apply other properties related to the path
                shapeLayer.strokeColor = UIColor.gray.cgColor
                shapeLayer.fillColor = UIColor.white.cgColor
                shapeLayer.lineWidth = 5.0
                shapeLayer.position = CGPoint(x: position, y: 10)

                // add the new layer to our custom view
                return shapeLayer
    }
    
    func drawUIBezierPath() -> UIBezierPath {
        // create a new path
            let path = UIBezierPath()
            path.move(to: CGPoint(x: 2, y: 100))
            path.addLine(to: CGPoint(x: 2, y: 25))
        
            return path
    }
}

struct NoteModel {
    var spelledPitch: SpelledPitch
    var duration: Double
    var measureNum: Int?
    
}

enum Keys: String, CaseIterable {
    case c = "C"
    case d = "D"
    case e = "E"
    case f = "F"
    case g = "G"
    case a = "A"
    case b = "B"
    
    var keyMapping: Pitch.Spelling {
        switch self {
        case .c: return Pitch.Spelling.c
        case .d: return Pitch.Spelling.d
        case .e: return Pitch.Spelling.e
        case .f: return Pitch.Spelling.f
        case .g: return Pitch.Spelling.g
        case .a: return Pitch.Spelling.a
        case .b: return Pitch.Spelling.b
        }
    }
}


extension String {

    var length: Int {
        return count
    }

    subscript (i: Int) -> String {
        return self[i ..< i + 1]
    }

    func substring(fromIndex: Int) -> String {
        return self[min(fromIndex, length) ..< length]
    }

    func substring(toIndex: Int) -> String {
        return self[0 ..< max(0, toIndex)]
    }

    subscript (r: Range<Int>) -> String {
        let range = Range(uncheckedBounds: (lower: max(0, min(length, r.lowerBound)),
                                            upper: min(length, max(0, r.upperBound))))
        let start = index(startIndex, offsetBy: range.lowerBound)
        let end = index(start, offsetBy: range.upperBound - range.lowerBound)
        return String(self[start ..< end])
    }
}
