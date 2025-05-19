//
//  BaseView.swift
//  TappxUIKitExample
//
//  Created by Sara on 19/5/25.
//

import Foundation

class BaseView: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configNavigationBar()
    }
    
    private func configNavigationBar() {
        let titleView = UIView()
        
        let imageView = UIImageView(image: UIImage(named: "logo tappx"))
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        let label = UILabel()
        label.text = "app.name".localized
        label.textColor = .white
        label.font = UIFont.headerFont()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        let stackView = UIStackView(arrangedSubviews: [imageView, label])
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        titleView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalToConstant: 45),
            imageView.heightAnchor.constraint(equalToConstant: 45),
            
            stackView.centerYAnchor.constraint(equalTo: titleView.centerYAnchor),
            stackView.centerXAnchor.constraint(equalTo: titleView.centerXAnchor),
            stackView.leadingAnchor.constraint(greaterThanOrEqualTo: titleView.leadingAnchor),
            stackView.trailingAnchor.constraint(lessThanOrEqualTo: titleView.trailingAnchor)
        ])
        
        self.navigationItem.titleView = titleView
    }
    
}
