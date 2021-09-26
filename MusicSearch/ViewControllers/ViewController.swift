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
        //Reset the search bar
        searchBar.text = ""
        
        
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
        return albumResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "albumCell", for: indexPath) as! AlbumTableViewCell
        
//        cell.cellBackground.backgroundColor = UIColor(named: "CellBackground")
//        cell.cellBackground.layer.cornerRadius = 5.0
        
//        let album = albumResults[indexPath.row]
//        cell.setUpCell(using: album)
        
        return cell
    }
}


//MARK: SearchBar Delegate
extension ViewController: UISearchBarDelegate{
    /*
        If the search button was clicked
     */
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        //Storing the value of the user input in a variable to access it later when creating the url
        if let text = searchBar.text, !text.isEmpty {
            print("Searching for \(text)")
            
            //creating a new url using the user input in the search bar
            if let url = createAlbumUrl(for: text){
            
                //Fetching the albums from the url
                fetchAlbums(from: url)
            }
        } else {
            print("Nothing entered")
        }
        
        searchBar.resignFirstResponder()
    }
    
    
    
    //MARK: API METHODS
    /*
        Function to create a valid URL
     */
    func createAlbumUrl(for album: String) -> URL?{
        //Create the url string and return it
        guard let cleanURL = album.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { fatalError("Can't create a valid url") }
        
        var urlString = "https://itunes.apple.com/search?"
        urlString = urlString.appending("term+\(cleanURL)")
        urlString = urlString.appending("&entity=musicTrack")
        print(urlString)
        
        
        return URL(string: urlString)
    }
    
    
    /*
        Fetch the albums from the API
     */
    func fetchAlbums(from url: URL){
        //Starting a new url session to fetch data from the JSON object thats returned by our URL
        let albumTask = URLSession.shared.dataTask(with: url){
            data, response, error in
            
            //Handling any errors and diplaying them
            if let error = error {
                print("There was an error fetching the data - \(error.localizedDescription)")
            } else {
                do {
                    //Unwrapping using optional binding to make sure its not nil
                    guard let someData = data else { return }
                    
                    /*
                        Decoding the JSON data
                     */
                    let jsonDecoder = JSONDecoder()
                    let downloadedResults = try jsonDecoder.decode(Albums.self, from: someData)
                    
                    //Adding all the results to our albums array
                    self.albumResults = downloadedResults.results
                } catch let error {
                    print("Problem decoding: \(error.localizedDescription)")
                }
                
                //Reloading the tableview to display the new results
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
        albumTask.resume()
    }
    
}

