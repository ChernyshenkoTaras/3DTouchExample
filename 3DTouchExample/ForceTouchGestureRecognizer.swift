//
//  ForceTouchGestureRecognizer.swift
//  3DTouchExample
//
//  Created by Taras Chernyshenko on 6/30/17.
//  Copyright © 2017 Taras Chernyshenko. All rights reserved.
//

import UIKit.UIGestureRecognizerSubclass

class ForceTouchGestureRecognizer: UIGestureRecognizer {
    
    var forceValue: CGFloat = 0
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent) {
        super.touchesBegan(touches, with: event)
        state = .began
        handleForceWithTouches(touches: touches)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent) {
        super.touchesMoved(touches, with: event)
        state = .changed
        handleForceWithTouches(touches: touches)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent) {
        super.touchesEnded(touches, with: event)
        state = .ended
        handleForceWithTouches(touches: touches)
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent) {
        super.touchesCancelled(touches, with: event)
        state = .cancelled
        handleForceWithTouches(touches: touches)
    }
    
    func handleForceWithTouches(touches: Set<UITouch>) {
        if touches.count != 1 {
            state = .failed
            return
        }
        
        guard let touch = touches.first else {
            state = .failed
            return
        }
        forceValue = touch.force
    }
}
