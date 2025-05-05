//
//  WWLabel.swift
//  WWLabel
//
//  Created by William.Weng on 2025/5/5.
//

import UIKit

// MARK: - WWLabel
open class WWLabel: UILabel {
        
    private var timer: Timer?
    private var alphaArray: [Double] = []
    private var prefixString = String()
    private var loadingText = String()
    private var loadingTextColor: UIColor = .darkGray
    private var loadingFont: UIFont = .systemFont(ofSize: 17)
}

// MARK: - 公開函式
public extension WWLabel {
    
    /// 開始Loading文字
    /// - Parameters:
    ///   - text: 動作的字
    ///   - prefixString: 前綴文字
    ///   - textColor: 文字顏色
    ///   - timeInterval: 變化時間
    ///   - font: 文字字型
    /// - Returns: Bool
    func startLoadingText(_ text: String = "...", prefixString: String = "", textColor: UIColor = .darkGray, timeInterval: TimeInterval = 0.2, font: UIFont = .systemFont(ofSize: 17)) -> Bool {
        
        if text.isEmpty { return false }
        
        let count = text.count
        let unitAlpha = 1.0 / Double(count - 1)
        
        self.loadingText = text
        self.prefixString = prefixString
        self.loadingFont = font
        self.loadingTextColor = textColor
        self.alphaArray = []
        
        for index in 0..<count { alphaArray.append(unitAlpha * Double(index)) }
                
        timer = Timer.scheduledTimer(timeInterval: timeInterval, target: self, selector: #selector(Self.timerAction(timer:)), userInfo: nil, repeats: true)
        timer?.fire()
        
        return true
    }
    
    /// 停止Loading文字
    func stopLoadingText() {
        timer?.invalidate()
        timer = nil
    }
}

// MARK: - @objc
private extension WWLabel {
    
    /// 定時作用的功能
    /// - Parameter timer: Timer
    @objc func timerAction(timer: Timer) {
        attributedTextSetting(text: loadingText, prefixString: prefixString, loadingTextColor: loadingTextColor, loadingFont: loadingFont, alphaArray: &alphaArray)
    }
}

// MARK: - 小工具
private extension WWLabel {
        
    /// 設定Loading文字的透明度等…
    /// - Parameters:
    ///   - text: String
    ///   - prefixString: String
    ///   - loadingTextColor: UIColor
    ///   - loadingFont: UIFont
    ///   - alphaArray: inout [Double]
    func attributedTextSetting(text: String, prefixString: String, loadingTextColor: UIColor, loadingFont: UIFont, alphaArray: inout [Double]) {
        
        let displayText = prefixString + text
        let attributedString = NSMutableAttributedString(string: displayText)
        
        attributedString.addAttributes(
            [.foregroundColor: loadingTextColor, .font: loadingFont],
            range: NSRange(location: 0, length: displayText.count)
        )
        
        for index in 0..<alphaArray.count {
            
            let alpha = alphaArray[index]
            
            attributedString.addAttributes(
                [.foregroundColor: loadingTextColor.withAlphaComponent(alpha), .font: loadingFont],
                range: NSRange(location: index + prefixString.count, length: 1)
            )
        }
        
        attributedText = attributedString
        
        if let first = alphaArray.popLast() { alphaArray.insert(first, at: 0) }
    }
}
