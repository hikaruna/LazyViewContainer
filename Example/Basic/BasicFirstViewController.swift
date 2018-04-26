//
//  ViewController.swift
//  Example
//
//  Created by 中川輝 on 2018/04/25.
//  Copyright © 2018年 中川輝. All rights reserved.
//

import UIKit
import LazyViewContainer

class BasicFirstViewController: UIViewController {

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier ?? "" {
        case "ToSecond":
            print("Prepare for ToSecond segue.")
            let lazyViewController = segue.destination as! LazyViewContainerViewController
            lazyViewController.doInBackground = { [weak self] () -> UIViewController? in
                print("Task begin.")
                sleep(3)
                print("Task finished.")
                guard let `self` = self else { return nil }
                let secondViewController = self.storyboard!.instantiateViewController(withIdentifier: "Second") as! BasicSecondViewController
                secondViewController.text = "Second View."
                return secondViewController
            }
        default:
            break
        }
    }
}

