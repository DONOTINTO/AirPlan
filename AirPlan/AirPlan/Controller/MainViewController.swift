//
//  ViewController.swift
//  AirPlan
//
//  Created by 이중엽 on 2023/06/12.
//

import UIKit
import SnapKit
import CoreLocation

class MainViewController: UIViewController {
    let mainView = MainView()
    var data: IQAirData?
    var locationManager : CLLocationManager!
    var lat: Double = 37.56464630
    var lon: Double = 126.97610820
    var address: [CLPlacemark] = []
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainView.initialSetup()
        mainView.makeUI()
        fetchCoordinate()
        
        mainView.todayTDView.todayLabel.text = IQAirDate.shared.fetchDate()
    }
    
    func fetch() {
        /// api = http://api.airvisual.com/v2/countries?key=
        /// key = 7836e438-45f8-49af-b38b-bcbfefb090fa
        guard var url = URL(string: "https://api.airvisual.com/v2/nearest_city?key=7836e438-45f8-49af-b38b-bcbfefb090fa") else { return }
        guard let address = address.last else { return }
        
        url.append(queryItems: [
            URLQueryItem(name: "lon", value: String(lon)),
            URLQueryItem(name: "lat", value: String(lat))
        ])
        
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let response = response as? HTTPURLResponse else { return }
            guard error == nil else { return }
            guard let data = data else { return }
            
            do {
                let decoder = JSONDecoder()
                let IQAir = try decoder.decode(IQAir.self, from: data)
                DispatchQueue.main.sync {
                    self.data = IQAir.data
                    self.mainView.profileView.locationInfoLabel.text = "\(address.country!) \n \(address.locality!) \n \(address.name!)"
                    self.mainView.infoView.weatherLabel.text = "\(IQAir.data.current.weather.tp)°"
                    self.mainView.infoView.weatherImage.image = UIImage(named: IQAir.data.current.weather.ic)
                    self.mainView.infoView.aqiLabel.text = "AQI \(IQAir.data.current.pollution.aqius)"
                }
            } catch {
                print(error.localizedDescription)
            }
            print(response.statusCode)
        }.resume()
    }
    
    func fetchCoordinate() {
        DispatchQueue.main.async {
            self.locationManager = CLLocationManager.init() // locationManager 초기화
            self.locationManager.delegate = self // 델리게이트
            self.locationManager.desiredAccuracy = kCLLocationAccuracyBest // 거리 정확도 설정
            self.locationManager.requestAlwaysAuthorization() // 위치 권한 설정 값을 받아옴
            self.locationManager.startUpdatingLocation() // 위치 업데이트 시
            
            if let location = self.locationManager.location {
                self.lat = location.coordinate.latitude
                self.lon = location.coordinate.longitude
                self.addressInfo(lat: self.lat, lon: self.lon)
            }
        }
    }
    
    func addressInfo(lat: Double, lon: Double) {
        let findLocation = CLLocation(latitude: lat, longitude: lon)
        let geocoder = CLGeocoder()
        let locale = Locale(identifier: "Ko-kr")
        
        geocoder.reverseGeocodeLocation(findLocation, preferredLocale: locale) { placemark, error in
            guard let placemark = placemark else { return }
            guard error == nil else { print(error?.localizedDescription ?? "unknown error")
                return
            }
            self.address = placemark
            self.fetch()
        }
    }
}

extension MainViewController: CLLocationManagerDelegate {
    
}

