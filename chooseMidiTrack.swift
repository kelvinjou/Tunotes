//
//  File.swift
//  CorrectSwiftPMFormat
//
//  Created by Kelvin J on 10/15/22.
//

import Foundation
import MidiParser
import MusicScore
import MusicModel
import MusicSymbol

class ChooseMidiTrack {
    let midi = MidiData()
    let data = ScoreSamples.url_spring1st
    
    func listOutAllNoteTracks(songURL: URL) -> [ [String : MidiNoteTrack] ]? {
//        var listOfNoteTracks: [MidiNoteTrack]
        var listOfDict: [ [String : MidiNoteTrack] ] = [[ : ]]
        
        guard let data = try? Data(contentsOf: songURL) else {
            print("failed")
            return nil
        }
        midi.load(data: data)

        
        for i in 0..<midi.noteTracks.count {
            let instrumentName = getMusicParts2(midi: midi)[i]
            let track = midi.noteTracks[i]
            listOfDict.append([instrumentName : track])
        }
        return listOfDict
    }
    func getMusicParts2(midi: MidiData) -> [String] {
        var result: [String] = []
        var instrument = InstrumentType.unknown
        
        for idx in 0..<midi.noteTracks.count {

            // get instrument type, if don't find instrument
            if let midiPatch = midi.noteTracks[idx].patch {
                instrument = InstrumentType(rawValue: Int(midiPatch.patch.rawValue))!
            }
            let part = "\(instrument)"

            result.append(part)

        }
        
        return result
    }
}
