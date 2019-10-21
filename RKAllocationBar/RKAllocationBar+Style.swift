//
//  RKAllocationBar+Style.swift
//  RKProgressBar
//
//  Created by Rajanikant shukla on 10/21/19.
//  Copyright © 2019 Rajanikant shukla. All rights reserved.
//

import UIKit

extension RKAllocationBar {
    
    public struct AssetChartStyle {
        private let defaults: DefaultProperties
        private var overrides: ConfigurableProperties
        
        // MARK: Internal Methods
        
        init(defaults: DefaultProperties) {
            self.defaults = defaults
            
            overrides = ConfigurableProperties(assetNameFont: defaults.assetNameFont, assetValueFont: defaults.assetValueFont, assetNameTextColor: defaults.assetNameTextColor, assetValueTextColor: defaults.assetValueTextColor, showSeperator: defaults.showSeperator, seperatorColor: defaults.seperatorColor, seperatorWidth: defaults.seperatorWidth, minimumAssetWidth: defaults.minimumAssetWidth, chartHeight: defaults.chartHeight, spaceBetweenChartAndInfo: defaults.spaceBetweenChartAndInfo, spaceBetweenInfoRows: defaults.spaceBetweenInfoRows)
        }
        
        // MARK: Public Methods (Builder)
        
        public static func `default`() -> AssetChartStyle {
            let defaultProperties = DefaultProperties()
            return AssetChartStyle(defaults: defaultProperties)
        }
        
        public func withAssetNameFont(_ font: UIFont) -> AssetChartStyle {
            var style = self
            style.overrides.assetNameFont = font
            return style
        }
        
        public func withAssetValueFont(_ font: UIFont) -> AssetChartStyle {
            var style = self
            style.overrides.assetValueFont = font
            return style
        }
        
        public func withAssetNameTextColor(_ color: UIColor) -> AssetChartStyle {
            var style = self
            style.overrides.assetNameTextColor = color
            return style
        }
        
        public func withAssetValueTextColor(_ color: UIColor)  -> AssetChartStyle {
            var style = self
            style.overrides.assetValueTextColor = color
            return style
        }
        
        public func withShowSeperator(_ show: Bool) -> AssetChartStyle {
            var style = self
            style.overrides.showSeperator = show
            return style
        }
        
        public func withSeperatorColor(_ color: UIColor) -> AssetChartStyle {
            var style = self
            style.overrides.seperatorColor = color
            return style
        }
        
        public func withSeperatorWidth(_ width: CGFloat) -> AssetChartStyle {
            var style = self
            style.overrides.seperatorWidth = width
            return style
        }
        
        public func withMinimumAssetWidth(_ width: CGFloat) -> AssetChartStyle {
            var style = self
            style.overrides.minimumAssetWidth = width
            return style
        }
        
        public func withChartHeightt(_ height: CGFloat) -> AssetChartStyle {
            var style = self
            style.overrides.chartHeight = height
            return style
        }
        
        public func withSpaceBetweenChartAndInfo(_ space: CGFloat) -> AssetChartStyle {
            var style = self
            style.overrides.spaceBetweenChartAndInfo = space
            return style
        }
        
        public func withSpaceBetweenInfoRows(_ space: CGFloat) -> AssetChartStyle {
            var style = self
            style.overrides.spaceBetweenInfoRows = space
            return style
        }
        
    }
}

// MARK: - AssetAllocationChart.AssetChartStyle defaults

extension RKAllocationBar.AssetChartStyle {
    var assetNameFont: UIFont {
        return overrides.assetNameFont
    }
    
    var assetValueFont: UIFont {
        return overrides.assetValueFont
    }
    
    var assetNameTextColor: UIColor {
        return overrides.assetNameTextColor
    }
    
    var assetValueTextColor: UIColor {
        return overrides.assetValueTextColor
    }
    
    var showSeperator: Bool {
        return overrides.showSeperator
    }
    
    var seperatorColor: UIColor {
        return overrides.seperatorColor
    }
    
    var seperatorWidth: CGFloat {
        return overrides.seperatorWidth
    }
    
    var minimumAssetWidth: CGFloat {
        return overrides.minimumAssetWidth
    }
    
    var chartHeight: CGFloat {
        return overrides.chartHeight
    }
    
    var spaceBetweenChartAndInfo: CGFloat {
        return overrides.spaceBetweenChartAndInfo
    }
    
    var spaceBetweenInfoRows: CGFloat {
        return overrides.spaceBetweenInfoRows
    }
    
    var spaceBetweenInfoColumns: CGFloat {
        return defaults.spaceBetweenInfoCoulmns
    }
    
    // MARK: Custom Types
    
    // swiftlint:disable nesting
    
    struct DefaultProperties {
        var assetNameFont: UIFont = UIFont.systemFont(ofSize: 14)
        var assetValueFont: UIFont = UIFont.systemFont(ofSize: 14)
        var assetNameTextColor: UIColor = UIColor.black
        var assetValueTextColor: UIColor = UIColor.black
        var showSeperator: Bool = false
        var seperatorColor: UIColor = .white
        var seperatorWidth: CGFloat = ChartConstants.defaultSeperatorWidth
        var minimumAssetWidth: CGFloat = ChartConstants.defaultMinimumWidth
        var chartHeight: CGFloat = ChartConstants.defaultChartHeight
        var spaceBetweenChartAndInfo: CGFloat = ChartConstants.containerPadding
        var spaceBetweenInfoRows: CGFloat = ChartConstants.defaultInfoRowsPadding
        var spaceBetweenInfoCoulmns: CGFloat = ChartConstants.defaultInfoColumnsPadding
    }
    
    struct ConfigurableProperties {
        var assetNameFont: UIFont
        var assetValueFont: UIFont
        var assetNameTextColor: UIColor
        var assetValueTextColor: UIColor
        var showSeperator: Bool
        var seperatorColor: UIColor
        var seperatorWidth: CGFloat
        var minimumAssetWidth: CGFloat
        var chartHeight: CGFloat
        var spaceBetweenChartAndInfo: CGFloat
        var spaceBetweenInfoRows: CGFloat
    }
    
    // swiftlint: enable nesting
}


