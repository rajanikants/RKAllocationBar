//
//  RKAllocationAssetModel.swift
//  RKProgressBar
//
//  Created by Rajanikant shukla on 10/21/19.
//  Copyright © 2019 Rajanikant shukla. All rights reserved.
//

import UIKit

public struct RKAllocationAssetModel {
    public let assetName: String
    public let assetShare: Double
    public let displayAssetShare: String
    public let assetID: String?
    public let color: UIColor
    
    public init(assetName: String, assetShare: Double, displayAssetShare: String, assetID: String? = nil, color: UIColor) {
        self.assetName = assetName
        self.assetShare = assetShare
        self.color = color
        self.assetID = assetID
        self.displayAssetShare = displayAssetShare
    }
    
}


