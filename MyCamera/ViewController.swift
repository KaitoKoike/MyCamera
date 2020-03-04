//
//  ViewController.swift
//  MyCamera
//
//  Created by 小池開人 on 2020/03/03.
//  Copyright © 2020 KKid. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBOutlet weak var pictureImage: UIImageView!
    
    @IBAction func cameraButtonAction(_ sender: Any) {
        //カメラかライブラリーかを選択するポップを表示
        let alertController = UIAlertController(title: "確認", message: "選択してください", preferredStyle: .actionSheet)
        
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            // カメラを起動するための選択肢を定義
            let cameraAction = UIAlertAction(title: "カメラ", style: .default, handler: {(action) in
                //カメラを起動
                let imagePickerController = UIImagePickerController()
                imagePickerController.sourceType = .camera
                imagePickerController.delegate = self
                self.present(imagePickerController,animated: true,completion: nil)
            })
            alertController.addAction(cameraAction)
            
        }
        
        
        // フォトライブラリーを起動する選択肢を定義
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            // ライブラリーを起動するための選択肢を定義
            let photoLibraryAction = UIAlertAction(title: "ライブラリー", style: .default, handler: {(action) in
                // ライブラリーを起動
                let imagePickerController = UIImagePickerController()
                imagePickerController.sourceType = .photoLibrary
                imagePickerController.delegate = self
                self.present(imagePickerController,animated: true,completion: nil)
                
            })
            alertController.addAction(photoLibraryAction)
        }
        
        
        // キャンセルの選択肢を定義
        let cancelAction = UIAlertAction(title: "キャンセル", style: .default, handler: nil)
        alertController.addAction(cancelAction)
        
        alertController.popoverPresentationController?.sourceView = view
        
        present(alertController,animated: true,completion: nil)
    }
    
    @IBAction func shareButtonAction(_ sender: Any) {
        if let shareImage = pictureImage.image?.resize() {
            //UIActivityViewControllerに渡す配列を作成
            let shareItems = [shareImage]
            // UIActivityViewControllerにシェアする画像を渡す
            let controller = UIActivityViewController(activityItems: shareItems, applicationActivities: nil)
            // ipadで落ちてしまう対策
            controller.popoverPresentationController?.sourceView = view
            // UIActivityViewControllerを表示
            present(controller,animated: true,completion: nil)
        }
    }
    
    //写真を撮った後に呼ばれるdelegateメソッド
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        pictureImage.image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        dismiss(animated: true, completion: nil)
    }
}

