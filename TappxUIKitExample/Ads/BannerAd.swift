//
//  BannerAd.swift
//  TappxUIKitExample
//
//  Created by Sara Diaz Perez on 6/5/25.
//

import UIKit
import TappxFramework

protocol BannerAdDelegate: AnyObject {
    func addTappxBannerViewToView(bannerView: UIView)
    func rootViewController() -> UIViewController
    func updateLog(message: String)
    
    func bannerDidLoad(bannerAd: BannerAd)
    func bannerDidFailToLoad(bannerAd: BannerAd, error: Error)
    func bannerDidClick(bannerAd: BannerAd)
    func bannerDidClose(bannerAd: BannerAd)
}


class BannerAd: NSObject {
    private var bannerAdd: TappxBannerView?
    
    weak var delegate: BannerAdDelegate?
    
    init(delegate: BannerAdDelegate? = nil) {
        self.delegate = delegate
    }
    
    func loadBanner(size: TappxBannerSize = .smartBanner, position: TappxBannerPosition = .bottom) {
        removeBanner()
        
        self.bannerAdd = TappxBannerView(delegate: self, size: size, position: position)
    
        self.delegate?.addTappxBannerViewToView(bannerView: self.bannerAdd!)
        
        if let rootViewController = self.delegate?.rootViewController() {
            self.bannerAdd?.setRootViewController(rootViewController: rootViewController)
        }
        
        self.bannerAdd?.load()
    }
    
    func removeBanner() {
        if let banner = bannerAdd {
            banner.removeBanner()
            banner.removeFromSuperview()
            bannerAdd = nil
        }
    }
    
    func updateLog(message: String) {
        self.delegate?.updateLog(message: message)
    }
}


extension BannerAd: TappxBannerViewDelegate {
    func tappxBannerViewDidFinishLoad(bannerView: TappxBannerView) {
        updateLog(message: "banner".localized + "status.loaded".localized)
        self.delegate?.bannerDidLoad(bannerAd: self)
    }
    
    func tappxBannerViewDidFail(bannerView: TappxBannerView, error: TappxErrorAd) {
        let errorMessage = TappxErrorManager.message(for: error.code)
        updateLog(message: "banner".localized + "status.failed".localized + errorMessage)
        self.delegate?.bannerDidFailToLoad(bannerAd: self, error: error)
    }
    
    func tappxBannerViewDidPress(bannerView: TappxBannerView) {
        updateLog(message: "banner".localized + "status.pressed".localized)
        self.delegate?.bannerDidClick(bannerAd: self)
    }
    
    func tappxBannerViewDidClose(bannerView: TappxBannerView) {
        updateLog(message: "banner".localized + "status.closed".localized)
        self.delegate?.bannerDidClose(bannerAd: self)
    }
}
