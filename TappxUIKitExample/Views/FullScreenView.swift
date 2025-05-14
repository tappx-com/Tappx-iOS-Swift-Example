//
//  FullScreenView.swift
//  TappxUIKitExample
//
//  Created by Sara Diaz Perez on 6/5/25.
//

import UIKit

// View Interstitial & Rewarded
class FullScreenView: UIViewController {
    @IBOutlet var backgroundView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var switchLabel: UILabel!
    @IBOutlet weak var autoShowSwitch: UISwitch!
    @IBOutlet weak var switchView: UIView!
    
    @IBOutlet weak var buttonsConstraint: NSLayoutConstraint!
    @IBOutlet weak var loadLabel: UILabel!
    
    @IBOutlet weak var readyButtonView: UIView!
    @IBOutlet weak var readyHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var readyLabel: UILabel!
    @IBOutlet weak var showButtonView: UIView!
    @IBOutlet weak var showHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var showLabel: UILabel!
    
    @IBOutlet weak var statusBoxBackgroundView: UIView!
    @IBOutlet weak var statusLabel: UILabel!
    
    @IBOutlet weak var statusInputView: UIView!
    @IBOutlet weak var statusInputText: UITextView!
    
    private lazy var interstitialAd: InterstitialAd = {
        InterstitialAd(delegate: self)
    }()

    private lazy var rewardedAd: RewardedAd = {
        RewardedAd(delegate: self)
    }()
    
    var viewType: AdType = .interstitial

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.titleView = (self.navigationController?.viewControllers.first as? MainView)?.navigationItem.titleView
        configureView()
        setupBackButton()
    }
    
    private func configureView() {
        switch viewType {
        case .interstitial:
            setInterstitialView()
        case .rewarded:
            setRewardedView()
        default:
            break
        }
        
        autoShowSwitch.isOn = false
        
        backgroundView.backgroundColor = ColorTheme.secondary
        titleLabel.textColor =  ColorTheme.primary
        titleLabel.font = UIFont.titleFont()
        switchLabel.font = UIFont.bodyFont()
        autoShowSwitch.onTintColor = ColorTheme.switchOn
        
        loadLabel.text = "button.load".localized
        loadLabel.font = UIFont.bodyFont()
        readyLabel.text = "button.ready".localized
        readyLabel.font = UIFont.bodyFont()
        showLabel.text = "button.show".localized
        showLabel.font = UIFont.bodyFont()
        
        configureStatus()
    }
    
    private func setupBackButton() {
        navigationItem.leftBarButtonItem = nil
        navigationItem.hidesBackButton = true
        
        let config = UIImage.SymbolConfiguration(pointSize: 20, weight: .bold)
        let backImage = UIImage(systemName: "chevron.backward", withConfiguration: config)?
            .withRenderingMode(.alwaysOriginal)
        
        let backButton = UIBarButtonItem(image: backImage, style: .plain, target: self, action: #selector(backButtonTapped))
        backButton.tintColor = .white
        
        navigationItem.rightBarButtonItem = backButton
    }
    
    @objc private func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    private func configureStatus() {
        statusBoxBackgroundView.backgroundColor = ColorTheme.darkGray
        statusLabel.font = UIFont.titleFont()
       
        statusInputView.backgroundColor = ColorTheme.scrollBackground
        statusInputView.layer.cornerRadius = 8
    }
    
    func setInterstitialView() {
        titleLabel.text = "interstitial".localized
        switchView.isHidden = false
        buttonsConstraint.constant = 91
        
    }
    
    func setRewardedView() {
        titleLabel.text = "rewarded".localized
        switchView.isHidden = true
        buttonsConstraint.constant = 35
        
    }
    
    @IBAction func autoShowAction(_ sender: Any) {
        if viewType == .interstitial {
            interstitialAd.autoShow(enable: autoShowSwitch.isOn)
            if autoShowSwitch.isOn {
                setAutoShowOn()
                return
            }
            setAutoShowOff()
            return
        }
    }
    
    @IBAction func loadAction(_ sender: Any) {
        if viewType == .interstitial {
            interstitialAd.load()
            return
        }
        
        rewardedAd.load()
    }
    
    @IBAction func readyAction(_ sender: Any) {
        let isReady: Bool = viewType == .interstitial ? interstitialAd.isReady() : rewardedAd.isReady()
        
        let readyText = "\(viewType == .interstitial ? "Interstitial" : "Rewarded") isReady: \(isReady)"
        statusInputText.text.insert(contentsOf: "\(readyText)\n", at: statusInputText.text.startIndex)
    }
    
    @IBAction func showAction(_ sender: Any) {
        if viewType == .interstitial {
            interstitialAd.show(from: self)
            return
        }
        
        rewardedAd.show(from: self)
    }
    
    func setAutoShowOn() {
        readyButtonView.isHidden = true
        readyHeightConstraint.constant = 0
        showButtonView.isHidden = true
        showHeightConstraint.constant = 0
    }
    
    func setAutoShowOff() {
        readyButtonView.isHidden = false
        readyHeightConstraint.constant = 55
        showButtonView.isHidden = false
        showHeightConstraint.constant = 55
    }
    
}

extension FullScreenView: InterstitialAdDelegate {
    func interstitialDidLoad(_ interstitialAd: InterstitialAd) {
        // Use this method to implement an action when load
    }
    
    func interstitialDidFailToLoad(_ interstitialAd: InterstitialAd, error: any Error) {
        // Use this method to implement an action when fail to load
    }
    
    func interstitialDidShow(_ interstitialAd: InterstitialAd) {
        // Use this method to implement an action when show
    }
    
    func interstitialDidClose(_ interstitialAd: InterstitialAd) {
        // Use this method to implement an action when close
    }
    
    func interstitialDidPress(_ interstitialAd: InterstitialAd) {
        // Use this method to implement an action when press
    }
    
    func interstitialDidDisappear(_ interstitialAd: InterstitialAd) {
        // Use this method to implement an action when disappear
    }
    
    func updateInterstitialLog(message: String) {
        statusInputText.text.insert(contentsOf: "\(message)\n", at: statusInputText.text.startIndex)
    }
    
}

extension FullScreenView: RewardedAdDelegate {
    func rewardedAdDidFinishLoad(rewardedAd: RewardedAd) {
        // Use this method to implement an action when load
    }
    
    func rewardedAdDidFailToLoad(rewardedAd: RewardedAd, withError error: any Error) {
        // Use this method to implement an action when tail to load
    }
    
    func rewardedAdDidClick(rewardedAd: RewardedAd) {
        // Use this method to implement an action when press
    }
    
    func rewardedAdDidClose(rewardedAd: RewardedAd) {
        // Use this method to implement an action when close
    }
    
    func rewardedAdDidRewardUser(rewardedAd: RewardedAd) {
        // Use this method to implement an action when get reward
    }
    
    func rewardedAdDidAppear(rewardedAd: RewardedAd) {
        // Use this method to implement an action when shows
    }
    
    func rewardedAdVideoClosed(rewardedAd: RewardedAd) {
        // Use this method to implement an action when close
    }
    
    func rewardedAdPlaybackFailed(rewardedAd: RewardedAd) {
        // Use this method to implement an action when failed
    }
    
    func updateRewarderLog(message: String) {
        statusInputText.text.insert(contentsOf: "\(message)\n", at: statusInputText.text.startIndex)
    }
    
}
