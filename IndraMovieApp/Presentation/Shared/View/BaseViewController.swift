//
//  BaseViewController.swift
//  IndraMovieApp
//
//  Created by Cesar Velasquez on 5/26/21.
//

import UIKit

class BaseViewController: UIViewController {

    internal var progressAnimationView : UIView?

    var barNavigationIsHidden: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(red: 8.0/255.0, green: 206/255.0, blue: 119/255.0, alpha: 1.0)
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white] // With a red background, make the title more readable.
        navigationItem.standardAppearance = appearance
        navigationItem.scrollEdgeAppearance = appearance
        navigationItem.compactAppearance = appearance
        showNavigation()
    }
    
    private func showNavigation(){
        self.navigationController?.navigationBar.isHidden = barNavigationIsHidden
    }

}

extension BaseViewController: BaseViewModelOutput {
    
    func onValidationError(error: ErrorResultModel) {
        //TODO impletments alert message
    }
    
    func onFailure(error: ErrorResultModel) {
        //TODO impletments alert message

    }
    
    func onForbiddenLogout() {
        //TODO impletments alert message

    }
    
    func onInternetConnectionError() {
        //TODO impletments alert message

    }
    
    func onTimeoutError() {
        //TODO impletments alert message

    }
}

// MARK: Progress Activity

extension BaseViewController {
    
    func showProgressActivityView(viewParent: UIView, animatedView: UIView) {
        if self.progressAnimationView == nil {
            self.progressAnimationView = UIView()
            self.progressAnimationView?.frame = viewParent.frame
            self.progressAnimationView?.center = viewParent.center
            self.progressAnimationView?.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.4)
            
            self.progressAnimationView?.addSubview(animatedView)
            
            animatedView.center = viewParent.center
            
            viewParent.superview?.addSubview(self.progressAnimationView ?? UIView())
        }
    }

    func hideProgressActivityView() {
        self.progressAnimationView?.removeFromSuperview()
        self.progressAnimationView = nil
    }
}



