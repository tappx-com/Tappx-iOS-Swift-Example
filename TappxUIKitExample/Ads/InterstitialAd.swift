//
//  InterstitialAd.swift
//  TappxUIKitExample
//
//  Created by Sara Diaz Perez on 6/5/25.
//

import UIKit
import TappxFramework

protocol InterstitialAdDelegate: AnyObject {
    func interstitialDidLoad(_ interstitialAd: InterstitialAd)
    func interstitialDidFailToLoad(_ interstitialAd: InterstitialAd, error: Error)
    func interstitialDidShow(_ interstitialAd: InterstitialAd)
    func interstitialDidClose(_ interstitialAd: InterstitialAd)
    func interstitialDidPress(_ interstitialAd: InterstitialAd)
    func interstitialDidDisappear(_ interstitialAd: InterstitialAd)
    func updateInterstitialLog(message: String)
}

class InterstitialAd: NSObject {
    private var interstitialAd: TappxInterstitialAd? = nil
    private var autoShow: Bool = false
    
    private weak var delegate: InterstitialAdDelegate?
    
    init(delegate: InterstitialAdDelegate? = nil) {
        self.delegate = delegate
    }
    
    func load(tappxKey: String? = nil) {
        self.interstitialAd = TappxInterstitialAd(delegate: self)
        // Call setAutoShowWhenReady only for the autoShow case
        self.interstitialAd?.setAutoShowWhenReady(enable: self.autoShow)
        
        if let tappxKey = tappxKey {
            let settings = TappxSettings()
            settings.setKeywords(keywords: [tappxKey])
            self.interstitialAd?.load(settings: settings)
            return
        }
        
        self.interstitialAd?.load()
    }
    
    func isReady() -> Bool {
        return self.interstitialAd?.isReady() ?? false
    }
    
    func show(from viewController: UIViewController?) {
        self.interstitialAd?.show(from: viewController)
    }
    
    func autoShow(enable: Bool) {
        self.autoShow = enable
    }
    
    private func updateLog(message: String) {
        self.delegate?.updateInterstitialLog(message: message)
    }
    
}


extension InterstitialAd: TappxInterstitialAdDelegate {
    
    func tappxInterstitialAdDidFail(interstitialAd: TappxInterstitialAd, error: TappxErrorAd) {
        self.interstitialAd = nil
        let errorMessage = TappxErrorManager.message(for: error.code)
        updateLog(message: "interstitial".localized + "status.failed".localized + errorMessage)
        self.delegate?.interstitialDidFailToLoad(self, error: error)
    }
    
    func tappxInterstitialAdDidFinishLoad(interstitialAd: TappxInterstitialAd) {
        updateLog(message: "interstitial".localized + "status.loaded".localized)
        self.delegate?.interstitialDidLoad(self)
    }
    
    func tappxInterstitialAdDidAppear(interstitialAd: TappxInterstitialAd) {
        updateLog(message: "interstitial".localized + "status.appeared".localized)
        self.delegate?.interstitialDidShow(self)
    }
    
    func tappxInterstitialAdDidPress(interstitialAd: TappxInterstitialAd) {
        updateLog(message: "interstitial".localized + "status.pressed".localized)
        self.delegate?.interstitialDidPress(self)
    }
    
    func tappxInterstitialAdDidClose(interstitialAd: TappxInterstitialAd) {
        updateLog(message: "interstitial".localized + "status.closed".localized)
        self.delegate?.interstitialDidClose(self)
    }
    
    func tappxInterstitialAdDismissed(interstitialAd: TappxInterstitialAd) {
        self.interstitialAd = nil
        updateLog(message: "interstitial".localized + "status.dismissed".localized)
        self.delegate?.interstitialDidDisappear(self)
    }
    
}
