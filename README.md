# ZQCurveAnimation
ZQCurveAnimation 一个适用于Swift、OC的扩展，类似于抖音音乐播放器，直播间小心心类似的贝塞尔曲线动画效果

![image](https://github.com/git-timor/ZQCurveAnimation/blob/master/CAAnimation/%E9%9F%B3%E7%AC%A6%E5%8A%A8%E7%94%BB.gif)

Usage：
```
discView.curveAnimation(imageName: "icon_home_musicnote1", delay: 0)
```

1 .画出贝塞尔曲线（贝塞尔曲线指多个点连接可以形成任意曲线）
```
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
```

 //2. 设置动画组的相关属性
 
 ```
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
  ```
  
  //3. 设置layer动画层CAShapLayer
  
 ```
 let layer = CAShapeLayer()
        layer.opacity = 0 //透明度
        layer.contents = UIImage(named: imageName)?.cgImage
        layer.frame = CGRect(origin: beginPoint, size: CGSize(width: 10.0, height: 10.0))
        layer.add(group, forKey: nil)
        self.layer.addSublayer(layer)
        
        //此处记录layers的目的是为了方便重置函数
        layers.append(layer)
 ```
