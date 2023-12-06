//
//  canvas.swift
//  DrawMe
//
//  Created by Cambrian on 2023-12-06.
//

import UIKit

class Canvas: UIView {
   
    var currentLine: Line?
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
        
        if let line = currentLine {
            // If there is a line currently being drawn, do it in red
            UIColor.red.setStroke()
            stroke(line)
        }
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first!
        
        let location = touch.location(in: self)
        
        currentLine = Line(begin: location, end: location)
                
        setNeedsDisplay()
        
        print(location)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        // get the touch event
        
        // the location of the touch event
        
        // update currentline to have the proper end point
        
        // move the line from currentline to finishedlines
        
        // redraw the view
    }
}
