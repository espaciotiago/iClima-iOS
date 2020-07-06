//
//  LoadingView.swift
//  iClima
//
//  Created by Santiago Moreno on 6/07/20.
//  Copyright © 2020 Santiago Moreno. All rights reserved.
//

import UIKit

class LoadingView: UIView {

    private var _loading: Bool?
    private var loader: UIActivityIndicatorView?
    
    var loading: Bool? {
        get{
            return _loading
        }
        set {
            if let _loading = newValue {
                if(_loading){
                    loader?.startAnimating()
                    self.isHidden = false
                }else{
                    loader?.stopAnimating()
                    self.isHidden = true
                }
            }else{
                loader?.stopAnimating()
                self.isHidden = true
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor(white: 1, alpha: 0.7)
        self.isHidden = false
        
        loader = UIActivityIndicatorView()
        loader?.color = UIColor.systemBlue
        loader?.startAnimating()
        loader?.translatesAutoresizingMaskIntoConstraints = false;
        
        if let loader = loader {
            self.addSubview(loader)
            loader.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
            loader.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        }
        
        self.translatesAutoresizingMaskIntoConstraints = false;
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

}
