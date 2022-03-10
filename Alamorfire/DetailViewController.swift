//
//  DetailViewController.swift
//  Alamorfire
//
//  Created by kurupareshan pathmanathan on 1/3/22.
//

import UIKit
import Alamofire

class DetailViewController: UIViewController {

    var data : [String]!
    var listData: NSArray = []
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet weak var dirLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var prodLabel: UILabel!
    
    override func viewDidLoad() {
       
        super.viewDidLoad()
        self.view.backgroundColor = .white
//        titleLabel.backgroundColor = .yellow
//        titleLabel.text = data[0]
//        dirLabel.text = data[1]
//        dateLabel.text = data[2]
//        prodLabel.text = data[3]
   
    }

}

extension DetailViewController {
  // 1
  private func fetch<T: Decodable >(_ list: [String], of: T.Type) {
    var items: [T] = []
    // 2
    let fetchGroup = DispatchGroup()
    
    // 3
    list.forEach { (url) in
      // 4
      fetchGroup.enter()
      // 5
      AF.request(url).validate().responseDecodable(of: T.self) { (response) in
        if let value = response.value {
          items.append(value)
        }
        // 6
        fetchGroup.leave()
      }
    }
    
    fetchGroup.notify(queue: .main) {
        self.listData = items as NSArray
      //self.listTableView.reloadData()
    }
  }
    func fetchList() {
      // 1
      guard let data = data else { return }
      
      // 2
      switch data {
      case is Film:
        fetch(data, of: Starship.self)
      default:
        print("Unknown type: ", String(describing: type(of: data)))
      }
    }
}
