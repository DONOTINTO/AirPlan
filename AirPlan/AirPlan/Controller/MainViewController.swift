//
//  ViewController.swift
//  AirPlan
//
//  Created by 이중엽 on 2023/06/12.
//

import UIKit
import SnapKit

class MainViewController: UIViewController {
    let mainView = MainView()
    
    override func loadView() {
        self.view = mainView
        mainView.initialSetup()
        mainView.makeUI()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetch()
    }
    
    func fetch() {
        /// api = http://api.airvisual.com/v2/countries?key=
        /// key = 7836e438-45f8-49af-b38b-bcbfefb090fa
        guard var url = URL(string: "https://api.airvisual.com/v2/nearest_city?key=7836e438-45f8-49af-b38b-bcbfefb090fa") else { return }
        
        // url.append(queryItems: [
        //     URLQueryItem(name: "nearest_city", value: nil)
        // ])
        
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let response = response as? HTTPURLResponse else { return }
            guard error == nil else { return }
            guard let data = data else { return }
            
            do {
                let decoder = JSONDecoder()
                let IQAir = try decoder.decode(IQAir.self, from: data)
                DispatchQueue.main.sync {
                    print(IQAir)
                }
            } catch {
                print(error.localizedDescription)
            }
            print(response.statusCode)
        }.resume()
    }
}

