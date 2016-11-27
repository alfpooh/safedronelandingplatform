//
//  UniButton.swift
//  based on ForethinkToolBox, created by Dr. Alf
//  Fiksu Kitchen Timer
//
//  Created by donghoon bae on 2016. 7. 1..
//  Copyright © 2016년 Forethink. All rights reserved.
//

import UIKit

@IBDesignable

// Code for making universal button design

class FtkToolBtn: UIButton {
    
    @IBInspectable var fillColor: UIColor = UIColor.green
    @IBInspectable var strokeColor: UIColor = UIColor.white
    @IBInspectable var iconScale: CGFloat = 1.0
    @IBInspectable var strokelineWidth: CGFloat = 0.8
    @IBInspectable var miterlimit: CGFloat = 4
    @IBInspectable var offsetX: CGFloat = 0
    @IBInspectable var offsetY: CGFloat = 0
    @IBInspectable var specialF: CGFloat = 1
    @IBInspectable var LineCapStyle: CGLineCap?
    @IBInspectable var AnimationSW: Bool = false
    
    
    
    
    override func draw(_ rect: CGRect) {
        //avoid 0 and minus for iconScale
        if iconScale <= 0 {
            iconScale = 0.01
        }
        
        let cordiW = bounds.width
        let cordiH = bounds.height
        
        // Drawing base circle(Gong!)
        let gongPath = UIBezierPath(ovalIn: rect)
        //scale
        gongPath.apply(CGAffineTransform(translationX: -cordiW/2,y: -cordiH/2))
        gongPath.apply(CGAffineTransform(scaleX: 0.9,y: 0.9))
        
        // back to center and offset
        gongPath.apply(CGAffineTransform(translationX: cordiW/2,y: cordiH/2))
        
        self.titleLabel?.textAlignment = .center
        gongPath.lineWidth = strokelineWidth
        fillColor.setFill()
        gongPath.fill()
        strokeColor.setStroke()
        //gongPath.stroke()
        
        
        
        if self.tag == 0 {
            
        } else if self.tag == 1 {
            // RESET or O button
            
            let arcCenter = CGPoint(x: cordiW/2, y: cordiH/2)
            let radius = ((bounds.width/2) * 0.4) * iconScale
            //create the path
            
            let circlePath : UIBezierPath = UIBezierPath(arcCenter: arcCenter, radius:
                CGFloat(radius), startAngle: 0, endAngle: 8, clockwise: true)
            
            //set the stroke color
            strokeColor.setStroke()
            //set offset
            circlePath.apply(CGAffineTransform(translationX: offsetX, y: offsetY))
            
            if specialF > 0 {
                strokeColor.setFill()
                circlePath.fill()
            }
            
            //draw the stroke
            circlePath.lineWidth = strokelineWidth
            circlePath.stroke()
            
            //animation
            if AnimationSW == true {
                UIView.animate(withDuration: 3, animations: {
                    circlePath.apply(CGAffineTransform(translationX: 55, y: 55))
                })
            }
            
            
        } else if self.tag == 2 {
            //MINUS button
            
            let minusWidth: CGFloat = min(cordiW, cordiH) * 0.7
            
            //create the path
            let minusPath = UIBezierPath()
            
            //set the path's line width to the height of the stroke
            minusPath.lineWidth = strokelineWidth
            
            //move the initial point of the path
            //to the start of the horizontal stroke
            minusPath.move(to: CGPoint(
                x:(cordiW/2 - (minusWidth/2 * iconScale) + 0.5),
                y:cordiH/2 + 0.5))
            
            //add a point to the path at the end of the stroke
            minusPath.addLine(to: CGPoint(
                x:(cordiW/2 + (minusWidth/2 * iconScale) + 0.5),
                y:cordiH/2 + 0.5))
            //set o center
            minusPath.apply(CGAffineTransform(translationX: -cordiW/2,y: -cordiH/2))
            
            // use special for rotating
            minusPath.apply(CGAffineTransform(rotationAngle: specialF))
            
            //set back
            minusPath.apply(CGAffineTransform(translationX: (cordiW/2)+offsetX,y: (cordiH/2)+offsetY))
            
            //set the stroke color
            strokeColor.setStroke()
            //.lineCapStyle .Butt .Round .Square
            minusPath.lineCapStyle = .round
            //draw the stroke
            minusPath.stroke()
        }
        else if self.tag == 3 {
            //PLUS Button
            let mfactor: CGFloat = (min(cordiW, cordiH))
            //create the path
            let plusPath = UIBezierPath()
            //set the path's line width to the height of the stroke
            plusPath.lineWidth = strokelineWidth
            
            let strokePoneX: CGFloat = (cordiW/2)-mfactor
            let strokePtwoX: CGFloat = (cordiW/2)+mfactor
            let strokePoneY: CGFloat = (cordiH/2)+0.5
            //move the initial point of the path
            //to the start of the horizontal stroke
            plusPath.move(to: CGPoint(
                x:strokePoneX,
                y:strokePoneY))
            
            //add a point to the path at the end of the stroke
            plusPath.addLine(to: CGPoint(
                x:strokePtwoX,
                y:strokePoneY))
            
            //move the initial point of the path
            //to the start of the vertical stroke
            plusPath.move(to: CGPoint(x:strokePoneY,y:(strokePoneX-specialF)))
            
            //add a point to the path at the end of the stroke
            plusPath.addLine(to: CGPoint(x:strokePoneY,y:(strokePtwoX+specialF)))
            
            // scale
            plusPath.apply(CGAffineTransform(translationX: -cordiW/2,y: -cordiH/2))
            plusPath.apply(CGAffineTransform(scaleX: iconScale,y: iconScale))
            
            //set back and offset
            plusPath.apply(CGAffineTransform(translationX: (cordiW/2)+offsetX,y: (cordiH/2)+offsetY))
            
            //set the stroke color
            strokeColor.setStroke()
            plusPath.lineCapStyle = .round
            plusPath.lineWidth = strokelineWidth
            
            //draw the stroke
            plusPath.stroke()
            
        } else if self.tag == 4 {
            // \\\ 2 lines Pause
            if specialF == 0 {specialF = 10} //default
            //Drawing Arrow stem
            
            let minusWidth: CGFloat = min(cordiW, cordiH) * 0.7
            
            //create the path
            let minusPath = UIBezierPath()
            
            //set the path's line width to the height of the stroke
            minusPath.lineWidth = strokelineWidth
            
            //move the initial point of the path
            //Centr line: to the start of the horizontal stroke
            minusPath.move(to: CGPoint(
                x:(cordiW/2 - (minusWidth/2)),
                y:cordiH/2 + specialF))
            
            //Centr line:  add a point to the path at the end of the stroke
            minusPath.addLine(to: CGPoint(
                x:(cordiW/2 + (minusWidth/2)),
                y:cordiH/2 + specialF))
            
            
            //Centr line: to the start of the horizontal stroke
            minusPath.move(to: CGPoint(
                x:(cordiW/2 - (minusWidth/2)),
                y:cordiH/2))
            
            //Centr line:  add a point to the path at the end of the stroke
            minusPath.addLine(to: CGPoint(
                x:(cordiW/2 + (minusWidth/2)),
                y:cordiH/2 ))
            //scale
            minusPath.apply(CGAffineTransform(translationX: -cordiW/2,y: -cordiH/2))
            minusPath.apply(CGAffineTransform(scaleX: iconScale,y: iconScale))
            
            // use special for rotating
            minusPath.apply(CGAffineTransform(rotationAngle: CGFloat(M_PI/2)))
            
            // back to center and offset
            minusPath.apply(CGAffineTransform(translationX: (cordiW/2)+offsetX,y: (cordiH/2)+offsetY))
            
            
            
            //set the stroke color
            strokeColor.setStroke()
            minusPath.lineCapStyle = .round
            //draw the stroke
            minusPath.stroke()
        }  else if self.tag == 5 {
            //Draw Play icon
            
            let linePath = UIBezierPath()
            
            //Drawing Arrow head
            linePath.move(to: CGPoint(x:cordiW/3, y:(cordiH/3)))
            linePath.addLine(to: CGPoint(x:(cordiW*2)/3, y:cordiH/2))
            linePath.addLine(to: CGPoint(x:cordiW/3, y:(cordiH*2)/3))
            
            linePath.close()
            //What is miterLinit? tavmjong.free.fr/SVG/MITER_LIMIT/index.html
            linePath.miterLimit = 4
            // lineCapStyle can be .Round .Square .Butt
            linePath.lineCapStyle = .round
            linePath.usesEvenOddFillRule = true
            
            //scale
            linePath.apply(CGAffineTransform(translationX: -cordiW/2,y: -cordiH/2))
            linePath.apply(CGAffineTransform(scaleX: iconScale,y: iconScale))
            
            // use special for rotating
            //linePath.applyTransform(CGAffineTransformMakeRotation(CGFloat(M_PI/2)))
            
            // back to center and offset
            linePath.apply(CGAffineTransform(translationX: (cordiW/2)+offsetX,y: (cordiH/2)+offsetY))
            
            // fill arrow head
            strokeColor.setFill()
            linePath.fill()
            strokeColor.setStroke()
            linePath.stroke()
            
        }
            
        else if self.tag == 6 {
            //Draw Play icon
            
            let linePath = UIBezierPath()
            //make multiple offset
            //Drawing Arrow head first
            linePath.move(to: CGPoint(x:cordiW/3, y:(cordiH/3)))
            linePath.addLine(to: CGPoint(x:(cordiW*2)/3, y:cordiH/2))
            linePath.addLine(to: CGPoint(x:cordiW/3, y:(cordiH*2)/3))
            linePath.close()
            
            //Drawing Arrow head second
            linePath.move(to: CGPoint(x:(cordiW*2)/3, y:(cordiH/3)))
            linePath.addLine(to: CGPoint(x:cordiW, y:cordiH/2))
            linePath.addLine(to: CGPoint(x:(cordiW*2)/3, y:(cordiH*2)/3))
            linePath.close()
            
            
            //What is miterLinit? tavmjong.free.fr/SVG/MITER_LIMIT/index.html
            linePath.miterLimit = 4
            // lineCapStyle can be .Round .Square .Butt
            linePath.lineCapStyle = .round
            linePath.usesEvenOddFillRule = true
            
            //scale
            linePath.apply(CGAffineTransform(translationX: -cordiW/2,y: -cordiH/2))
            linePath.apply(CGAffineTransform(scaleX: iconScale,y: iconScale))
            
            // use special for rotating
            //linePath.applyTransform(CGAffineTransformMakeRotation(CGFloat(M_PI/2)))
            
            // back to center and offset
            linePath.apply(CGAffineTransform(translationX: (cordiW/2)+offsetX,y: (cordiH/2)+offsetY))
            
            // fill arrow head
            linePath.fill()
            strokeColor.setStroke()
            linePath.stroke()}
        
        else if self.tag == 8 {
            //Draw export icon

            /// Combined Shape
            let combinedShape = UIBezierPath()
            combinedShape.move(to: CGPoint(x: 9.75, y: 1.5))
            combinedShape.addLine(to: CGPoint(x: 36.75, y: 1.5))
            combinedShape.addLine(to: CGPoint(x: 36.75, y: 29))
            combinedShape.addLine(to: CGPoint(x: 30, y: 29))
            combinedShape.addLine(to: CGPoint(x: 30, y: 17.34))
            combinedShape.addLine(to: CGPoint(x: 30, y: 16.28))
            combinedShape.addLine(to: CGPoint(x: 23, y: 9.25))
            combinedShape.addLine(to: CGPoint(x: 21.5, y: 9.25))
            combinedShape.addLine(to: CGPoint(x: 9.75, y: 9.25))
            combinedShape.addLine(to: CGPoint(x: 9.75, y: 1.5))
            combinedShape.close()
            combinedShape.move(to: CGPoint(x: 8.25, y: 1.38))
            combinedShape.addLine(to: CGPoint(x: 8.25, y: 0))
            combinedShape.addLine(to: CGPoint(x: 38.25, y: 0))
            combinedShape.addLine(to: CGPoint(x: 38.25, y: 1.38))
            combinedShape.addLine(to: CGPoint(x: 38.25, y: 29.13))
            combinedShape.addLine(to: CGPoint(x: 38.25, y: 30.5))
            combinedShape.addLine(to: CGPoint(x: 30, y: 30.5))
            combinedShape.addLine(to: CGPoint(x: 30, y: 39.25))
            combinedShape.addLine(to: CGPoint(x: 28.5, y: 39.25))
            combinedShape.addLine(to: CGPoint(x: 1.5, y: 39.25))
            combinedShape.addLine(to: CGPoint(x: 0, y: 39.25))
            combinedShape.addLine(to: CGPoint(x: 0, y: 9.25))
            combinedShape.addLine(to: CGPoint(x: 1.5, y: 9.25))
            combinedShape.addLine(to: CGPoint(x: 8.25, y: 9.25))
            combinedShape.addLine(to: CGPoint(x: 8.25, y: 1.38))
            combinedShape.close()
            combinedShape.move(to: CGPoint(x: 21.95, y: 11.25))
            combinedShape.addLine(to: CGPoint(x: 2, y: 11.25))
            combinedShape.addLine(to: CGPoint(x: 2, y: 37.25))
            combinedShape.addLine(to: CGPoint(x: 28, y: 37.25))
            combinedShape.addLine(to: CGPoint(x: 28, y: 17.25))
            combinedShape.addLine(to: CGPoint(x: 21.95, y: 11.25))
            combinedShape.close()
            
            combinedShape.apply(CGAffineTransform(translationX: -20,y: -20))
            combinedShape.apply(CGAffineTransform(scaleX: ((cordiW*0.5)/cordiW),y: ((cordiH*0.5)/cordiH)))
            combinedShape.apply(CGAffineTransform(scaleX: iconScale,y: iconScale))
            combinedShape.apply(CGAffineTransform(translationX: (cordiW/2)+offsetX,y: (cordiH/2)+offsetY))
            
            strokeColor.setFill()
            combinedShape.fill()

            

        }
    }
}//end
