//
//  CustomAnswerView.swift
//  QuizView
//
//  Created by Taof on 6/24/20.
//  Copyright © 2020 taoquynh. All rights reserved.
//

import UIKit

class CustomAnswerView: UIView {
    
    let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.brown
        return view
    }()
    
    let answerLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 18)
        //        label.backgroundColor = UIColor(red: 1.00, green: 1.00, blue: 0.90, alpha: 1.00)
        return label
    }()
    
    var answer: Answer? {
        didSet {
            if let answer = answer {
                answerLabel.text = answer.answer
                
                if answer.isSelected {
                    answerLabel.backgroundColor = UIColor.red
                } else {
                    answerLabel.backgroundColor = UIColor.white
                }
            }
        }
    }
    
    var passAction: (() -> Void)?
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(pressAnswer))
        answerLabel.isUserInteractionEnabled = true
        answerLabel.addGestureRecognizer(gesture)
    }
    
    @objc func pressAnswer(){
        print("tapped")
        passAction?()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupLayout(){
        self.addSubview(containerView)
        containerView.addSubview(answerLabel)
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
            containerView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
            containerView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8),
            containerView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8),
            
            answerLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 4),
            answerLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 4),
            answerLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -4),
            answerLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -4)
            ])
    }
}
