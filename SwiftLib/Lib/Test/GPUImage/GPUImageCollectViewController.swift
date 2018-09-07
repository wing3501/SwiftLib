//
//  GPUImageCollectViewController.swift
//  SwiftLib
//
//  Created by 申屠云飞 on 2017/12/12.
//  Copyright © 2017年 申屠云飞. All rights reserved.
//

import UIKit
import GPUImage

class GPUImageCollectViewController: UIViewController {

    fileprivate lazy var camera : GPUImageVideoCamera = GPUImageVideoCamera(sessionPreset: AVCaptureSession.Preset.vga640x480.rawValue, cameraPosition: .back)
    fileprivate lazy var filter = GPUImageBrightnessFilter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 1.添加滤镜
        camera.outputImageOrientation = .portrait
        camera.addTarget(filter)
        camera.delegate = self
        
        // 2.添加一个用于实时显示画面的GPUImageView
        let showView = GPUImageView(frame: view.bounds)
        view.addSubview(showView)
        filter.addTarget(showView)
        
        // 3.开始采集画面
        camera.startCapture()
    }

}

extension GPUImageCollectViewController : GPUImageVideoCameraDelegate {
    func willOutputSampleBuffer(_ sampleBuffer: CMSampleBuffer!) {
        print("采集到画面")
    }
}
