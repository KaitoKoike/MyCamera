//
//  EffectViewController.swift
//  MyCamera
//
//  Created by 小池開人 on 2020/03/04.
//  Copyright © 2020 KKid. All rights reserved.
//

import UIKit

class EffectViewController: UIViewController {

    
    //エフェクトの前画像
    // 前の画面より画像を設定
    var originalImage :UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //画面遷移時に元の画像を表示する
        effectImage.image = originalImage
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBOutlet weak var effectImage: UIImageView!
    
    @IBAction func effectButtonAction(_ sender: Any) {
    }
    
    @IBAction func shareButtonAction(_ sender: Any) {
    }
    
    @IBAction func closeButtonAction(_ sender: Any) {
        //画面を閉じて前の画面に戻る
        dismiss(animated: true, completion: nil)
    }
}
