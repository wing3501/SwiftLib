//
//  WaterfallViewController.swift
//  SwiftLib
//  测试瀑布流
//  Created by 申屠云飞 on 2017/12/11.
//  Copyright © 2017年 申屠云飞. All rights reserved.
//

import UIKit

private let kContentCellID = "kContentCellID"

class WaterfallViewController: UIViewController {

    fileprivate lazy var collectionView : UICollectionView = {
        let layout = WaterfallLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        
        layout.dataSource = self
        
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.dataSource = self
        
        return collectionView
    }()
    
    fileprivate lazy var cellCount : Int = 30
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //测试瀑布流
        view.addSubview(collectionView)
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: kContentCellID)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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



extension WaterfallViewController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cellCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kContentCellID, for: indexPath)
        
        cell.backgroundColor = UIColor.randomColor()
        if indexPath.item == cellCount - 1 {
            cellCount += 30
            collectionView.reloadData()
        }
        
        return cell
    }
}

extension WaterfallViewController : WaterfallLayoutDataSource {
    func waterfallLayout(_ layout: WaterfallLayout, indexPath: IndexPath) -> CGFloat {
        return CGFloat(arc4random_uniform(150) + 100)
    }
    
    func numberOfColsInWaterfallLayout(_ waterfall: WaterfallLayout) -> Int {
        return 3
    }
}
