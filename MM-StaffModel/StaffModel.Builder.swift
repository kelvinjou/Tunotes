//
//  StaffModel.Builder.swift
//  StaffModel
//
//  Created by James Bean on 6/25/17.
//
//

import DataStructures

extension StaffModel {
    
    public static var builder: Builder {
        return Builder()
    }
    
    public final class Builder {
        
        var clef: Clef = Clef(.treble)
        var points: [Double : [StaffPointModel] ] = [:]
        var noteDurations: [Double : [Double] ] = [:]
        
        public init() {

        }
        
        public func set(_ clef: Clef) {
            self.clef = clef
        }
        
        public func add(_ point: Point, at position: Double, noteDuration: Double) {
            points[position, default: []].append(point)
            noteDurations[position, default: []].append(noteDuration)
//            points1[position, default: [[:]] ].append([point : noteDuration])
        }
        
        public func build() -> StaffModel {
            var noteDurationArray: [Double] = []
            
            let sorted = noteDurations.sorted {
                return $0.key < $1.key
            }
            for (_, j) in sorted {
                for x in j {
                    noteDurationArray.append(x)
                }
            }
            print("This array", noteDurationArray)
            return StaffModel(clef: clef, points: points, noteDuration: noteDurationArray)
        }
    }
}
