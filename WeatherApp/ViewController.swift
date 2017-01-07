//
//  ViewController.swift
//  WeatherApp
//
//  Created by Kerim Çağlar on 07/01/2017.
//  Copyright © 2017 Kerim Çağlar. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var cityName: UITextField!
    
    @IBOutlet weak var weatherDetail: UILabel!
    
    @IBAction func Calculate(_ sender: Any) {
        
        let cityName = self.cityName.text
        
        if let url = URL(string: "http://api.openweathermap.org/data/2.5/weather?q=" + cityName! + ",uk&appid=02369c3b62df655aa7ce8a1753bc8706")
        {
            
            let task = URLSession.shared.dataTask(with: url){data,response,error in
                
                if(error != nil)
                {
                    print(error!)
                }
                    
                else
                {
                    if let urlContent = data {
                        
                        do
                        {
                            let json = try JSONSerialization.jsonObject(with: urlContent, options: JSONSerialization.ReadingOptions.mutableContainers) as AnyObject
                            
                            if let weatherDetail = json["main"] as? NSDictionary
                            {
                                let temp = weatherDetail["temp"] as? Double
                                let tempCelcius = temp! - 273.15
                                
                                print(temp!)
                                DispatchQueue.main.async(execute: {
                                self.weatherDetail.text = String(describing: tempCelcius)
                                })
                            }
                        }
                            
                        catch
                        {
                            print("Failed")
                        }
                    }
                }
            }
            
            task.resume()
            
        }
        else
        {
            print("Hatalı şehir ismi")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
    }
    
    
    
}

