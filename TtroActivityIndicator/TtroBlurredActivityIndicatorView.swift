//
//  TtroActivityIndicatorView.swift
//  TtroActivityIndicator
//
//  Created by Farid on 2/22/17.
//  Copyright © 2017 ParsPay. All rights reserved.
//

import UIKit
import NVActivityIndicatorView
import PayWandBasicElements
import EasyPeasy

public class TtroBlurredActivityIndicatorView: UIView {
    var blurredViews = [APCustomBlurView]()
    var activityIndicator : TtroActivityIndicatorView!
    
    public convenience init(){
        self.init(frame: .zero)
        
        let n : Int = 4
        for i in 0...n {
            let blurView = APCustomBlurView(withRadius: 1)
            addSubview(blurView)
            let heightCoeff : CGFloat = 0.2*CGFloat(i)
            blurView <- [
                Center(),
                Height(*heightCoeff).like(self),
                Width().like(self)
            ]
        }
        
        let activityIndicator = TtroActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 50, height: 50), type: .ballPulse, color: UIColor.TtroColors.cyan.color, padding: 5)
        self.addSubview(activityIndicator)
        
    }
    
    public override init(frame : CGRect){
        super.init(frame: frame)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func stopAnimation() {
        activityIndicator.stopAnimation()
    }
    
    public func startAnimation() {
        activityIndicator.startAnimation()
    }
}

class TtroActivityIndicatorView: UIView {
    let delay : Double = 0.5
    var finished = false
    var activityViewer : NVActivityIndicatorView!
    convenience init(frame: CGRect, type: NVActivityIndicatorType?, color: UIColor?, padding:
        CGFloat?) {
        self.init(frame: frame)
        activityViewer = NVActivityIndicatorView(frame: frame, type: type, color: color, padding: padding)
        addSubview(activityViewer)
        activityViewer <- Edges()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func startAnimation() {
        finished = false
        Timer.scheduledTimer(timeInterval: delay, target: self, selector: #selector(self.delayedAnimation), userInfo: nil, repeats: false)
    }
    
    func delayedAnimation() {
        if !finished {
            activityViewer.startAnimating()
        }
    }
    
    func stopAnimation() {
        finished = true
        activityViewer.stopAnimating()
        UIView.animate(withDuration: 0.4, animations: {
            self.alpha = 0
        }, completion: {_ in
            self.removeFromSuperview()
            self.alpha = 1
        })
    }
}
