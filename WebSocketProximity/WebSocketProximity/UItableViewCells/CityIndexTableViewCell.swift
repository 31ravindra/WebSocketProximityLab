//
//  CityIndexTableViewCell.swift
//  WebSocketProximity
//
//  Created by Ravindra Patidar on 26/06/21.
//

import UIKit

class CityIndexTableViewCell: UITableViewCell {
    
    @IBOutlet weak var lblCityName: UILabel!
    
    @IBOutlet weak var lblAirIndex: UILabel!
    
    @IBOutlet weak var lblTime: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setAllLabel(cityName: String, airIndex: String, time: String ) {
        self.lblTime.text = time
        self.lblCityName.text = cityName
        self.lblAirIndex.text = airIndex
    }
    func setAirIndexLblBG(airIValue: Double) {
        if airIValue < 100 {
            self.contentView.backgroundColor = .green
        } else if airIValue < 300 {
            self.contentView.backgroundColor = .orange
        } else {
            self.contentView.backgroundColor = .red
        }
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
