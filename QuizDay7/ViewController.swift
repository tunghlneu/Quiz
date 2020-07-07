//
//  ViewController.swift
//  QuizView
//
//  Created by Taof on 6/24/20.
//  Copyright © 2020 taoquynh. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let image = UIImage(named: "quiz")
    let imageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    var timer: Timer!
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 0.98, green: 0.87, blue: 0.14, alpha: 1.00)
        setupImage()
        
        timer = Timer.scheduledTimer(withTimeInterval: 3, repeats: false, block: { (_) in
            let quizVC = QuizViewController()
            quizVC.modalPresentationStyle = .fullScreen
            self.present(quizVC, animated: true) {
                self.timer.invalidate()
            }
        })
    }
    
    func setupImage() {
        view.addSubview(imageView)
        imageView.image = image
        let widthScreen = view.bounds.width
        let widthImage = image?.size.width ?? 1
        let heightImage = image?.size.height ?? 1
        
        imageView.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: (widthScreen*heightImage)/widthImage)
        imageView.center = view.center
    }
}

