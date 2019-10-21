//
//  ViewController.swift
//  RKProgressBar
//
//  Created by Rajanikant shukla on 10/21/19.
//  Copyright © 2019 Rajanikant shukla. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //customized
        let assets = fetchStubAssetAllocationViewModels()
        let style =  RKAllocationBar.AssetChartStyle.default().withChartHeightt(10)
                                                                    .withShowSeperator(true)
                                                                    .withMinimumAssetWidth(3)
                                                                    .withSeperatorWidth(2)
                                                                    .withAssetNameFont(UIFont.systemFont(ofSize: 14))
                                                                    .withAssetValueFont(UIFont.boldSystemFont(ofSize: 14))
        
        let assetChart1 = RKAllocationBar(withMultiAsset: assets, style: style, assetCategoryInfo: true)
        
        view.addSubview(assetChart1)

        assetChart1.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            assetChart1.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            assetChart1.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            assetChart1.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            ])
        
    }
    
    //TODO: This method will be removed after API integration
    private func fetchStubAssetAllocationViewModels() -> [RKAllocationAssetModel] {
        let assetColors = UIColor.charColors
        
        let assets = [[
            "assetName" : "Asset A",
            "weighting" : "64.05",
            "id" : "Stock"
            ],
                      [
                        "assetName" : "Asset B",
                        "weighting" : "6.45",
                        "id" : "UT"
            ],
                      [
                        "assetName" : "Asset C",
                        "weighting" : "9.50",
                        "id" : "Bond"
            ],
                      [
                        "assetName" : "Asset D",
                        "weighting" : "19.80",
                        "id" : "CLI"
            ],
                      [
                        "assetName" : "Asset E",
                        "weighting" : "0.20",
                        "id" : "New"
            ]
        ]
        
        let stockJson = assets[0]
        let bondJson = assets[1]
        let utJson = assets[2]
        let cliJson = assets[3]
        let new = assets[4]
        
        let stockModel = RKAllocationAssetModel(assetName: stockJson["assetName"] ?? "", assetShare: Double(stockJson["weighting"] ?? "0") ?? 0, displayAssetShare: "+64.05%", assetID: stockJson["id"] ?? "", color: assetColors[0])
        let bondModel = RKAllocationAssetModel(assetName: bondJson["assetName"] ?? "", assetShare: Double(bondJson["weighting"] ?? "0") ?? 0, displayAssetShare: "+6.45%", assetID: bondJson["id"] ?? "", color: assetColors[1])
        let utModel = RKAllocationAssetModel(assetName: utJson["assetName"] ?? "", assetShare: Double(utJson["weighting"] ?? "0") ?? 0, displayAssetShare: "+9.50%", assetID: utJson["id"] ?? "", color: assetColors[2])
        let cliModel = RKAllocationAssetModel(assetName: cliJson["assetName"] ?? "", assetShare: Double(cliJson["weighting"] ?? "0") ?? 0, displayAssetShare: "+19.80%", assetID: cliJson["id"] ?? "", color: assetColors[3])
        let newModel = RKAllocationAssetModel(assetName: new["assetName"] ?? "", assetShare: Double(new["weighting"] ?? "0") ?? 0, displayAssetShare: "+0.20%", assetID: new["id"] ?? "", color: assetColors[4])
        
        
        return [stockModel, bondModel, utModel, cliModel, newModel]
    }
}


