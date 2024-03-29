//
//  BeamNoteheads.swift
//  CorrectSwiftPMFormat
//
//  Created by Kelvin J on 3/23/23.
//
import SwiftUI
import Pitch
import Duration
import Foundation
import MusicModel
import Rendering
import Geometry



class BeamsNoteheads {
    func beamsAndNoteheads(externalPitches: [NoteModel], clef: Clef) -> StyledPath.Composite {

        let representable = externalPitches.map {
            StaffRepresentablePitch($0.spelledPitch)
        }
        let points = representable.map { StaffPointModel([$0]) }
        let positions = (0..<externalPitches.count).map { Double($0) * 100 + 100 }

        let builder = StaffModel.builder
        
        for (position, point, i) in zip3(positions, points, 0..<points.count) {
            builder.add(point, at: position, noteDuration: externalPitches[i].duration, spelledNote: representable[i].spelledPitch, clef: clef)

        }
        
        let model = builder.build()
        let staff = StaffView(model: model)
        let newBeam = Beam(start: Point(x: 1, y: 1), end: Point(x: 2, y: 2), width: 1)
        let score = ScoreView(beams: BeamsView(beams: [newBeam], color: .black), staff: staff).rendered.resizedToFitContents
        
        return score
    
    }
}


struct Zip3Sequence<E1, E2, E3>: Sequence, IteratorProtocol {
    private let _next: () -> (E1, E2, E3)?

    init<S1: Sequence, S2: Sequence, S3: Sequence>(_ s1: S1, _ s2: S2, _ s3: S3) where S1.Element == E1, S2.Element == E2, S3.Element == E3 {
        var it1 = s1.makeIterator()
        var it2 = s2.makeIterator()
        var it3 = s3.makeIterator()
        _next = {
            guard let e1 = it1.next(), let e2 = it2.next(), let e3 = it3.next() else { return nil }
            return (e1, e2, e3)
        }
    }

    mutating func next() -> (E1, E2, E3)? {
        return _next()
    }
}

extension BeamsNoteheads {
    func zip3<S1: Sequence, S2: Sequence, S3: Sequence>(_ s1: S1, _ s2: S2, _ s3: S3) -> Zip3Sequence<S1.Element, S2.Element, S3.Element> {
        return Zip3Sequence(s1, s2, s3)
    }
}
