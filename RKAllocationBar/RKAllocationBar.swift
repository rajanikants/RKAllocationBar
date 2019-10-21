//
//  RKAllocationBar.swift
//  RKProgressBar
//
//  Created by Rajanikant shukla on 10/21/19.
//  Copyright © 2019 Rajanikant shukla. All rights reserved.
//

import UIKit

final public class RKAllocationBar: UIView {
    
    private lazy var chartView:UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var containerView:UIView = {
        let containerView = UIView()
        containerView.backgroundColor = .clear
        return containerView
    }()
    
    private lazy var chartContainer:UIView = {
        let chartContainer = UIView()
        chartContainer.backgroundColor = .clear
        return chartContainer
    }()
    
    // type and style variables
    private var style: AssetChartStyle
    private var assetChartType: AssetChartType
    
    //decision making variables
    private var isSorted: Bool = false
    private var showAssetDistributionInfo: Bool = false
    
    //Data variables
    private var assetList: [RKAllocationAssetModel]?
    private var asset: RKAllocationAssetModel?
    
    //dimension variables
    private var singleAssetChartHeight:CGFloat = ChartConstants.defaultChartHeight
    private let kMaxElementsInARow: Int = ChartConstants.maxElementsInRow
    private var totalShare: CGFloat = ChartConstants.defaultShare
    
    //read only custom property
    private var assetChartHeight: CGFloat {
        return assetChartType == .MultiAssets ? style.chartHeight : singleAssetChartHeight
    }
    
    //chart type enum
    private enum AssetChartType {
        case MultiAssets
        case SingleAsset
    }
    
   //MARK:- Lifecycle methods
    override public func layoutSubviews() {
        super.layoutSubviews()
        renderChartView()
    }
    
    public init(withMultiAsset assetList: [RKAllocationAssetModel], style: AssetChartStyle, assetCategoryInfo: Bool, showSorted: Bool = false) {
        self.assetList = assetList
        self.assetChartType = .MultiAssets
        self.style = style
        self.isSorted = showSorted
        self.showAssetDistributionInfo = assetCategoryInfo
        super.init(frame: .zero)
        setupView()
        setupConstraints()
    }
    
    public init(withSingleAsset asset: RKAllocationAssetModel, height: CGFloat) {
        self.assetChartType = .SingleAsset
        self.singleAssetChartHeight = height
        self.asset = asset
        self.style = AssetChartStyle.default()
        super.init(frame: .zero)
        setupView()
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK:- setup methods
private extension RKAllocationBar {
    
    func setupConstraints() {
        
        containerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            containerView.topAnchor.constraint(equalTo: self.topAnchor),
            containerView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            ])
        
        chartContainer.translatesAutoresizingMaskIntoConstraints = false
        
        // set  height of progress bar
        NSLayoutConstraint.activate([
            chartContainer.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            chartContainer.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            chartContainer.topAnchor.constraint(equalTo: containerView.topAnchor),
            chartContainer.heightAnchor.constraint(equalToConstant: assetChartHeight),
            ])
        
        switch assetChartType {
        case .SingleAsset:
            
            chartView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                chartView.bottomAnchor.constraint(equalTo: chartContainer.bottomAnchor),
                chartView.topAnchor.constraint(equalTo: chartContainer.topAnchor),
                chartView.leadingAnchor.constraint(equalTo: chartContainer.leadingAnchor),
                chartContainer.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
                ])
            
        case .MultiAssets:
            
