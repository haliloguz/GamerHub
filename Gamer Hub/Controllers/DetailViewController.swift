//
//  DetailViewController.swift
//  Gamer Hub
//
//  Created by Halil Oğuz on 30.05.2023.
//

import UIKit

class DetailViewController: UIViewController {
    
    static let reuseIdentifier = "DetailViewController"
    var game: Game = Game()

    override func viewDidLoad() {
        
        view.backgroundColor = .purple
        // Do any additional setup after loading the view.
        navigationItem.title = game.name
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = false
      
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
