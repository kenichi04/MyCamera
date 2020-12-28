//
//  ViewController.swift
//  MyCamera
//
//  Created by takashimakenichi on 2020/12/28.
//  Copyright © 2020 takashimakenichi. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    @IBOutlet weak var pictureImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func cameraButtonAction(_ sender: Any) {
        // カメラが利用可能かチェック
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            print("カメラは利用できます")
            
            // imagePickerControllerインスタンス生成
            let imagePickerController = UIImagePickerController()
            // sourceTypeにカメラを設定 / 写真の取得先
            imagePickerController.sourceType = .camera
            // delegate設定
            imagePickerController.delegate = self
            // モーダルビューで表示
            present(imagePickerController, animated: true, completion: nil)
            
        } else {
            print("カメラは利用できません")
        }
    }
    
    @IBAction func shareButtonAction(_ sender: Any) {
        // 表示画像をアンラップして画像取得
        if let shareImage = pictureImage.image {
            // activityViewControllerに渡す配列を作成
            let shareItems = [shareImage]
            // activityViewControllerに画像を渡しインスタンス生成
            let controller = UIActivityViewController(activityItems: shareItems, applicationActivities: nil)
            // iPadが落ちてしまう対策
            controller.popoverPresentationController?.sourceView = view
            // 表示
            present(controller, animated: true, completion: nil)
        }
    }
    
    // 撮影が終わった際によばれるdelegateメソッド
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        // 撮影した画像をpictureImage変数に代入
        pictureImage.image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        // モーダルビューを閉じる（今回はカメラ画面）/ present()メソッドで開いていた画面
        dismiss(animated: true, completion: nil)
    }
    
    
}

