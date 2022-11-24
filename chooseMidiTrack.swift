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
    func listOutAllNoteTracks() -> [ [String : MidiNoteTrack] ]? {
        var listOfNoteTracks: [MidiNoteTrack]
        var listOfDict: [ [String : MidiNoteTrack] ] = [[ : ]]
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
            print("DIE FOR YOU", getMusicParts2(midi: midi))
            //            print("HEREEEE", MIDIScoreParser().getMusicParts(midi: midi)[0].meta.instrument)
            
            
        } catch {
            print(error.localizedDescription)
        }
        
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
//            if notes.isEmpty {
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
