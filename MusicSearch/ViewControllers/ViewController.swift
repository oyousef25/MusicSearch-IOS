//
//  ViewController.swift
//  MusicSearch
//
//  Created by Omar Yousef on 2021-09-25.
//

import UIKit

class ViewController: UIViewController {
    //MARK: PROPERITIES
    var albumResults = [Album]()
    
    
    
    
    //MARK: OUTLETS
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var tableView: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        /*
            Setting up the delegate and data source for the tableView
         */
        tableView.delegate = self
        tableView.dataSource = self
        
        //Setting up the delegate for the searchTextField
        searchBar.delegate = self
    }

    //MARK: Actions
    
    /*
        This button will reset all values in the search textfield and the tableView.
     */
    @IBAction func resetButton(_ sender: Any) {
    }
    
    
}

//MARK: Extensions


//MARK: TableView Delegate
extension ViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //Find the cell that was clicked on by the user
        let selectedAlbum = albumResults[indexPath.row]
        
        /*
            Create an alert controller to display the album name that was added to the cart
         */
        let ac = UIAlertController(title: "\(selectedAlbum.collectionName) added to cart!", message: nil, preferredStyle: .alert)
        
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
}


//MARK: TableView Datasource
extension ViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "albumCell", for: indexPath) as! AlbumTableViewCell
        
//        cell.cellBackground.backgroundColor = UIColor(named: "CellBackground")
//        cell.cellBackground.layer.cornerRadius = 5.0
        
//        let movie = albumResults[indexPath.row]
//        cell.setUpCell(using: movie)
        
        return cell
    }
}


//MARK: SearchBar Delegate
extension ViewController: UISearchBarDelegate{
    /*
        If the search button was clicked
     */
//    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//        <#code#>
//    }
    
    
    
    //MARK: API METHODS
    /*
        Function to create a valid URL
     */
    
    
    /*
        Fetch the albums from the API
     */
}

