//
//  CityAirIndexViewController.swift
//  WebSocketProximity
//
//  Created by Ravindra Patidar on 26/06/21.
//

import UIKit


class CityAirIndexViewController: UIViewController {
    
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    fileprivate var arrCityAirIndex:[CityAirIndexModel]?
    var lastUpdatedDate: Date?
    var lastUpdateStr = "1 sec ago"
    var updateTimer: Timer?
    fileprivate var isWebSocketStop = false
    let webSConnect = WebSocketConnect()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTableView()
        setUpWebSocket()
        updateTimer = Timer.scheduledTimer(timeInterval: 30, target: self, selector: #selector(runTimedCode), userInfo: nil, repeats: true)
    }
    @objc func runTimedCode() {
        if isWebSocketStop {
            lastUpdatedValue()
        }
    }
    func setUpTableView() {
        tblView.dataSource = self
        tblView.delegate = self
        tblView.separatorStyle = .none
    }
    func setUpWebSocket() {
        activityIndicator.startAnimating()
        
        webSConnect.connectToWebSocket(url: UrlConstants.wsUrl)
        webSConnect.sendMessageClousre = {[weak self] message in
            self?.convertStringToJson(jsonStr: message)
        }
        webSConnect.receiveErrorClousre = {[weak self] in
            self?.isWebSocketStop = true
            self?.lastUpdatedValue()
        }
    }
    
    func lastUpdatedValue() {
        lastUpdateStr = lastUpdatedDate?.timeAgoDisplay() ?? ""
        DispatchQueue.main.async {
            self.tblView.reloadData()
        }
    }
    func convertStringToJson(jsonStr: String) {
        arrCityAirIndex = jsonStr.parse(to: [CityAirIndexModel].self)
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
            self.activityIndicator.isHidden = true
            self.tblView.reloadData()
        }
    }
}

extension CityAirIndexViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrCityAirIndex?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CityIndexTableViewCell", for: indexPath) as! CityIndexTableViewCell
        let detail = arrCityAirIndex?[indexPath.row]
        let cityName = detail?.city
        let airValue = detail?.aqi
        if let airValue = airValue {
            let airValueStr  = String(format: "%.2f", airValue)
            cell.setAllLabel(cityName: cityName ?? "", airIndex: airValueStr, time: lastUpdateStr)
        }
        cell.setAirIndexLblBG(airIValue: airValue ?? 0.0)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectCity = arrCityAirIndex?[indexPath.row]
        let liveGraphVC = UIStoryboard.main.instantiate() as LiveGraphAirIndexViewController
        liveGraphVC.cityName = selectCity?.city ?? ""
        self.navigationController?.pushViewController(liveGraphVC, animated: true)
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60.0
    }
    
    
}
