//
//  MainView.swift
//  TappxUIKitExample
//
//  Created by Sara Diaz Perez on 6/5/25.
//

import UIKit

class MainView: UIViewController {
    @IBOutlet weak var versionText: UILabel!
    @IBOutlet weak var bannerLabel: UILabel!
    @IBOutlet weak var MRECLabel: UILabel!
    @IBOutlet weak var interstitialLabel: UILabel!
    @IBOutlet weak var rewardedLabel: UILabel!
    @IBOutlet var mainView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        configNavigationBar()
    }

    private func configNavigationBar() {
        let titleView = UIView()
        
        let imageView = UIImageView(image: UIImage(named: "logo tappx"))
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        let label = UILabel()
        label.text = "app_name".localized
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
            imageView.widthAnchor.constraint(equalToConstant: 30),
            imageView.heightAnchor.constraint(equalToConstant: 30),
            
            stackView.centerYAnchor.constraint(equalTo: titleView.centerYAnchor),
            stackView.centerXAnchor.constraint(equalTo: titleView.centerXAnchor),
            stackView.leadingAnchor.constraint(greaterThanOrEqualTo: titleView.leadingAnchor),
            stackView.trailingAnchor.constraint(lessThanOrEqualTo: titleView.trailingAnchor)
        ])
        
        self.navigationItem.titleView = titleView
        navigationItem.backButtonTitle = "empty".localized
    }
    
    private func setupView() {
        bannerLabel.text = "button.banner".localized
        bannerLabel.font = UIFont.bodyFont()
        bannerLabel.textColor = ColorTheme.primaryVariant
       
        MRECLabel.text = "button.MREC".localized
        MRECLabel.font = UIFont.bodyFont()
        MRECLabel.textColor = ColorTheme.primaryVariant
        
        interstitialLabel.text = "button.interstitial".localized
        interstitialLabel.font = UIFont.bodyFont()
        interstitialLabel.textColor = ColorTheme.primaryVariant
        
        rewardedLabel.text = "button.rewarded".localized
        rewardedLabel.font = UIFont.bodyFont()
        rewardedLabel.textColor = ColorTheme.primaryVariant
        
        versionText.text = "text.version".localized + "4.0"
        versionText.font = UIFont.secondFont()
        versionText.textColor = ColorTheme.primaryVariant
        
        mainView.backgroundColor = ColorTheme.secondary
    }
    
    @IBAction func bannerAction(_ sender: Any) {
        let storyboard = UIStoryboard(name: "navigation.name.banner".localized, bundle: nil)
        if let vc = storyboard.instantiateViewController(identifier: "navigation.id.banner".localized) as? BannerView {
            vc.viewType = .banner
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @IBAction func MRECAction(_ sender: Any) {
        let storyboard = UIStoryboard(name: "navigation.name.banner".localized, bundle: nil)
        if let vc = storyboard.instantiateViewController(identifier: "navigation.id.banner".localized) as? BannerView {
            vc.viewType = .mrec
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @IBAction func interstitialAction(_ sender: Any) {
        let storyboard = UIStoryboard(name: "navigation.name.fullScreen".localized, bundle: nil)
        if let vc = storyboard.instantiateViewController(identifier: "navigation.id.fullScreen".localized) as? FullScreenView {
            vc.viewType = .interstitial
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @IBAction func rewardedAction(_ sender: Any) {
        let storyboard = UIStoryboard(name: "navigation.name.fullScreen".localized, bundle: nil)
        if let vc = storyboard.instantiateViewController(identifier: "navigation.id.fullScreen".localized) as? FullScreenView {
            vc.viewType = .rewarded
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    
}
