//
//  ViewController.swift
//  Weather
//
//  Created by Andrew Vasiliev on 18/02/2019.
//  Copyright © 2019 deepkotix. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
	private weak var loadingView: UIView?

    init() {
        let className = String(describing: type(of: self))

        super.init(nibName: className, bundle: nil)
    }

	func showLoading() {
		guard
			loadingView == nil,
			let loadingView = Bundle.main.loadNibNamed("LoadingView", owner: nil, options: nil)?.first as? UIView
		else {
			return assertionFailure("Can't find LoadingView")
		}

		self.loadingView = loadingView
		loadingView.frame = view.bounds
		view.addSubview(loadingView)
	}

	func hideLoading() {
		loadingView?.removeFromSuperview()
	}

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
