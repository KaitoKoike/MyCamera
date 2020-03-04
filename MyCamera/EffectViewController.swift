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
    
    
    // フィルタ名を列挙した配列を作成する
    let filterArray = ["CIPhotoEffectMono",
                       "CIPhotoEffectChrome",
                       "CIPhotoEffectFade",
                       "CIPhotoEffectInstant",
                       "CIPhotoEffectNoir",
                       "CIPhotoEffectProcess",
                       "CIPhotoEffectTonal",
                       "CIPhotoEffectTransfer",
                       "CISepiaTone"
    ]
    
    //どのフィルターを用いているのかを示すindex
    var filter_idx = 0
    
    @IBAction func effectButtonAction(_ sender: Any) {
        if let image = originalImage {
            //フィルター名を指定
            let filterName = filterArray[filter_idx]
            //filter_idxを次の数字に変更
            filter_idx += 1
            //配列の長さに収める
            filter_idx = filter_idx % filterArray.count
            
            //元々の画像の回転角度を取得
            let rotate = image.imageOrientation
            //UIImage形式の画像をCIImage形式に変換
            let inputImage = CIImage(image: image)
            
            // フィルターの種類を引数で指定された種類を指定してCIFilterのインスタンスを取得
            guard let effectFilter = CIFilter(name: filterName) else {
                return
            }
            
            //effectのパラメータを初期化
            effectFilter.setDefaults()
            //インスタンスにエフェクトする元画像を設定
            effectFilter.setValue(inputImage, forKey: kCIInputImageKey)
            //エフェクト後のCIImage形式の画像を取り出す
            guard let outputImage = effectFilter.outputImage else {
                return
            }
            //CIContextのインスタンスを取得
            let ciContext = CIContext(options: nil)
            
            // エフェクト後の画像をCIContext上に描画し，結果をcgImageとしてCGImage形式の画像を取得
            guard let cgImage = ciContext.createCGImage(outputImage, from: outputImage.extent) else {
                return
            }
            
            // エフェクト後の画像をDGImage形式からUIImage形式に変更．その際に回転角度を指定，そしてImageViewに表示
            effectImage.image = UIImage(cgImage: cgImage, scale: 1.0, orientation: rotate)
            

        }
    }
    
    @IBAction func shareButtonAction(_ sender: Any) {
        if let shareImage = effectImage.image?.resize() {
            let shareItems = [shareImage]
            
            let controller = UIActivityViewController(activityItems: shareItems, applicationActivities: nil)
            
            controller.popoverPresentationController?.sourceView = view
            
            present(controller,animated: true,completion: nil)
        }
    }
    
    @IBAction func closeButtonAction(_ sender: Any) {
        //画面を閉じて前の画面に戻る
        dismiss(animated: true, completion: nil)
    }
}
