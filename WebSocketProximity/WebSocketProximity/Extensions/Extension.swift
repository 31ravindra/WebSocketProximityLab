//
//  Extension.swift
//  WebSocketProximity
//
//  Created by Ravindra Patidar on 26/06/21.
//

import Foundation
import UIKit

extension UIStoryboard {
    func instantiate<T>() -> T {
        return instantiateViewController(withIdentifier: String(describing: T.self)) as! T
    }

    static let main = UIStoryboard(name: "Main", bundle: nil)
}

extension String {

    func parse<D>(to type: D.Type) -> D? where D: Decodable {

        let data: Data = self.data(using: .utf8)!

        let decoder = JSONDecoder()

        do {
            let _object = try decoder.decode(type, from: data)
            return _object

        } catch {
            return nil
        }
    }
}



extension Date {
    func timeAgoDisplay() -> String {
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .full
        return formatter.localizedString(for: self, relativeTo: Date())
    }
}

