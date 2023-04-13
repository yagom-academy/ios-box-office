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
            let scenes = UIApplication.shared.connectedScenes
            let windowScene = scenes.first as? UIWindowScene
            guard let window = windowScene?.windows.last else { return }
            
            let loadingIndicatorView: UIActivityIndicatorView
            
            if let existedView = window.subviews.first(where: { $0 is UIActivityIndicatorView }) as? UIActivityIndicatorView {
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
            let scenes = UIApplication.shared.connectedScenes
            let windowScene = scenes.first as? UIWindowScene
            guard let window = windowScene?.windows.last else { return }
            
            window.subviews.filter({ $0 is UIActivityIndicatorView })
                           .forEach { $0.removeFromSuperview() }
        }
    }
    
    static func showLoading(in view: UIView) {
        DispatchQueue.main.async {
            let loadingIndicatorView: UIActivityIndicatorView
            
            if let existedView = view.subviews.first(where: { $0 is UIActivityIndicatorView }) as? UIActivityIndicatorView {
                loadingIndicatorView = existedView
            } else {
                loadingIndicatorView = UIActivityIndicatorView()
                loadingIndicatorView.frame = view.frame
                loadingIndicatorView.style = .large
                view.addSubview(loadingIndicatorView)
                
                loadingIndicatorView.translatesAutoresizingMaskIntoConstraints = false
                loadingIndicatorView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
                loadingIndicatorView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
            }
            
            loadingIndicatorView.startAnimating()
        }
        
    }
    
    static func hideLoading(in view: UIView) {
        DispatchQueue.main.async {
            view.subviews.filter({ $0 is UIActivityIndicatorView })
                         .forEach { $0.removeFromSuperview() }
        }
    }
}
