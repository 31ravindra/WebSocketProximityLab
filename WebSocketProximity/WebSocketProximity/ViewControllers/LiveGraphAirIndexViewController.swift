//
//  LiveGraphAirIndexViewController.swift
//  WebSocketProximity
//
//  Created by Ravindra Patidar on 26/06/21.
//

import UIKit
import Charts

class LiveGraphAirIndexViewController: UIViewController {
    
    @IBOutlet weak var lineChartView: LineChartView!
    @IBOutlet weak var lblCityName: UILabel!
    
    var cityName = ""
    var lineDataEntry: [ChartDataEntry] = []
    let webSConnect = WebSocketConnect()
    var arrCityAirIndex:[CityAirIndexModel]?
    var filterArr:[CityAirIndexModel]?
    var x = 10.0
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Live Graph"
        self.lblCityName.text = cityName + " Air Index"
        setUpWebSocket()
        // Do any additional setup after loading the view.
    }
    
    func setUpWebSocket() {
        webSConnect.connectToWebSocket(url: UrlConstants.wsUrl)
        webSConnect.sendMessageClousre = {[weak self] message in
            self?.convertStringToJson(jsonStr: message)
        }
        //        webSConnect.receiveErrorClousre = {[weak self] in
        //
        //        }
    }
    func convertStringToJson(jsonStr: String) {
        arrCityAirIndex = jsonStr.parse(to: [CityAirIndexModel].self)
        filterArr = arrCityAirIndex?.filter({$0.city == cityName})
        DispatchQueue.main.async {
            if self.filterArr?.count ?? 0 > 0 {
                self.showOrUpdateLineChart(value: self.filterArr?[0].aqi ?? 0.0 )
                self.x += 30.0
            }
        }
        
    }
    
    func showOrUpdateLineChart(value: Double) {
        let dataPoint = ChartDataEntry(x: x, y: value)
        lineDataEntry.append(dataPoint)
        let chartDataSet = LineChartDataSet(entries: lineDataEntry, label: cityName)
        let chartData = LineChartData()
        chartData.addDataSet(chartDataSet)
        chartData.setDrawValues(true)
        chartDataSet.colors = [UIColor.systemPink]
        chartDataSet.setCircleColor(UIColor.systemPink)
        chartDataSet.circleHoleColor = UIColor.systemPink
        chartDataSet.circleRadius = 4.0
        
        // Gradient Fill
        let gradientColours = [UIColor.systemPink.cgColor, UIColor.clear.cgColor] as CFArray
        let colorLocation: [CGFloat] = [1.0,0.0]
        guard let gradient = CGGradient.init(colorsSpace: CGColorSpaceCreateDeviceRGB(), colors: gradientColours, locations: colorLocation) else {
            return
        }
        chartDataSet.fill = Fill.fillWithLinearGradient(gradient, angle: 90.0)
        chartDataSet.drawFilledEnabled = true
        
        lineChartView.xAxis.labelPosition = .bottom
        lineChartView.xAxis.drawGridLinesEnabled = false
        lineChartView.legend.enabled = true
        lineChartView.rightAxis.enabled = false
        lineChartView.leftAxis.drawGridLinesEnabled = false
        lineChartView.backgroundColor = .white
        lineChartView.data = chartData
        
    }
}


