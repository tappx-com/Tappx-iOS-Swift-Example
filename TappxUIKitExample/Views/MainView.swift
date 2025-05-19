//
//  MainView.swift
//  TappxUIKitExample
//
//  Created by Sara Diaz Perez on 6/5/25.
//

import UIKit
import TappxFramework

class MainView: BaseView {
    @IBOutlet weak var headerBackgroundView: UIView!
    @IBOutlet weak var versionText: UILabel!
    
    @IBOutlet weak var bannerImage: UIImageView!
    @IBOutlet weak var bannerLabel: UILabel!
   
    @IBOutlet weak var MRECImage: UIImageView!
    @IBOutlet weak var MRECLabel: UILabel!
    
    @IBOutlet weak var interstitialImage: UIImageView!
    @IBOutlet weak var interstitialLabel: UILabel!
    
    @IBOutlet weak var rewardedImage: UIImageView!
    @IBOutlet weak var rewardedLabel: UILabel!
    @IBOutlet var mainView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        headerBackgroundView.backgroundColor = ColorTheme.primary
        
        imageShadow(bannerImage)
        bannerLabel.text = "button.banner".localized
        bannerLabel.font = UIFont.bodyFont()
        bannerLabel.textColor = ColorTheme.primaryVariant
       
        imageShadow(MRECImage)
        MRECLabel.text = "button.MREC".localized
        MRECLabel.font = UIFont.bodyFont()
        MRECLabel.textColor = ColorTheme.primaryVariant
        
        imageShadow(interstitialImage)
        interstitialLabel.text = "button.interstitial".localized
        interstitialLabel.font = UIFont.bodyFont()
        interstitialLabel.textColor = ColorTheme.primaryVariant
        
        imageShadow(rewardedImage)
        rewardedLabel.text = "button.rewarded".localized
        rewardedLabel.font = UIFont.bodyFont()
        rewardedLabel.textColor = ColorTheme.primaryVariant
        
        versionText.text = "\("text.version".localized) \(TappxFramework.sdkVersion())"
        versionText.font = UIFont.secondFont()
        
        mainView.backgroundColor = ColorTheme.secondary
    }
    
    private func imageShadow(_ image: UIImageView) {
        image.layer.shadowColor = UIColor.black.cgColor
        image.layer.shadowOpacity = 0.3
        image.layer.shadowOffset = CGSize(width: 0, height: 1)
        image.layer.shadowRadius = 2
        image.layer.masksToBounds = false
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
