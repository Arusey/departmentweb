//
//  HomeController.swift
//  TheWeatherApp
//
//  Created by Kevin Lagat on 1/14/21.
//

import UIKit

class HomeController: UIViewController {
    
    //MARK: - IB Outlets
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: - properties
    
    let viewModel: HomeViewModel = .init()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Bookmarked Cities"
        
        searchBar.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: CityCell.className, bundle: nil), forCellReuseIdentifier: CityCell.className)
    }

}


extension HomeController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.bookmarks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: CityCell.className, for: indexPath) as! CityCell
        
        let data = self.viewModel.bookmarks[indexPath.row]
        cell.cityName.text = data.name
        cell.weatherTemp.text = "\(data.main.temp)"
        cell.weatherStatus.text = data.weather[0].main
        return cell
        
    }
    
    
}

extension HomeController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            self.viewModel.bookmarks.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
}

extension HomeController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.view.endEditing(true)
        
        self.view.addBlurView()
        self.viewModel.getCityByName(name: searchBar.text ?? "") { result in
            DispatchQueue.main.async {
                self.searchBar.text = ""
                self.view.removeBlurView()
            }
            
            switch result {
            case .failure:
                DispatchQueue.main.async {
                    self.presentAlert(title: "Alert", message: "Invalid entry")
                }
            case .success(let city):
                guard let city = city else { return }
                self.viewModel.bookmarks.append(city)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
        
    }
    
}


