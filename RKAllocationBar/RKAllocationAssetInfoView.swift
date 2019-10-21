//
//  RKAllocationAssetInfoView.swift
//  RKProgressBar
//
//  Created by Rajanikant shukla on 10/21/19.
//  Copyright © 2019 Rajanikant shukla. All rights reserved.
//

import UIKit

final internal class RKAllocationAssetInfoView: UIView {
    
    private lazy var container: UIView = {
        UIView()
    }()
    
    private lazy var indicatorView: UIView = {
        let indicatorView = UIView()
        indicatorView.backgroundColor = asset?.color
        indicatorView.layer.cornerRadius = kIndicatorSize/2
        indicatorView.layer.masksToBounds = true
        return indicatorView
    }()
    
    private lazy var infoViewLabel: UILabel = {
        let infoViewLabel = UILabel()
        return infoViewLabel
    }()
    
    private let kIndicatorSize: CGFloat = ChartConstants.defaultIndicatorSize
    private var asset: RKAllocationAssetModel?
    private var style: RKAllocationBar.AssetChartStyle?
    
    override func layoutSubviews() {
        super.layoutSubviews()
        needsUpdateConstraints()
    }
    
    private override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(asset: RKAllocationAssetModel, style: RKAllocationBar.AssetChartStyle) {
        self.init()
        self.asset = asset
        self.style = style
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension RKAllocationAssetInfoView {
    
    func setupConstraint() {
        container.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            container.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            container.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            container.topAnchor.constraint(equalTo: self.topAnchor),
            container.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            ])
        
        indicatorView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            indicatorView.widthAnchor.constraint(equalToConstant: kIndicatorSize),
            indicatorView.heightAnchor.constraint(equalToConstant: kIndicatorSize),
            indicatorView.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            indicatorView.centerYAnchor.constraint(equalTo: container.centerYAnchor),
            ])
        
        infoViewLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            infoViewLabel.leadingAnchor.constraint(equalTo: indicatorView.trailingAnchor, constant: 4),
            infoViewLabel.trailingAnchor.constraint(equalTo: container.trailingAnchor),
            infoViewLabel.topAnchor.constraint(equalTo: container.topAnchor),
            infoViewLabel.bottomAnchor.constraint(equalTo: container.bottomAnchor),
            ])
    }
    
    func setupView() {
        
        addSubview(container)
        container.addSubview(indicatorView)
        container.addSubview(infoViewLabel)
        
        setupConstraint()
        setupAccessibilityIds()
        setAssetData()
    }
    
    func setAssetData() {
        
        guard let asset = asset, let style = style else {
            return
        }
        
        let infoTitle = "\(asset.displayAssetShare) \(asset.assetName)"
        let attributes: [NSAttributedString.Key: Any] = [NSAttributedString.Key.font: style.assetValueFont,
                                                         NSAttributedString.Key.foregroundColor: style.assetValueTextColor]
        let extractedExpr = NSMutableAttributedString(string: infoTitle,
                                                      attributes:attributes)
        let attributedString = extractedExpr
        let newAttributes: [NSAttributedString.Key: Any] = [NSAttributedString.Key.font: style.assetNameFont,
                                                            NSAttributedString.Key.foregroundColor: style.assetNameTextColor]
        let range = (infoTitle as NSString).range(of: "\(asset.assetName)")
        attributedString.addAttributes(newAttributes, range: range)
        
        infoViewLabel.attributedText = attributedString
    }
    
    func setupAccessibilityIds() {
        indicatorView.accessibilityIdentifier = "kAIDAssetInfoIndicatorView"
        infoViewLabel.accessibilityIdentifier = "kAIDAssetInfoViewLabel"
    }
    
}
