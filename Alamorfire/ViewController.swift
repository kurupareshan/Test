//
//  ViewController.swift
//  Alamorfire
//
//  Created by kurupareshan pathmanathan on 1/2/22.
//

import UIKit
import Alamofire

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
   
    var movieArray = [Film]()
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .green
        fetchFilms()
        self.tableView.register(TableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func fetchFilms() {
        // 1
        let request = AF.request("https://swapi.dev/api/films")
        // 2
        request.responseDecodable(of: Films.self) { (response) in
            guard let films = response.value else { return }
            self.movieArray = films.all
            self.tableView.reloadData()
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TableViewCell
        let item = movieArray[indexPath.row]
        cell.textLabel?.text = item.title
        return cell
    }
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        var values = [String]()
        values =  [movieArray[indexPath.row].title, movieArray[indexPath.row].director, movieArray[indexPath.row].producer,
                   movieArray[indexPath.row].releaseDate]
       
//        vc.modalPresentationStyle = .fullScreen
        //self.present(vc, animated: true, completion: nil)
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let vc = storyboard.instantiateViewController(withIdentifier: "DetailViewController")
//        self.present(vc, animated: true, completion: nil)
        
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let homeViewController = mainStoryboard.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        homeViewController.data = values
        homeViewController.modalPresentationStyle = .fullScreen
        self.present(homeViewController, animated: true)
        
        return indexPath
    }

}

