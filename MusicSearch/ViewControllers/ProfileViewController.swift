//
//  ProfileViewController.swift
//  MusicSearch
//
//  Created by Omar Yousef on 2021-09-26.
//

import UIKit

class ProfileViewController: UIViewController {

    //MARK: Outlets
    @IBOutlet weak var descriptionLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        /*
            Changing the description text to the one thats in the txt file
         */
        //Get file path
        let filePath = Bundle.main.path(forResource: "description", ofType: "txt")
        
        //Store the string value in a variable
        do{
            let contents = try String(contentsOfFile: filePath ?? "")
            //Change the label's text
            descriptionLabel.text = contents
            
        }catch{
            descriptionLabel.text = "Can't Find txt file"
        }
        
    }

}
