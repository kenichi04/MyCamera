//
//  EffectViewController.swift
//  MyCamera
//
//  Created by takashimakenichi on 2020/12/28.
//  Copyright © 2020 takashimakenichi. All rights reserved.
//

import UIKit

class EffectViewController: UIViewController {
    
    @IBOutlet weak var effectImage: UIImageView!
    
    // エフェクト前画像、前の画面より画像を設定
    var originalImage: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
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

    @IBAction func effectButtonAction(_ sender: Any) {
        // エフェクト前画像をアンラップして取得
        if let image = originalImage {
            // フィルター名指定（今回はモノクロ指定）
            let filterName = "CIPhotoEffectMono"
            // 元の画像の回転角度を取得しておく/ 縦で撮影したのか、横で撮影したのかの情報 / 型変換の際に回転角度の情報は失われる
            let rotate = image.imageOrientation
            // UIImageからCIImageに変換
            let inputImage = CIImage(image: image)
            // CIFilterインスタンス生成（フィルター種別を引数で指定）
            guard let effectFilter = CIFilter(name: filterName) else {
                return
            }
            // エフェクトのパラメータ初期化
            effectFilter.setDefaults()
            // Filterインスタンスにエフェクトする元画像を指定
            effectFilter.setValue(inputImage, forKey: kCIInputImageKey)
            // エフェクト後のCIImage型の画像を取得
            guard let outputImage = effectFilter.outputImage else {
                return
            }
            // CIContextのインスタンス生成
            let ciContext = CIContext(options: nil)
            // エフェクト後の画像をCIContext上に描画し、結果をcgImageとしてCGImage型の画像を取得
            guard let cgImage = ciContext.createCGImage(outputImage, from: outputImage.extent) else {
                return
            }
            // エフェクト後の画像をCGImageからUIImageに変換、その際に取得しておいた回転角度を指定、ImageViewに表示
            effectImage.image = UIImage(cgImage: cgImage, scale: 1.0, orientation: rotate)
        }
    }
    
    @IBAction func shareButtonAction(_ sender: Any) {
        // 表示画像をアンラップして取得
        if let shareImage = effectImage.image {
            // activityControllerに渡す配列作成
            let shareItems = [shareImage]
            // activityControllerインスタンス生成
            let controller = UIActivityViewController(activityItems: shareItems, applicationActivities: nil)
            // shareButtonを取得
            let button = sender as! UIButton
            // iPadで落ちてしまう対策 -> actionActivityの生成場所をbuttonに設定する
            controller.popoverPresentationController?.sourceView = button
            // 表示
            present(controller, animated: true, completion: nil)
        }
        
    }
    
    @IBAction func closeButtonAction(_ sender: Any) {
        // 画面を閉じて前の画面に戻る
        dismiss(animated: true, completion: nil)
    }
}
