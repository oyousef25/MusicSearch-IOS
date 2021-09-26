//
//  AlbumTableViewCell.swift
//  MusicSearch
//
//  Created by Omar Yousef on 2021-09-25.
//

import Foundation
import UIKit

class AlbumTableViewCell: UITableViewCell{
    //MARK: Outlets
    @IBOutlet weak var cellBackground: UIView!
    
    @IBOutlet weak var albumTitle: UILabel!
    
    @IBOutlet weak var trackName: UILabel!
    
    @IBOutlet weak var artistName: UILabel!
    
    @IBOutlet weak var albumImage: UIImageView!
    
    @IBOutlet weak var trackCost: UILabel!
    
    @IBOutlet weak var albumGenre: UILabel!
    
    
    //MARK: Methods
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    
    /*
        This method will replace each property value in the cell with the the ones that are returned by the object
     */
    func setUpCell(using album: Album){
        //Setting the value for each of the object's properities
        albumTitle.text = album.collectionName
        trackName.text = album.trackName
        artistName.text = album.artistName
        //Unwrapping the value of the double and turning it into a string
        trackCost.text = "$\(String(album.trackPrice ?? 0))"
        albumGenre.text = album.wrapperType
        
        //set a default image in case there is no poster
        albumImage.image = UIImage(named: "sample")
        
        //get the poster path string
        guard let posterPath = album.artworkUrl100 else { return }
        
        //build a url to fetch the album and load the image
        if let url = buildImageUrl(for: posterPath){
            print(url)
            loadPoster(url: url, forCell: self)
        }
    }
    
    /*
        This method will be building a valid image URL
     */
    func buildImageUrl(for path: String) -> URL? {
        let imagePath = path
        
        guard let imageURL = URL(string: imagePath) else { return nil}

        return imageURL
    }
    
    /*
        This method will load the image from the URL
     */
    func loadPoster(url: URL, forCell cell: AlbumTableViewCell){
        /*
         Starting a new URL session to read the image from the url
         */
        let session = URLSession.shared
        
        let task = session.downloadTask(with: url){
            url, response, error in
            
            if error == nil, let url = url, let data = try? Data(contentsOf: url), let posterImage = UIImage(data: data) {
                DispatchQueue.main.async {
                    cell.albumImage.image = posterImage
                }
            }
        }
        task.resume()
    }
}
