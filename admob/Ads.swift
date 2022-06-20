//
//  Ads.swift
//  ads_example
//
//  Created by MusicMaker on 02/04/2022.
//

import Foundation
import UIKit
import GoogleMobileAds

class AdsTester: NSObject, AdsViewerExample_Delegate {
   
    
   
    static let shared = AdsTester()
    
    private var py: AdsViewerExamplePyCallback?
    
    private var interstitial: GADInterstitialAd!
    private var bannerView: GADBannerView!
    private var staticBannerView: GADBannerView!
        
    private var scaleFactor: CGFloat = 2.0
    
    override init() {
        super.init()
        InitAdsViewerExample_Delegate(delegate: self)
        GADMobileAds.sharedInstance().start(completionHandler: nil)
        GADMobileAds.sharedInstance().requestConfiguration.testDeviceIdentifiers = [ "3657c067d510bcedb9e5605167f20c06" ]
    }
    
    func set_AdsViewerExample_Callback(callback: AdsViewerExamplePyCallback) {
        py = callback
        
    }
    
    func init_ads_class() {
        
    }
    
    func banner_ad(enabled: Bool) {
        guard let kivy_vc = get_viewcontroller() else { return }
        guard let view = kivy_vc.view else {return}
        scaleFactor = view.contentScaleFactor
        
        if !enabled {
            if bannerView != nil {
                bannerView.removeFromSuperview()
                bannerView = nil
            }
        } else {
            if bannerView == nil {
                let frame = view.frame
                let viewWidth = frame.width
                let scale = kivy_vc.view.contentScaleFactor
                scaleFactor = scale
                bannerView = GADBannerView(adSize: GADAdSizeFromCGSize(CGSize(width: viewWidth, height: 180 / scale)))
                bannerView.adUnitID = "ca-app-pub-3940256099942544/2435281174"
                bannerView.translatesAutoresizingMaskIntoConstraints = false
                bannerView.rootViewController = kivy_vc
                kivy_vc.view.addSubview(bannerView)

                let horizontalConstraint = NSLayoutConstraint(item: bannerView!, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0)
                let verticalConstraint = NSLayoutConstraint(item: bannerView!, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottomMargin, multiplier: 1, constant: 0)

                kivy_vc.view.addConstraints([horizontalConstraint, verticalConstraint])
                bannerView.load(GADRequest())
            }
        }
    }
    
    func static_banner_ad(enabled: Bool) {
        guard let kivy_vc = get_viewcontroller() else { return }
        guard let view = kivy_vc.view else {return}
        scaleFactor = view.contentScaleFactor
        
        if !enabled {
            if staticBannerView != nil {
                staticBannerView.removeFromSuperview()
                staticBannerView = nil
                //set self.ads_space in kivy back to 0
            }
            py!.banner_did_load(w: 0, h: 0)
        } else {
            if staticBannerView == nil {
                let frame = view.frame
                let viewWidth = frame.width
                let scale = kivy_vc.view.contentScaleFactor
                staticBannerView = GADBannerView(adSize: GADAdSizeFromCGSize(CGSize(width: viewWidth, height: 180 / scale)))
                staticBannerView.adUnitID = "ca-app-pub-3940256099942544/2435281174"
                //enable delegate to call bannerViewDidReceiveAd function to set self.ads_space in kivy
                staticBannerView.delegate = self
                staticBannerView.translatesAutoresizingMaskIntoConstraints = false
                staticBannerView.rootViewController = kivy_vc
                kivy_vc.view.addSubview(staticBannerView)

                let horizontalConstraint = NSLayoutConstraint(item: staticBannerView!, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0)
                let verticalConstraint = NSLayoutConstraint(item: staticBannerView!, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: 0)

                kivy_vc.view.addConstraints([horizontalConstraint, verticalConstraint])
                staticBannerView.load(GADRequest())
            }
        }
    }
    
    func fullscreen_ad() {
        let request = GADRequest()
        GADInterstitialAd.load(
            withAdUnitID:"ca-app-pub-3940256099942544/4411468910",
            request: request,
            completionHandler: { [self] ad, error in
                if let error = error {
                    print("Failed to load interstitial ad with error: \(error.localizedDescription)")
                    return
                }
                guard let kivy = get_viewcontroller() else {return}
                interstitial = ad
                interstitial?.present(fromRootViewController: kivy)
            }
        )
    }
    
}

extension AdsTester: GADBannerViewDelegate {
    func bannerViewDidReceiveAd(_ bannerView: GADBannerView) {
        guard let py = py else {return}
        let frame = bannerView.frame
        py.banner_did_load(w: frame.width * scaleFactor, h: frame.height * scaleFactor)
        
    }
}
