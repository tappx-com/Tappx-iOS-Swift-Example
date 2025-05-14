//
//  MRECAd.swift
//  TappxUIKitExample
//
//  Created by Sara Diaz Perez on 6/5/25.
//

import UIKit
import TappxFramework

class MRECAd: BannerAd {
    private var tappxMREC: TappxBannerView?
    
    override func loadBanner(size: TappxBannerSize = .size300x250, position: TappxBannerPosition = .bottom) {
        removeBanner()
        
        self.tappxMREC = TappxBannerView(delegate: self, size: size, position: position)
    
        self.delegate?.addTappxBannerViewToView(bannerView: self.tappxMREC!)
        
        if let rootViewController = self.delegate?.rootViewController() {
            self.tappxMREC?.setRootViewController(rootViewController: rootViewController)
        }
        
        self.tappxMREC?.load()
    }
    
    override func removeBanner() {
        if let mrec = tappxMREC {
            mrec.removeBanner()
            mrec.removeFromSuperview()
            tappxMREC = nil
        }
    }
}

extension MRECAd {
    override func tappxBannerViewDidFinishLoad(bannerView: TappxBannerView) {
        updateLog(message: "MREC".localized + "status.loaded".localized)
        self.delegate?.bannerDidLoad(bannerAd: self)
    }
    
    override func tappxBannerViewDidFail(bannerView: TappxBannerView, error: TappxErrorAd) {
        let errorMessage = TappxErrorManager.message(for: error.code)
        updateLog(message: "MREC".localized + "status.failed".localized + errorMessage)
        self.delegate?.bannerDidFailToLoad(bannerAd: self, error: error)
    }
    
    override func tappxBannerViewDidPress(bannerView: TappxBannerView) {
        updateLog(message: "MREC".localized + "status.pressed".localized)
        self.delegate?.bannerDidClick(bannerAd: self)
    }
    
    override func tappxBannerViewDidClose(bannerView: TappxBannerView) {
        updateLog(message: "MREC".localized + "status.closed".localized)
        self.delegate?.bannerDidClose(bannerAd: self)
    }
}
