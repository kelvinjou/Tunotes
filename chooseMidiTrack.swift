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
//    private let midiFileController = MidiFileController()
    let midi = MidiData()
    let data = ScoreSamples.url_spring1st
    
    func listOutAllNoteTracks(songURL: URL) -> [ [String : MidiNoteTrack] ]? {
        var listOfNoteTracks: [MidiNoteTrack]
        var listOfDict: [ [String : MidiNoteTrack] ] = [[ : ]]
        
        //        guard let url = URL(songURL),
        //            guard let url = Bundle.main.url(forResource: "Beethoven_-_Violin_Sonata_No.5_Op.24_Spring_movement_I._Allegro", withExtension: "mid"),
        guard let data = try? Data(contentsOf: songURL) else {
            print("failed")
            return nil
        }
        midi.load(data: data)
        print("DIE FOR YOU", getMusicParts2(midi: midi))
        
        
        print(midi.noteTracks.count)
        
        for i in 0..<midi.noteTracks.count {
            let instrumentName = getMusicParts2(midi: midi)[i]
            let track = midi.noteTracks[i]
            listOfDict.append([instrumentName : track])
        }
//        MIDIScoreParser().loadMusicScore(url: <#T##URL#>)
//        for i in 0..<midi.noteTracks.count {
//            listOfNoteTracks.append(midi.infoDictionary[.trackNumber])
//            print("HERE---", midi.noteTracks[i])
//        }
//        var this = MIDIScoreParser().getMusicParts(midi: midi)
//        print("INFO DICT: ", this[0])
//        listOfNoteTracks = midi.noteTracks
        return listOfDict
    }
    func getMusicParts2(midi: MidiData) -> [String] {
        var notesInTracks: [[NoteInScore]] = []
        var result: [String] = []
        var instrument = InstrumentType.unknown
        
        print("HEREEEEEEERE", midi.noteTracks.count)
        for idx in 0..<midi.noteTracks.count {
//            let notes = notesInTracks[idx]
//
//            // skip empty track
//            if midi.noteTracks[idx].isEmpty {
//                continue
//            }

            // get instrument type, if don't find instrument
            if let midiPatch = midi.noteTracks[idx].patch {
                instrument = InstrumentType(rawValue: Int(midiPatch.patch.rawValue))!
            }
            let name = String(reflecting: instrument) + "_\(idx)"
            let part = "\(instrument)"

            result.append(part)

        }
        
        return result
    }
    
}
