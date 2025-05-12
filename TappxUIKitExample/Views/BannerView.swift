//
//  BannerView.swift
//  TappxUIKitExample
//
//  Created by Sara Diaz Perez on 6/5/25.
//

import UIKit

// Vista para los anuncios de Banner y MREC
class BannerView: UIViewController {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var advertisementView: UIView!
    @IBOutlet weak var statusView: UIView!
    @IBOutlet weak var statusLabel: UILabel!
    
    @IBOutlet weak var statusInputView: UIView!
    @IBOutlet weak var statusInputText: UITextView!
    
    private var logLines = [String]()
    
    private lazy var bannerAd: BannerAd = {
        BannerAd(delegate: self)
    }()
    
    private lazy var mrecAd: MRECAd = {
        MRECAd(delegate: self)
    }()
    
    let maxLogLines = 1000
    var viewType: AdType = .banner
    var adSubType: AdSubType = .smart
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.titleView = (self.navigationController?.viewControllers.first as? MainView)?.navigationItem.titleView
        configureView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        loadAds()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        cleanupAds()
    }
    
    private func configureView() {
        switch viewType {
        case .banner:
            setBannerView()
        case .mrec:
            setMRECView()
        default:
            break
        }
        
        titleLabel.textColor = ColorTheme.primary
        titleLabel.font = UIFont.titleFont()
        statusView.backgroundColor = ColorTheme.secondary
        configureStatus()
    }
    
    private func configureStatus() {
        statusLabel.font = UIFont.bodyFont()
       
        statusInputView.backgroundColor = ColorTheme.scrollBackground
        statusInputView.layer.cornerRadius = 8
        configureTextStatus()
    }
    
    private func configureTextStatus() {
        statusInputText.font = UIFont.bodyFont()
        statusInputText.textColor = ColorTheme.secondaryVariant
        
    }
    
    func setBannerView() {
        titleLabel.text = "banner".localized
    }
    
    func setMRECView() {
        titleLabel.text = "MREC".localized
    }
    
    private func loadAds() {
        switch viewType {
        case .banner:
            bannerAd.loadBanner()
        case .mrec:
            mrecAd.loadBanner()
        default:
            break
        }
    }
    
    private func cleanupAds() {
        switch viewType {
        case .banner:
            bannerAd.removeBanner()
        case .mrec:
            mrecAd.removeBanner()
        default:
            break
        }
    }
    
}

extension BannerView: BannerAdDelegate {
    func updateLog(message: String) {
        statusInputText.text.insert(contentsOf: "\(message)\n", at: statusInputText.text.startIndex)
    }
    
    func bannerDidLoad(bannerAd: BannerAd) {
        
    }
    
    func bannerDidFailToLoad(bannerAd: BannerAd, error: any Error) {
        
    }
    
    func bannerDidClick(bannerAd: BannerAd) {
        
    }
    
    func bannerDidClose(bannerAd: BannerAd) {
        
    }
    
    func rootViewController() -> UIViewController {
        return self
    }
    
    
    func addTappxBannerViewToView(bannerView: UIView) {
        bannerView.translatesAutoresizingMaskIntoConstraints = false;
        self.advertisementView.addSubview(bannerView)
        self.advertisementView.addConstraints(
            [
                NSLayoutConstraint.init(item: bannerView, attribute: .centerY, relatedBy: .equal, toItem: self.advertisementView, attribute: .centerY, multiplier: 1, constant: 0),
                NSLayoutConstraint.init(item: bannerView, attribute: .centerX, relatedBy: .equal, toItem: self.advertisementView, attribute: .centerX, multiplier: 1, constant: 0)
            ]
        )
    }
}
