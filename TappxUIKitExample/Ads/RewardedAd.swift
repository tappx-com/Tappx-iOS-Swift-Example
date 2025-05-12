//
//  RewardedAd.swift
//  TappxUIKitExample
//
//  Created by Sara Diaz Perez on 6/5/25.
//

import UIKit
import TappxFramework

protocol RewardedAdDelegate: AnyObject {
    func rewardedAdDidFinishLoad(rewardedAd: RewardedAd)
    func rewardedAdDidFailToLoad(rewardedAd: RewardedAd, withError error: Error)
    func rewardedAdDidClick(rewardedAd: RewardedAd)
    func rewardedAdDidClose(rewardedAd: RewardedAd)
    func rewardedAdDidRewardUser(rewardedAd: RewardedAd)
    func rewardedAdDidAppear(rewardedAd: RewardedAd)
    func rewardedAdVideoClosed(rewardedAd: RewardedAd)
    func rewardedAdPlaybackFailed(rewardedAd: RewardedAd)
    func updateRewarderLog(message: String)
}

class RewardedAd: NSObject {
    private var rewardedAd: TappxRewardedAd? = nil
    
    private weak var delegate: RewardedAdDelegate?
    
    init(delegate: RewardedAdDelegate? = nil) {
        self.delegate = delegate
    }
    
    func load(tappxKey: String? = nil) {
        self.rewardedAd = TappxRewardedAd(delegate: self)
        self.rewardedAd?.setAutoShowWhenReady(enable: false)
        if let tappxKey = tappxKey {
            let settings = TappxSettings()
            settings.setKeywords(keywords: [tappxKey])
            self.rewardedAd?.load(settings: settings)
            return
        }
        
        self.rewardedAd?.load()
    }
    
    func isReady() -> Bool {
        return self.rewardedAd?.isReady() ?? false
    }
    
    func show(from viewController: UIViewController) {
        self.rewardedAd?.show(from: viewController)
    }
    
    private func updateLog(message: String) {
        self.delegate?.updateRewarderLog(message: message)
    }
    
}


extension RewardedAd: TappxRewardedAdDelegate {
    func tappxRewardedAdDidFinishLoad(rewardedAd: TappxRewardedAd) {
        updateLog(message: "rewarded".localized + "status.loaded".localized)
        self.delegate?.rewardedAdDidFinishLoad(rewardedAd: self)
    }
    
    func tappxRewardedAdClicked(rewardedAd: TappxRewardedAd) {
        updateLog(message: "rewarded".localized + "status.clicked".localized)
        self.delegate?.rewardedAdDidClick(rewardedAd: self)
    }
    
    func tappxRewardedAdDismissed(rewardedAd: TappxRewardedAd) {
        self.rewardedAd = nil
        updateLog(message: "rewarded".localized + "status.dismissed".localized)
        self.rewardedAd = nil
        self.delegate?.rewardedAdDidClose(rewardedAd: self)
    }
    
    func tappxRewardedAdDidAppear(rewardedAd: TappxRewardedAd) {
        updateLog(message: "rewarded".localized + "status.appeared".localized)
        self.delegate?.rewardedAdDidAppear(rewardedAd: self)
    }
    
    func tappxRewardedAdVideoClosed(rewardedAd: TappxRewardedAd) {
        updateLog(message: "rewarded".localized + "status.closed".localized)
        self.delegate?.rewardedAdVideoClosed(rewardedAd: self)
    }
    
    func tappxRewardedAdPlaybackFailed(rewardedAd: TappxRewardedAd) {
        updateLog(message: "rewarded".localized + "status.playbackfailed".localized)
        self.delegate?.rewardedAdPlaybackFailed(rewardedAd: self)
    }
    
    func tappxRewardedAdVideoCompleted(rewardedAd: TappxRewardedAd) {
        updateLog(message: "rewarded".localized + "status.completed".localized)
    }
    
    func tappxRewardedAdUserDidEarnReward(rewardedAd: TappxRewardedAd) {
        updateLog(message: "reward".localized)
        self.delegate?.rewardedAdDidRewardUser(rewardedAd: self)
    }
    
    func tappxRewardedAdDidFail(rewardedAd: TappxRewardedAd, error: TappxErrorAd) {
        self.rewardedAd = nil
        updateLog(message: "rewarded".localized + "status.failed".localized + "\(error)")
        self.rewardedAd = nil
        self.delegate?.rewardedAdDidFailToLoad(rewardedAd: self, withError: error)
    }
    
}
