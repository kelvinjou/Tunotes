//
//  StaffRepresentedPitch.swift
//  StaffView
//
//  Created by James Bean on 1/16/17.
//
//


import Geometry
import Rendering

/// TODO: Add configuration
public struct StaffRepresentedPitch {
    
    private let position: Double
    private let representableContext: StaffRepresentablePitch
    private let altitude: Double
    private let staffSlotHeight: StaffSlotHeight
    
    public let notehead: NoteheadView?
    public let accidental: AccidentalView?
    public let noteDuration: Double
    
    public init(
        for representablePitch: StaffRepresentablePitch,
        at position: Double,
        altitude: Double,
        staffSlotHeight: StaffSlotHeight,
        noteDuration: Double
    )
    {
        self.representableContext = representablePitch
        self.position = position
        self.altitude = altitude
        self.staffSlotHeight = staffSlotHeight
        self.noteDuration = noteDuration
        
        #warning("THIS IS USED BY StaffRepresentablePitch")
        self.notehead = NoteheadView(
            position: Point(x: position, y: altitude),
            size: NoteheadView.Size(staffSlotHeight: staffSlotHeight, scale: 1),
            noteDuration: noteDuration
        )

        self.accidental = AccidentalView.makeAccidental(representableContext.accidental,
            at: Point(x: position - 2.5 * staffSlotHeight, y: altitude),
            size: StaffItemSize(staffSlotHeight: staffSlotHeight, scale: 1),
            color: .black
        )
    }
}
