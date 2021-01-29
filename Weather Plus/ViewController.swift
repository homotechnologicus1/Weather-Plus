//
//  ViewController.swift
//  Weather Plus
//
//  Created by joe_mac on 01/29/2021.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let currentWeather = CurrentWeather()
        currentWeather.getCurrentWeather { (success) in
            if success {
                print("city is: ", currentWeather.city, currentWeather.currentTempo)
            }
        }
    }


}

