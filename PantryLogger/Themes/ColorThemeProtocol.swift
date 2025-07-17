//
//  ColorThemeProtocol.swift
//  PantryLogger
//
//  Created by Cameron Williams on 7/16/25.
//

import SwiftUI

protocol ColorThemeProtocol {
    var fresh: Color { get }
    var soon: Color { get }
    var asap: Color { get }
    var expired: Color { get }
}
