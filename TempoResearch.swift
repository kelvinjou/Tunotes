//
//  File.swift
//  CorrectSwiftPMFormat
//
//  Created by Kelvin J on 7/16/22.
//

import DataStructures
import Math
import Pitch
import Articulations
import Duration
import Dynamics
import MusicModel

class TempoResearch {
    public let smth = 0
    func testMeters() {
        let startTempo = Tempo(60, subdivision: 4)
        let endTempo = Tempo(120, subdivision: 4)
        let builder = Model.Builder()
            .addMeter(Meter(4, 4))
            .addTempo(startTempo, easing: .linear)
            .addMeter(Meter(4,4))
            .addMeter(Meter(4,4))
            .addMeter(Meter(4,4))
            .addTempo(endTempo)

        let pitch: Pitch = 60
        let performer = Performer(name: "Eleven")
        let rhythm = Rhythm<Event>(1/>4, [
            event(Event([pitch])),
            event(Event([pitch + 10])),
        ])
        let instrument = Instrument(name: "Upside Down")
        let voiceID = builder.createVoice(performer: performer, instrument: instrument)
        let rhythmID = builder.createRhythm(rhythm, voiceID: voiceID, offset: .zero)
        
        print(rhythm.durationTree.duration)
        
        rhythm.durationTree.duration.beats
        
        builder.build()
        
        
        
//        let rhythmID = builder.createRhythm(rhythm, voiceID: voiceID, offset: .zero)
//

    }
}


// MODEL:
//func testHelloWorld() {
//let performer = Performer(name: "Jordan")
//let instrument = Instrument(name: "Violin")
//let pitch: Pitch = 60
//let articulation: Articulation = .tenuto
//let dynamic: Dynamic = .fff
//let note = Rhythm<Event>(1/>1, [event(Event([pitch, dynamic, articulation]))])
//let meter = Meter(4,4)
//let tempo = Tempo(120, subdivision: 4)
//let builder = Model.Builder()
//builder.addMeter(meter)
//builder.addTempo(tempo)
//let voiceID = builder.createVoice(performer: performer, instrument: instrument)
//_ = builder.createRhythm(note, voiceID: voiceID, offset: .zero)
//}
