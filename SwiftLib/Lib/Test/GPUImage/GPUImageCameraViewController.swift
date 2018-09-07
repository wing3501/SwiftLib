//
//  GPUImageCameraViewController.swift
//  SwiftLib
//
//  Created by 申屠云飞 on 2017/12/12.
//  Copyright © 2017年 申屠云飞. All rights reserved.
//

import UIKit
import GPUImage
import AVKit

class GPUImageCameraViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    fileprivate lazy var camera : GPUImageStillCamera = GPUImageStillCamera(sessionPreset: AVCaptureSession.Preset.high.rawValue, cameraPosition: .front)
    fileprivate lazy var filter = GPUImageBrightnessFilter()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // 1.创建GPUImageStillCamera
        camera.outputImageOrientation = .portrait
        
        // 2.创建滤镜(美白/曝光)
//         let filter = GPUImageBrightnessFilter()
        filter.brightness = 0.7
        camera.addTarget(filter)
        
        // 3.创建GPUImageView,用于显示实时画面
        let showView = GPUImageView(frame: view.bounds)
        view.insertSubview(showView, at: 0)
        filter.addTarget(showView)
        
        // 4.开始捕捉画面
        camera.startCapture()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func takePhoto(_ sender: Any) {
        camera.capturePhotoAsImageProcessedUp(toFilter: filter, withCompletionHandler: { (image, error) in
            UIImageWriteToSavedPhotosAlbum(image!, nil, nil, nil)
            self.imageView.image = image
            
            self.camera.stopCapture()
        })
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
