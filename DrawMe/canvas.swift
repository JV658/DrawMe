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
    var finishedColor = UIColor.black
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        let doubleTapGesture = UITapGestureRecognizer(target: self, action: #selector(doubleTabRecognizer))
        doubleTapGesture.numberOfTapsRequired = 2
//        doubleTapGesture.delaysTouchesBegan = true
        
        
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(longPressRecognizer))
        longPressGesture.minimumPressDuration = 1
        
        addGestureRecognizer(doubleTapGesture)
        // add long press to gesture recognizer list
        addGestureRecognizer(longPressGesture)
    }
    
    // create long press action
    @objc func longPressRecognizer(_ gestureRecognizer: UIGestureRecognizer){
        
        print(gestureRecognizer.location(in: self))
        finishedColor = UIColor.green
        setNeedsLayout()
    }

    @objc func doubleTabRecognizer(){
        finishedLines = []
        setNeedsDisplay()
    }
    
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
        finishedColor.setStroke()
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
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches {
            let key = NSValue(nonretainedObject: touch)
            currentLines.removeValue(forKey: key)
        }
        print("touche cancelled")
    }
}
