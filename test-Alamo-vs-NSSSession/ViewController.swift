//
//  ViewController.swift
//  test-Alamo-vs-NSSSession
//
//  Created by Francisco Claret on 08/03/16.
//  Copyright © 2016 Francisco Claret. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {
    
    @IBOutlet weak var outputLbl: UILabel!
    
    var name: String!
    var hairColor: String!
    var height: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func downloadDataNSURLSession(completion: () -> ()) {
        
        let urlString = "http://swapi.co/api/people/1/"
        
        let session = NSURLSession.sharedSession()
        
        let url = NSURL(string: urlString)!
        
        session.dataTaskWithURL(url) { (data: NSData?, response: NSURLResponse?, error: NSError?) -> Void in
            
            if let responsData = data {
                
                do {
                    let json = try NSJSONSerialization.JSONObjectWithData(responsData, options: NSJSONReadingOptions.AllowFragments)
                    
                    if let dict = json as? Dictionary<String, AnyObject> {
                        
                        if let name = dict["name"] as? String, let height = dict["height"] as? String, let birthYear = dict["birth_year"] as? String, let hairColor = dict["hair_color"] as? String {
                            
                            let person = Person(name: name, height: height, birthYear: birthYear, hairColor: hairColor)

                            self.name = person.name
                            self.hairColor = person.hairColor
                            self.height = person.height
                        }
                    }
                    
                    completion()
                    
                } catch let err as NSError {
                    print(err.debugDescription)
                }
            }
        }.resume()
    }
    
    func downloadDataAlamo(completion: () -> ()) {
        
        let nsURL = NSURL(string: "http://swapi.co/api/people/1/")!
        
        Alamofire.request(.GET, nsURL).responseJSON { response in
            
            let results = response.result
            
            if let dict = results.value! as? Dictionary<String, AnyObject> {
                
                if let name = dict["name"] as? String, let height = dict["height"] as? String, let birthYear = dict["birth_year"] as? String, let hairColor = dict["hair_color"] as? String {
                    
                    let person = Person(name: name, height: height, birthYear: birthYear, hairColor: hairColor)

                    self.name = person.name
                    self.hairColor = person.hairColor
                    self.height = person.height
                }
                completion()
            }
        }
    }
    
    @IBAction func nssessionCAll(sender: AnyObject) {
        
        downloadDataNSURLSession { () -> () in
            
                self.outputLbl.text = self.name
        }
    }
    
    @IBAction func alamoCall(sender: AnyObject) {
        
        downloadDataAlamo { () -> () in
            
            self.outputLbl.text = self.hairColor
        }
    }
    
    @IBAction func nssessionCallwThreadControl(sender: AnyObject) {
        
        downloadDataNSURLSession { () -> () in
            
            dispatch_async(dispatch_get_main_queue()) {
                
                self.outputLbl.text = self.height
            }
        }
    }
}