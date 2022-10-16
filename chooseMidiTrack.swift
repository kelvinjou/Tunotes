//
//  File.swift
//  CorrectSwiftPMFormat
//
//  Created by Kelvin J on 10/15/22.
//

import Foundation
import MidiParser
import MusicScore

class ChooseMidiTrack {
//    private let midiFileController = MidiFileController()
    let midi = MidiData()
    let data = ScoreSamples.url_spring1st
    func listOutAllNoteTracks() -> [MidiNoteTrack]? {
        var listOfNoteTracks: [MidiNoteTrack]

        do {
//            try midi.load(data: FakeMidiData.midiDataTempo60)
//            let data = try midiFileController.data(fromFileName: "MIDI_sample.mid")
//            sut.load(data: data)
            guard let url = Bundle.main.url(forResource: "Beethoven_-_Violin_Sonata_No.5_Op.24_Spring_movement_I._Allegro", withExtension: "mid"),
                let data = try? Data(contentsOf: url) else {
                print("failed")
                return nil
            }
            midi.load(data: data)
        } catch {
            print(error.localizedDescription)
        }
        
        print(midi.noteTracks.count)
        
//        for i in 0..<midi.noteTracks.count {
//            listOfNoteTracks.append(midi.infoDictionary[.trackNumber])
//            print("HERE---", midi.noteTracks[i])
//        }
        
        listOfNoteTracks = midi.noteTracks
        return listOfNoteTracks
    }
    
}
