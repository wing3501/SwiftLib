//
//  GPUImageViewController.swift
//  SwiftLib
//
//  Created by 申屠云飞 on 2017/12/12.
//  Copyright © 2017年 申屠云飞. All rights reserved.
//

import UIKit
import GPUImage

class GPUImageViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()


    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func blur(_ sender: Any) {
        // 1.获取修改的图片
        let sourceImage = UIImage(named: "test")!
        
        // 2.使用GPUImage高斯模糊效果
        // 2.1.如果是对图像进行处理GPUImagePicture
        let picProcess = GPUImagePicture(image: sourceImage)
        
        // 2.2.添加需要处理的滤镜
        let blurFilter = GPUImageGaussianBlurFilter()
        // 纹理
        blurFilter.texelSpacingMultiplier = 5
        blurFilter.blurRadiusInPixels = 5
        picProcess?.addTarget(blurFilter)
        
        // 2.3.处理图片
        blurFilter.useNextFrameForImageCapture()
        picProcess?.processImage()
        
        // 2.4.取出最新的图片
        let newImage = blurFilter.imageFromCurrentFramebuffer()
        
        // 3.显示最新的图片
        imageView.image = newImage
    }
    
    @IBAction func hese(_ sender: Any) {
        let heseFilter = GPUImageSepiaFilter()
        imageView.image = processImage(heseFilter)
    }
    
    @IBAction func katong(_ sender: Any) {
        let heseFilter = GPUImageToonFilter()
        imageView.image = processImage(heseFilter)
    }
    @IBAction func sumiao(_ sender: Any) {
        let heseFilter = GPUImageSketchFilter()
        imageView.image = processImage(heseFilter)
    }
    
    @IBAction func fudiao(_ sender: Any) {
        let heseFilter = GPUImageEmbossFilter()
        imageView.image = processImage(heseFilter)
    }
    
    private func processImage(_ filter : GPUImageFilter) -> UIImage? {
        let image = UIImage(named: "test")
        // 2.1.如果是对图像进行处理GPUImagePicture
        let picProcess = GPUImagePicture(image: image)
        
        // 2.2.添加需要处理的滤镜
        picProcess?.addTarget(filter)
        
        // 2.3.处理图片
        filter.useNextFrameForImageCapture()
        picProcess?.processImage()
        
        // 2.4.取出最新的图片
        return filter.imageFromCurrentFramebuffer()
    }
    
    @IBAction func meiyan(_ sender: Any) {
        let vc = GPUImageCameraViewController(nibName: nil, bundle: nil)
        present(vc, animated: true, completion: nil)
    }
    
    @IBAction func caiji(_ sender: Any) {
        let vc = GPUImageCollectViewController(nibName: nil, bundle: nil)
        present(vc, animated: true, completion: nil)
        
    }
}
