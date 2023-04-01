//
//  LoadingIndicator.swift
//  BoxOffice
//
//  Created by Muri, Rowan on 2023/03/28.
//

import UIKit

enum LoadingIndicator {
    static func showLoading() {
        DispatchQueue.main.async {
            guard let window = UIApplication.shared.windows.last else { return }
            
            let loadingIndicatorView: UIActivityIndicatorView
            
            if let existedView = window.subviews.first(where: { $0 is UIActivityIndicatorView })as? UIActivityIndicatorView {
                loadingIndicatorView = existedView
            } else {
                loadingIndicatorView = UIActivityIndicatorView()
                loadingIndicatorView.frame = window.frame
                loadingIndicatorView.style = .large
                
                window.addSubview(loadingIndicatorView)
            }
            
            loadingIndicatorView.startAnimating()
        }
    }
    
    static func hideLoading() {
        DispatchQueue.main.async {
            guard let window = UIApplication.shared.windows.last else { return }
            
            window.subviews.filter({ $0 is UIActivityIndicatorView }).forEach { $0.removeFromSuperview() }
        }
    }
}
