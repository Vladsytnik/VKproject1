//
//  ViewController.swift
//  vk
//
//  Created by Vlad Sytnik on 12.07.2022.
//

import UIKit


class TableViewController: UITableViewController {
    
    let url = "https://publicstorage.hb.bizmrg.com/sirius/result.json"
    var services: [Service] = []
    var images: [UIImage] = []
    
    lazy var activeIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.center = self.view.center
        self.view.addSubview(indicator)
        return indicator
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Сервисы VK"

        activeIndicator.startAnimating()
        fetchData()
    }
}

extension TableViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        services.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let service = services[indexPath.row]
        
        cell.textLabel?.text = service.name
        cell.textLabel?.font = UIFont.systemFont(ofSize: 18)
        cell.detailTextLabel?.text = service.serviceDescription
        cell.downloadImageFrom(link: service.iconURL)
        cell.accessoryType = .disclosureIndicator
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        guard let vc = storyBoard.instantiateViewController(withIdentifier: "vc") as? ViewController else {return}
        vc.service = services[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension TableViewController {
    func fetchData() {
        guard let url = URL(string: url) else {return}
        
        URLSession(configuration: .default)
            .dataTask(with: url) { (data, response, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            if let response = response {
                print(response)
            }
            
            if let data = data {
                do {
                    let data = try JSONDecoder()
                        .decode(Model.self, from: data)
                    self.services = data.body.services
                    DispatchQueue.main.async {
                        self.activeIndicator.stopAnimating()
                        self.updateData()
                    }
                } catch let error {
                    print(error)
                }
            }
        }.resume()
    }
    
    func fetchImage(with indexPath: IndexPath, andCell cell: UITableViewCell) {
        let url = services[indexPath.row].iconURL
        guard let url = URL(string: url) else {return}

        URLSession(configuration: .default)
            .dataTask(with: url) { (data, response, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }

            if let response = response {
                print(response)
            }

            if let data = data {
                do {
                    let image = UIImage(data: data)
                    DispatchQueue.main.async {
                        cell.imageView?.image = image
                    }
                } catch let error {
                    print(error)
                }
            }
        }.resume()

    }
    
    func updateData() {
        tableView.reloadData()
    }
}

