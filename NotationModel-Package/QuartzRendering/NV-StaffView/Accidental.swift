//
//  Natural.swift
//  Staff
//
//  Created by James Bean on 6/14/16.
//
//

import Geometry
import Path
import Rendering

public class Natural: AccidentalView {
    
    var left: Double {
        return 0
    }
    
    var insideLeft: Double {
        return thinLineWidth
    }
    
    var insideRight: Double {
        return width - thinLineWidth
    }
    
    var right: Double {
        return width
    }
    
    private var outside: Path {
        
        let builder = Path.builder
            .move(to: Point())
            .addLine(to: Point(x: insideLeft, y: 0))
            .addLine(to: point(x: insideLeft, displace: -thickLineDisplace, from: .above))
            .addLine(to: point(x: right, displace: -thickLineDisplace, from: .above))
            .addLine(to: Point(x: right, y: height))
            .addLine(to: Point(x: insideRight, y: height))
            .addLine(to: point(x: insideRight, displace: thickLineDisplace, from: .below))
            .addLine(to: point(x: left, displace: thickLineDisplace, from: .below))
            .close()
        
        return builder.build()
    }
    
    private var inside: Path {
        
        let builder = Path.builder
            .move(to: point(x: insideLeft, displace: -thickLineDisplace, from: .below))
            .addLine(to: point(x: insideRight, displace: -thickLineDisplace, from: .below))
            .addLine(to: point(x: insideRight, displace: thickLineDisplace, from: .above))
            .addLine(to: point(x: insideLeft, displace: thickLineDisplace, from: .above))
            .close()
        
        return builder.build()
    }
    
    public override var path: Path {
        return outside + inside
    }
}


public class Sharp: AccidentalView {
    
    var left: Double {
        return 0
    }
    
    var outsideLeft: Double {
        return flankWidth
    }
    
    var insideLeft: Double {
        return flankWidth + thinLineWidth
    }
    
    var outsideRight: Double {
        return width - flankWidth
    }
    
    var insideRight: Double {
        return width - flankWidth - thinLineWidth
    }
    
    var right: Double {
        return width
    }
    
    private var outside: Path {
        
        let builder = Path.builder
            .move(to: Point(x: flankWidth, y: centerReference.y - shortColumnHeight))
            .addLine(to: Point(x: insideLeft, y: centerReference.y - shortColumnHeight))
            .addLine(to: point(x: insideLeft, displace: -thickLineDisplace, from: .above))
            .addLine(to: point(x: insideRight, displace: -thickLineDisplace, from: .above))
            .addLine(to: Point(x: insideRight, y: 0))
            .addLine(to: Point(x: outsideRight, y: 0))
            .addLine(to: point(x: outsideRight, displace: -thickLineDisplace, from: .above))
            .addLine(to: point(x: width, displace: -thickLineDisplace, from: .above))
            .addLine(to: point(x: right, displace: -thickLineDisplace, from: .below))
            .addLine(to: point(x: outsideRight, displace: -thickLineDisplace, from: .below))
            .addLine(to: point(x: outsideRight, displace: thickLineDisplace, from: .above))
            .addLine(to: point(x: right, displace: thickLineDisplace, from: .above))
            .addLine(to: point(x: right, displace: thickLineDisplace, from: .below))
            .addLine(to: point(x: outsideRight, displace: thickLineDisplace, from: .below))
            .addLine(to: Point(x: outsideRight, y: centerReference.y + shortColumnHeight))
            .addLine(to: Point(x: insideRight, y: centerReference.y + shortColumnHeight))
            .addLine(to: point(x: insideRight, displace: thickLineDisplace, from: .below))
            .addLine(to: point(x: insideLeft, displace: thickLineDisplace, from: .below))
            .addLine(to: Point(x: insideLeft, y: height))
            .addLine(to: Point(x: outsideLeft, y: height))
            .addLine(to: point(x: outsideLeft, displace: thickLineDisplace, from: .below))
            .addLine(to: point(x: left, displace: thickLineDisplace, from: .below))
            .addLine(to: point(x: left, displace: thickLineDisplace, from: .above))
            .addLine(to: point(x: outsideLeft, displace: thickLineDisplace, from: .above))
            .addLine(to: point(x: outsideLeft, displace: -thickLineDisplace, from: .below))
            .addLine(to: point(x: left, displace: -thickLineDisplace, from: .below))
            .addLine(to: point(x: left, displace: -thickLineDisplace, from: .above))
            .addLine(to: point(x: outsideLeft, displace: -thickLineDisplace, from: .above))
            .close()
        
        return builder.build()
    }
    
