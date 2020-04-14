// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

#if os(OSX)
  import AppKit.NSColor
  internal typealias Color = NSColor
#elseif os(iOS) || os(tvOS) || os(watchOS)
  import UIKit.UIColor
  internal typealias Color = UIColor
#endif

// swiftlint:disable superfluous_disable_command
// swiftlint:disable file_length

// MARK: - Colors

// swiftlint:disable identifier_name line_length type_body_length
internal struct ColorName {
  internal let rgbaValue: UInt32
  internal var color: Color { return Color(named: self) }

  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#f70d1a"></span>
  /// Alpha: 100% <br/> (0xf70d1aff)
  internal static let candyAppleRed = ColorName(rgbaValue: 0xf70d1aff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#1c1c1c"></span>
  /// Alpha: 100% <br/> (0x1c1c1cff)
  internal static let caparol = ColorName(rgbaValue: 0x1c1c1cff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#1fbcd2"></span>
  /// Alpha: 100% <br/> (0x1fbcd2ff)
  internal static let caribbeanBlue = ColorName(rgbaValue: 0x1fbcd2ff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#666666"></span>
  /// Alpha: 100% <br/> (0x666666ff)
  internal static let charcoal66 = ColorName(rgbaValue: 0x666666ff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#50595b"></span>
  /// Alpha: 100% <br/> (0x50595bff)
  internal static let charcoal70 = ColorName(rgbaValue: 0x50595bff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#999999"></span>
  /// Alpha: 100% <br/> (0x999999ff)
  internal static let charcoal99 = ColorName(rgbaValue: 0x999999ff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#f46f60"></span>
  /// Alpha: 100% <br/> (0xf46f60ff)
  internal static let coral = ColorName(rgbaValue: 0xf46f60ff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#a3d1da"></span>
  /// Alpha: 100% <br/> (0xa3d1daff)
  internal static let cyan = ColorName(rgbaValue: 0xa3d1daff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#333333"></span>
  /// Alpha: 100% <br/> (0x333333ff)
  internal static let darkCharcoal = ColorName(rgbaValue: 0x333333ff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#d93d5a"></span>
  /// Alpha: 100% <br/> (0xd93d5aff)
  internal static let darkRed = ColorName(rgbaValue: 0xd93d5aff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#a3a4a8"></span>
  /// Alpha: 100% <br/> (0xa3a4a8ff)
  internal static let grayChateau = ColorName(rgbaValue: 0xa3a4a8ff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#d8d8d8"></span>
  /// Alpha: 100% <br/> (0xd8d8d8ff)
  internal static let lightSilver = ColorName(rgbaValue: 0xd8d8d8ff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#01ffff"></span>
  /// Alpha: 100% <br/> (0x01ffffff)
  internal static let neon100 = ColorName(rgbaValue: 0x01ffffff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#d0021b"></span>
  /// Alpha: 100% <br/> (0xd0021bff)
  internal static let redEnergy100 = ColorName(rgbaValue: 0xd0021bff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#eae8ea"></span>
  /// Alpha: 100% <br/> (0xeae8eaff)
  internal static let shadeMagenta = ColorName(rgbaValue: 0xeae8eaff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#fff572"></span>
  /// Alpha: 100% <br/> (0xfff572ff)
  internal static let strikingYellow100 = ColorName(rgbaValue: 0xfff572ff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#00c5cd"></span>
  /// Alpha: 100% <br/> (0x00c5cdff)
  internal static let turquoiseSurf = ColorName(rgbaValue: 0x00c5cdff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#f5f5f5"></span>
  /// Alpha: 100% <br/> (0xf5f5f5ff)
  internal static let whiteSmoke = ColorName(rgbaValue: 0xf5f5f5ff)
}
// swiftlint:enable identifier_name line_length type_body_length

// MARK: - Implementation Details

// swiftlint:disable operator_usage_whitespace
internal extension Color {
  convenience init(rgbaValue: UInt32) {
    let red   = CGFloat((rgbaValue >> 24) & 0xff) / 255.0
    let green = CGFloat((rgbaValue >> 16) & 0xff) / 255.0
    let blue  = CGFloat((rgbaValue >>  8) & 0xff) / 255.0
    let alpha = CGFloat((rgbaValue      ) & 0xff) / 255.0

    self.init(red: red, green: green, blue: blue, alpha: alpha)
  }
}
// swiftlint:enable operator_usage_whitespace

internal extension Color {
  convenience init(named color: ColorName) {
    self.init(rgbaValue: color.rgbaValue)
  }
}
