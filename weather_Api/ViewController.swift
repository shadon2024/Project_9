//
//  ViewController.swift
//  weather_Api
//
//  Created by Admin on 28/05/24.
//

import UIKit
import SnapKit
import Alamofire

class ViewController: UIViewController {
    
    private var tableView = UITableView()
    private var temperatureData: [Double] = []
    
    
    lazy  var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.style = .large
        indicator.color = .red
        return indicator
    }()
    
    var views: UIView = {
        let views = UIView()
        views.translatesAutoresizingMaskIntoConstraints = false
        views.backgroundColor = .blue
        return views
    }()
    
    
    
    lazy var battonApdate: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Update", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.addTarget(nil, action: #selector(UpdateTaped), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .cyan
        setupViews()
    }

    @objc func UpdateTaped() {
        
        activityIndicator.startAnimating()
        
        ApiManager.shared.getWeather { [weak self] values in
            
            DispatchQueue.main.async {
                self?.activityIndicator.stopAnimating()
                guard let self else { return }
                
                self.temperatureData = values
                self.tableView.reloadData()
            }

        }
    }
    
    private func setupViews() {
        view.addSubview(tableView)
        view.addSubview(battonApdate)
        view.addSubview(views)
        view.addSubview(activityIndicator)
        
        views.addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            //make.top.equalToSuperview().offset(50)
            make.edges.equalToSuperview()
            //make.leading.equalTo(200)
            //make.trailing.equalTo(-20)
            //make.width.equalTo(300)
        }
        
        battonApdate.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.centerX.equalToSuperview()
            make.height.equalTo(40)
            make.width.equalTo(100)
        }
        
        views.snp.makeConstraints { make in
            make.top.equalTo(battonApdate.snp.bottom).offset(100)
            make.centerX.equalToSuperview()
            make.height.equalTo(500)
            make.width.equalTo(300)
        }
        
        activityIndicator.snp.makeConstraints { make in
            make.top.equalTo(battonApdate.snp.bottom).offset(30)
            make.centerX.equalToSuperview()
        }
    
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
//        ApiManager.shared.getWeather { [weak self] values in
//
//            DispatchQueue.main.async {
//                guard let self else { return }
//
//                self.temperatureData = values
//                self.tableView.reloadData()
//            }
//
//        }
    }

}

// MARK: - UITableViewDataSource

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return temperatureData.count
        //return 10
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        let textValues = temperatureData[indexPath.row]
        cell.textLabel?.text = "\(textValues)"
        return cell
        
        
//                let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
//                cell.textLabel?.text = "hello"
//                return cell
    }
    
    
}

