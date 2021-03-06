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
    
    // 遷移先の画面に渡す画像を格納
    var captureImage: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func cameraButtonAction(_ sender: Any) {
        // アラートダイアログでカメラかフォトライブラリーか選択できるようにする
        let alertController = UIAlertController(title: "確認", message: "選択してください", preferredStyle: .actionSheet)
        
        // カメラが利用可能かチェック
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            // カメラの選択肢
            let cameraAction = UIAlertAction(title: "カメラ", style: .default, handler: { (action) in
                // カメラ起動（選択後の処理）
                let imagePickerController = UIImagePickerController()
                imagePickerController.sourceType = .camera
                imagePickerController.delegate = self
                self.present(imagePickerController, animated: true, completion: nil)
            })
            alertController.addAction(cameraAction)
        }
        
        // フォトライブラリーが利用可能かチェック
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            // フォトライブラリーの選択肢
            let photoLibraryAction = UIAlertAction(title: "フォトライブラリー", style: .default, handler: { (action) in
                //フォトライブラリー起動（選択後の処理）
                let imagePickerController = UIImagePickerController()
                imagePickerController.sourceType = .photoLibrary
                imagePickerController.delegate = self
                self.present(imagePickerController, animated: true, completion: nil)
            })
            alertController.addAction(photoLibraryAction)
        }
        

        // キャンセルの選択肢
        let cancelAction = UIAlertAction(title: "キャンセル", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        // iPadで落ちてしまう対策
        alertController.popoverPresentationController?.sourceView = view
        // 選択肢を表示
        present(alertController, animated: true, completion: nil)
        
    }
    
    /*
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
    */
    
    // 撮影が終わった際によばれるdelegateメソッド
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        // 撮影した画像をpictureImage変数に代入
//        pictureImage.image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        // モーダルビューを閉じる（今回はカメラ画面）/ present()メソッドで開いていた画面
//        dismiss(animated: true, completion: nil)
        
        // 撮影した画像を格納
        captureImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        // モーダルを閉じ、画面遷移する
        dismiss(animated: true, completion: {
            // エフェクト画面に遷移
            self.performSegue(withIdentifier: "showEffectView", sender: nil)
        })
    }
    
    // segueによる遷移時に呼ばれる
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // 遷移先のviewControllerのインスタンスを格納
        if let nextViewController = segue.destination as? EffectViewController {
            // 遷移先のoriginalImage変数に代入
            nextViewController.originalImage = captureImage
        }
    }
    
    
}

