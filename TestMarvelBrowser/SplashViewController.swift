//
//  SplashViewController.swift
//  TestMarvelMonolithic
//
//  Created by David Vallejo on 24/5/21.
//

import UIKit
import Foundation

class SplashViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.setNavigationBarHidden(true, animated: true)

        DispatchQueue.main.asyncAfter(deadline: .now() + 3) { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.navigationController?.viewControllers = [ListTableViewController()]
        }
    }
}
