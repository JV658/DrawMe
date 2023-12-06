//
//  canvas.swift
//  DrawMe
//
//  Created by Cambrian on 2023-12-06.
//

import UIKit

class Canvas: UIView {
   
    var currentLines: [NSValue: Line] = [:]
    var finishedLines: [Line] = []
    
    func stroke(_ line: Line) {
        let path = UIBezierPath()
        path.lineWidth = 10
        path.lineCapStyle = .round
        path.move(to: line.begin)
        path.addLine(to: line.end)
        path.stroke()
    }
    
    override func draw(_ rect: CGRect) {
        // Draw finished lines in black
        UIColor.black.setStroke()
        for line in finishedLines {
            stroke(line)
        }
        
        UIColor.red.setStroke()
        for (_, line) in currentLines {
            stroke(line)
        }
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches {
            let key = NSValue(nonretainedObject: touch)
            let location = touch.location(in: self)
            currentLines[key] = Line(begin: location, end: location)
        }
            
        setNeedsDisplay()
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches {
            let key = NSValue(nonretainedObject: touch)
            let location = touch.location(in: self)
            currentLines[key]?.end = location
        }

        setNeedsDisplay()
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches {
            let key = NSValue(nonretainedObject: touch)
            let location = touch.location(in: self)
            
            currentLines[key]?.end = location
            
            finishedLines.append(currentLines[key]!)
            
            currentLines.removeValue(forKey: key)
        }
        
        // redraw the view
        setNeedsDisplay()
    }
}
