// swiftlint:disable all
// swift-format-ignore-file
// swiftformat:disable all
// Generated using tuist — https://github.com/tuist/tuist

#if os(macOS)
  import AppKit
#elseif os(iOS)
  import UIKit
#elseif os(tvOS) || os(watchOS)
  import UIKit
#endif
#if canImport(SwiftUI)
  import SwiftUI
#endif

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Asset Catalogs

// swiftlint:disable identifier_name line_length nesting type_body_length type_name
public enum GlogAsset {
  public enum Colors {
    public static let paperBackgroundColor = GlogColors(name: "Paper_BackgroundColor")
    public static let paperBlankColor = GlogColors(name: "Paper_BlankColor")
    public static let paperEndColor = GlogColors(name: "Paper_EndColor")
    public static let paperErrorColor = GlogColors(name: "Paper_ErrorColor")
    public static let paperShadowColor = GlogColors(name: "Paper_ShadowColor")
    public static let paperStartColor = GlogColors(name: "Paper_StartColor")
    public static let paperGrayColor = GlogColors(name: "Paper_grayColor")
  }
  public enum Images {
    public static let paperBackground = GlogImages(name: "Paper_Background")
    public static let paperBlackLogo = GlogImages(name: "Paper_BlackLogo")
    public static let paperHitLogo = GlogImages(name: "Paper_HitLogo")
    public static let paperLikeLogo = GlogImages(name: "Paper_LikeLogo")
    public static let paperMainLogo = GlogImages(name: "Paper_MainLogo")
    public static let paperProfileLogo = GlogImages(name: "Paper_ProfileLogo")
    public static let paperRocket = GlogImages(name: "Paper_Rocket")
    public static let paperStatusLogo = GlogImages(name: "Paper_StatusLogo")
  }
}
// swiftlint:enable identifier_name line_length nesting type_body_length type_name

// MARK: - Implementation Details

public final class GlogColors {
  public fileprivate(set) var name: String

  #if os(macOS)
  public typealias Color = NSColor
  #elseif os(iOS) || os(tvOS) || os(watchOS)
  public typealias Color = UIColor
  #endif

  @available(iOS 11.0, tvOS 11.0, watchOS 4.0, macOS 10.13, *)
  public private(set) lazy var color: Color = {
    guard let color = Color(asset: self) else {
      fatalError("Unable to load color asset named \(name).")
    }
    return color
  }()

  #if canImport(SwiftUI)
  private var _swiftUIColor: Any? = nil
  @available(iOS 13.0, tvOS 13.0, watchOS 6.0, macOS 10.15, *)
  public private(set) var swiftUIColor: SwiftUI.Color {
    get {
      if self._swiftUIColor == nil {
        self._swiftUIColor = SwiftUI.Color(asset: self)
      }

      return self._swiftUIColor as! SwiftUI.Color
    }
    set {
      self._swiftUIColor = newValue
    }
  }
  #endif

  fileprivate init(name: String) {
    self.name = name
  }
}

public extension GlogColors.Color {
  @available(iOS 11.0, tvOS 11.0, watchOS 4.0, macOS 10.13, *)
  convenience init?(asset: GlogColors) {
    let bundle = GlogResources.bundle
    #if os(iOS) || os(tvOS)
    self.init(named: asset.name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    self.init(named: NSColor.Name(asset.name), bundle: bundle)
    #elseif os(watchOS)
    self.init(named: asset.name)
    #endif
  }
}

#if canImport(SwiftUI)
@available(iOS 13.0, tvOS 13.0, watchOS 6.0, macOS 10.15, *)
public extension SwiftUI.Color {
  init(asset: GlogColors) {
    let bundle = GlogResources.bundle
    self.init(asset.name, bundle: bundle)
  }
}
#endif

public struct GlogImages {
  public fileprivate(set) var name: String

  #if os(macOS)
  public typealias Image = NSImage
  #elseif os(iOS) || os(tvOS) || os(watchOS)
  public typealias Image = UIImage
  #endif

  public var image: Image {
    let bundle = GlogResources.bundle
    #if os(iOS) || os(tvOS)
    let image = Image(named: name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    let image = bundle.image(forResource: NSImage.Name(name))
    #elseif os(watchOS)
    let image = Image(named: name)
    #endif
    guard let result = image else {
      fatalError("Unable to load image asset named \(name).")
    }
    return result
  }

  #if canImport(SwiftUI)
  @available(iOS 13.0, tvOS 13.0, watchOS 6.0, macOS 10.15, *)
  public var swiftUIImage: SwiftUI.Image {
    SwiftUI.Image(asset: self)
  }
  #endif
}

public extension GlogImages.Image {
  @available(macOS, deprecated,
    message: "This initializer is unsafe on macOS, please use the GlogImages.image property")
  convenience init?(asset: GlogImages) {
    #if os(iOS) || os(tvOS)
    let bundle = GlogResources.bundle
    self.init(named: asset.name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    self.init(named: NSImage.Name(asset.name))
    #elseif os(watchOS)
    self.init(named: asset.name)
    #endif
  }
}

#if canImport(SwiftUI)
@available(iOS 13.0, tvOS 13.0, watchOS 6.0, macOS 10.15, *)
public extension SwiftUI.Image {
  init(asset: GlogImages) {
    let bundle = GlogResources.bundle
    self.init(asset.name, bundle: bundle)
  }

  init(asset: GlogImages, label: Text) {
    let bundle = GlogResources.bundle
    self.init(asset.name, bundle: bundle, label: label)
  }

  init(decorative asset: GlogImages) {
    let bundle = GlogResources.bundle
    self.init(decorative: asset.name, bundle: bundle)
  }
}
#endif

// swiftlint:enable all
// swiftformat:enable all
