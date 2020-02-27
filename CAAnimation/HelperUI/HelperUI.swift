//
//  HelperUI.swift
//  CAAnimation
//
//  Created by 周旗 on 2020/2/25.
//  Copyright © 2020 ZQMAC. All rights reserved.
//

import UIKit

var layers = [CAShapeLayer]()

extension UIView{
    
    /// 制作曲线动画
    /// - Parameters:
    ///   - imageName: 传入图片名称
    ///   - delay: 传入动画延迟时间
    func curveAnimation(imageName : String, delay :TimeInterval) {
        //1 .画出贝塞尔曲线（贝塞尔曲线指多个点连接可以形成任意曲线）
        
        let path = UIBezierPath()
        
        //设置动画开始的起始点
        let beginPoint = CGPoint(x: bounds.midX, y: bounds.midY)
        
        //随机控制点
        let a : CGFloat = 2
        let b : CGFloat = 1.5
        let c : CGFloat = 3
        let offset1 = [a, b, c]
        
        let cXOffset = offset1.randomElement()!*bounds.maxX
        let cYOffset = offset1.randomElement()!*bounds.maxY
        
        //随机终点end
        let d : CGFloat = 1.5
        let e : CGFloat = 0.8
        let f : CGFloat = 1.0
        
        let j : CGFloat = 2.5
        let h : CGFloat = 3
        let k : CGFloat = 2
        
        let offset2 = [d, e, f]
        let offset3 = [j, h, k]
        let eXOffset = offset2.randomElement()!*bounds.maxX
        let eYOffset = offset3.randomElement()!*bounds.maxY
        
        //终点坐标
        //此处因为以空间中心为坐标点，相对于整个屏幕坐标系在第四象限，都为负数 所以减 （个人理解不对请纠正）
        let endPoint = CGPoint(x: beginPoint.x - eXOffset, y:beginPoint.y - eYOffset)
        let controllerPoint = CGPoint(x: beginPoint.x - cXOffset, y: beginPoint.y - cYOffset)
        
        path.move(to: beginPoint)
        path.addQuadCurve(to: endPoint, controlPoint: controllerPoint)
        
        //2. 设置动画组的相关属性
        let group = CAAnimationGroup()
        group.duration = 4 //动画周期
        group.repeatCount = .infinity //无限循环
        group.isRemovedOnCompletion = false //执行完成不移除
        group.fillMode = .forwards //动画向前，default
        group.timingFunction = CAMediaTimingFunction(name: .linear) //线性模式
        group.beginTime = CACurrentMediaTime() + delay //设置延时时间
        
        //设置关键帧
        let pathAnimation = CAKeyframeAnimation(keyPath: "position") //路径动画
        pathAnimation.path = path.cgPath
        
        let rotateAnimation = CAKeyframeAnimation(keyPath: "transform.rotation")//角度旋转
        rotateAnimation.values = [0, .pi / 2.0, .pi / 1.0]
        
        let alphaAnimation = CAKeyframeAnimation(keyPath: "opacity") //透明度
        alphaAnimation.values = [0, 0.3, 1, 0.3, 0]
        
        let scaleAnimation = CAKeyframeAnimation(keyPath: "scale") //缩放
        scaleAnimation.values = [1.0, 1.8, 2]
        
        group.animations = [pathAnimation, rotateAnimation, alphaAnimation, scaleAnimation]
        
        //3. 设置layer动画层CAShapLayer
        let layer = CAShapeLayer()
        layer.opacity = 0 //透明度
        layer.contents = UIImage(named: imageName)?.cgImage
        layer.frame = CGRect(origin: beginPoint, size: CGSize(width: 10.0, height: 10.0))
        layer.add(group, forKey: nil)
        self.layer.addSublayer(layer)
        
        //此处记录layers的目的是为了方便重置函数
        layers.append(layer)
    }
    
    /// 动画重置 ， 防止tableView的cell重用机制 ，每次重置动画

    func resetAnimation() {
        for layer in layers {
            layer.removeFromSuperlayer()
        }
        self.layer.removeAllAnimations()
    }
    
}