            if showAssetDistributionInfo ==  false{
                let constraint = chartContainer.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
                constraint.isActive = true
            }
        }
        
    }
    
    func renderChartView()  {
        
        switch assetChartType {
        case .SingleAsset:
            
            // create progressbar
            guard let assetInfo = self.asset else { return }
            
            //get the actual fill width against chart container
            let assetChartFillWidth = actualWidth(assetShare: assetInfo.assetShare, totalShare: totalShare)
            let width = chartView.widthAnchor.constraint(equalToConstant: assetChartFillWidth)
            width.isActive = true
            
        case .MultiAssets:
            // create multi asset chart bar
            guard var assets = self.assetList else { return }
            
            //set total share value
            setTotalShare(assets: assets)
            
            if isSorted {
                assets = sortedAssets(assets: assets)
            }
            
            var xCoordinate: CGFloat = 0
            
            for (index, value) in assets.enumerated() {
                let width = generateBar(asset: value, xCoordinate: xCoordinate, container: chartContainer, addSeperator: index < assets.count-1 && style.showSeperator)
                xCoordinate += width
            }
        }
        
    }
    
    func setupView() {
        
        print("Called")
        subviews.forEach { $0.removeFromSuperview() }
        
        addSubview(containerView)
        
        containerView.addSubview(chartContainer)
        
        switch assetChartType {
        case .SingleAsset:
            
            // create progressbar
            guard let assetInfo = self.asset else { return }
            
            //create actual chart bar view
            chartView.backgroundColor = assetInfo.color
            chartView.layer.cornerRadius = assetChartHeight/2
            chartView.layer.masksToBounds = true
            
            chartContainer.addSubview(chartView)
            
        case .MultiAssets:
            
            chartContainer.layer.cornerRadius = assetChartHeight/2
            chartContainer.layer.masksToBounds = true
            
            // create multi asset chart bar
            guard let assets = self.assetList else { return }
            
            if showAssetDistributionInfo {
                setupAssetInformationView(assets: assets, containerView: containerView, chartContainer: chartContainer)
            }
        }
    }
    
    func setupAssetInformationView(assets: [RKAllocationAssetModel], containerView:UIView, chartContainer:UIView) {
        //information view
        let informationContainer = UIView()
        containerView.addSubview(informationContainer)
        
        informationContainer.accessibilityIdentifier = "kAIDAssetInformationContainerView"
        informationContainer.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            informationContainer.topAnchor.constraint(equalTo: chartContainer.bottomAnchor, constant: style.spaceBetweenChartAndInfo),
            informationContainer.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            informationContainer.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            informationContainer.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            ])
        
        createInformationView(parentView: informationContainer, assetsArray: assets)
    }
    
    @discardableResult func generateBar(asset: RKAllocationAssetModel, xCoordinate: CGFloat, container: UIView, addSeperator: Bool) -> CGFloat {
        
        let assetChartFillWidth = chartFillWidth(assetShare: asset.assetShare)
        let chartView = UIView()
        chartView.backgroundColor = asset.color
        container.addSubview(chartView)
        
        chartView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            chartView.topAnchor.constraint(equalTo: container.topAnchor),
            chartView.bottomAnchor.constraint(equalTo: container.bottomAnchor),
            chartView.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: xCoordinate),
            chartView.widthAnchor.constraint(equalToConstant: assetChartFillWidth),
            ])
        
        //append seperator
        if addSeperator{
            let seperatorView = UIView()
            seperatorView.backgroundColor = style.seperatorColor
            container.addSubview(seperatorView)
            
            seperatorView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                seperatorView.topAnchor.constraint(equalTo: container.topAnchor),
                seperatorView.bottomAnchor.constraint(equalTo: container.bottomAnchor),
                seperatorView.trailingAnchor.constraint(equalTo: chartView.trailingAnchor),
                seperatorView.widthAnchor.constraint(equalToConstant: ChartConstants.defaultSeperatorWidth),
                ])
        }
        
        return assetChartFillWidth
    }
    
    
    func createInformationView(parentView: UIView, assetsArray: [RKAllocationAssetModel]) {
        
        let stackView = UIStackView()
        stackView.alignment = .fill
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = style.spaceBetweenInfoRows
        
        parentView.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: parentView.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: parentView.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: parentView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: parentView.trailingAnchor),
            ])
        
        var stack = getAssetStack()
        stackView.addArrangedSubview(stack)
        var count = 1
        for asset in assetsArray {
            stack = addAssetWithStack(count: &count, asset: asset, innerStack: stack, outerStack: stackView)
            count += 1
        }
    }
    
    @discardableResult func addAssetWithStack(count: inout Int, asset: RKAllocationAssetModel, innerStack: UIStackView, outerStack: UIStackView) -> UIStackView {
        
        var stack: UIStackView = innerStack
        
        if count > kMaxElementsInARow {
            count = 1
            stack = self.getAssetStack()
            outerStack.addArrangedSubview(stack)
        }
        
        let infoView = RKAllocationAssetInfoView(asset: asset, style: style)
        stack.addArrangedSubview(infoView)
        infoView.accessibilityIdentifier = "kAIDAssetInfoView"
        
        return stack
    }
    
    func getAssetStack() -> UIStackView {
        let stack = UIStackView()
        stack.alignment = .leading
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.spacing = style.spaceBetweenInfoColumns
        return stack
    }
}

//MARK:- Utility methods
private extension RKAllocationBar {
    
    func chartFillWidth(assetShare: Double) -> CGFloat{
        var width = actualWidth(assetShare: assetShare, totalShare: totalShare)
        if width < style.minimumAssetWidth{
            width = style.minimumAssetWidth
        }
        return width
    }
    
    func actualWidth(assetShare: Double, totalShare: CGFloat) -> CGFloat {
        return (frame.size.width * CGFloat(abs(assetShare))) / totalShare
    }
    
    func sortedAssets(assets: [RKAllocationAssetModel]) -> [RKAllocationAssetModel] {
        let sortedAssets = assets.sorted(by: { (asset1, asset2) -> Bool in
            asset1.assetShare > asset2.assetShare
        })
        return sortedAssets
    }
    
    func setTotalShare(assets: [RKAllocationAssetModel]) {
        var total: CGFloat = 0
        for asset in assets {
            total += CGFloat(abs(asset.assetShare))
        }
        
        totalShare = total
        
        //update if any asset width is below than minimum required width
        updateTotalShareIfRequired(assets: assets)
    }
    
    func updateTotalShareIfRequired(assets: [RKAllocationAssetModel]) {
        
        var currentTotalShare = totalShare
        
        //update total share if any asset share is below than minimum asset share width
        let onePixelShare = currentTotalShare/frame.size.width
        for asset in assets {
            let width = actualWidth(assetShare: asset.assetShare, totalShare: totalShare)
            if width < style.minimumAssetWidth{
                currentTotalShare -= (width * onePixelShare)
                currentTotalShare += (style.minimumAssetWidth * onePixelShare)
            }
        }
        
        totalShare = currentTotalShare
    }
}