    private var inside: Path {
        
        let builder = Path.builder
            .move(to: point(x: insideLeft, displace: -thickLineDisplace, from: .below))
            .addLine(to: point(x: insideRight, displace: -thickLineDisplace, from: .below))
            .addLine(to: point(x: insideRight, displace: thickLineDisplace, from: .above))
            .addLine(to: point(x: insideLeft, displace: thickLineDisplace, from: .above))
            .close()
        
        return builder.build()
    }
    
    public override var path: Path {
        return outside + inside
    }
    
    public var tallColumnHeight: Double {
        return 2.1 * size
    }
    
    public var shortColumnHeight: Double {
        return 1.9 * size
    }
    
    override var height: Double {
        return 2 * tallColumnHeight
    }
    
    override var width: Double {
        return midWidth + 2 * flankWidth
    }
}

public class Flat: AccidentalView {
    
    var tallColumnHeight: Double {
        return 3.236 * size
    }
    
    var shortColumnHeight: Double {
        return 1.4 * size
    }
    
    override var height: Double {
        return tallColumnHeight + shortColumnHeight
    }
    
    var bodyHeight: Double {
        return 2.5 * size
    }
    
    var bodyTop: Double {
        return height - bodyHeight
    }
    
    var bowlLineWidthTop: Double {
        return 0.375 * size
    }
    
    var bowlLineWidthBottom: Double {
        return 0.764 * size
    }
    
    var bowlLineWidthStress: Double {
        return 0.5 * size
    }
    
    var left: Double {
        return 0
    }
    
    var right: Double {
        return width
    }
    
    var insideLeft: Double {
        return thinLineWidth
    }
    
    private var outside: Path {
        
        let builder = Path.builder
            .move(to: Point())
            .addLine(to: Point(x: insideLeft, y: 0))
            .addLine(to: Point(x: insideLeft, y: bodyTop))
            .addCurve(
                to: Point(x: width, y: bodyTop),
                control1: Point(x: insideLeft, y: bodyTop),
                control2: Point(x: width - 0.25 * size, y: bodyTop - 0.25 * size)
            )
            .addCurve(
                to: Point(x: insideLeft, y: height),
                control1: Point(x: insideLeft + width + 0.5 * size, y: bodyTop + 0.618 * size),
                control2: Point(x: insideLeft + 0.25 * size, y: height - 0.66 * size)
            )
            .addLine(to: Point(x: left, y: height))
            .close()
        
        return builder.build()
    }
    
    private var inside: Path {
        
        let builder = Path.builder
            .move(to: Point(x: insideLeft, y: height - bowlLineWidthBottom))
            .addCurve(
                to: Point(x: width - bowlLineWidthStress, y: bodyTop + 0.75 * bowlLineWidthStress),
                control1: Point(
                    x: 0.5 * bowlLineWidthBottom,
                    y: height - 1.25 * bowlLineWidthBottom
                ),
                control2: Point(
                    x: width - 0.5 * bowlLineWidthBottom,
                    y: bodyTop + 1.333 * bowlLineWidthStress
                )
            )
            .addCurve(
                to: Point(x: insideLeft, y: bodyTop + bowlLineWidthTop),
                control1: Point(
                    x: width - 1.309 * bowlLineWidthStress,
                    y: bodyTop + 0.309 * bowlLineWidthStress
                ),
                control2: Point(x: insideLeft, y: bodyTop + bowlLineWidthTop)
            )
            .close()
        
        return builder.build()
    }
    
    override var centerReference: Point {
        return Point(x: 0.5 * width, y: tallColumnHeight)
    }
    
    public override var path: Path {
        return outside + inside
    }
}
