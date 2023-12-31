//
// This is a generated file, do not edit!
// Generated by R.swift, see https://github.com/mac-cain13/R.swift
//

import Foundation
import RswiftResources
import UIKit

private class BundleFinder {}
let R = _R(bundle: Bundle(for: BundleFinder.self))

struct _R {
  let bundle: Foundation.Bundle
  var color: color { .init(bundle: bundle) }
  var image: image { .init(bundle: bundle) }
  var storyboard: storyboard { .init(bundle: bundle) }

  func color(bundle: Foundation.Bundle) -> color {
    .init(bundle: bundle)
  }
  func image(bundle: Foundation.Bundle) -> image {
    .init(bundle: bundle)
  }
  func storyboard(bundle: Foundation.Bundle) -> storyboard {
    .init(bundle: bundle)
  }
  func validate() throws {
    try self.storyboard.validate()
  }


  /// This `_R.color` struct is generated, and contains static references to 1 colors.
  struct color {
    let bundle: Foundation.Bundle

    /// Color `AccentColor`.
    var accentColor: RswiftResources.ColorResource { .init(name: "AccentColor", path: [], bundle: bundle) }
  }

  /// This `_R.image` struct is generated, and contains static references to 10 images.
  struct image {
    let bundle: Foundation.Bundle

    /// Image `next`.
    var next: RswiftResources.ImageResource { .init(name: "next", path: [], bundle: bundle, locale: nil, onDemandResourceTags: nil) }

    /// Image `number-1`.
    var number1: RswiftResources.ImageResource { .init(name: "number-1", path: [], bundle: bundle, locale: nil, onDemandResourceTags: nil) }

    /// Image `number-2`.
    var number2: RswiftResources.ImageResource { .init(name: "number-2", path: [], bundle: bundle, locale: nil, onDemandResourceTags: nil) }

    /// Image `number-3`.
    var number3: RswiftResources.ImageResource { .init(name: "number-3", path: [], bundle: bundle, locale: nil, onDemandResourceTags: nil) }

    /// Image `number-4`.
    var number4: RswiftResources.ImageResource { .init(name: "number-4", path: [], bundle: bundle, locale: nil, onDemandResourceTags: nil) }

    /// Image `number-5`.
    var number5: RswiftResources.ImageResource { .init(name: "number-5", path: [], bundle: bundle, locale: nil, onDemandResourceTags: nil) }

    /// Image `number-6`.
    var number6: RswiftResources.ImageResource { .init(name: "number-6", path: [], bundle: bundle, locale: nil, onDemandResourceTags: nil) }

    /// Image `number-7`.
    var number7: RswiftResources.ImageResource { .init(name: "number-7", path: [], bundle: bundle, locale: nil, onDemandResourceTags: nil) }

    /// Image `number-8`.
    var number8: RswiftResources.ImageResource { .init(name: "number-8", path: [], bundle: bundle, locale: nil, onDemandResourceTags: nil) }

    /// Image `number-9`.
    var number9: RswiftResources.ImageResource { .init(name: "number-9", path: [], bundle: bundle, locale: nil, onDemandResourceTags: nil) }
  }

  /// This `_R.storyboard` struct is generated, and contains static references to 2 storyboards.
  struct storyboard {
    let bundle: Foundation.Bundle
    var launchScreen: launchScreen { .init(bundle: bundle) }
    var main: main { .init(bundle: bundle) }

    func launchScreen(bundle: Foundation.Bundle) -> launchScreen {
      .init(bundle: bundle)
    }
    func main(bundle: Foundation.Bundle) -> main {
      .init(bundle: bundle)
    }
    func validate() throws {
      try self.launchScreen.validate()
      try self.main.validate()
    }


    /// Storyboard `LaunchScreen`.
    struct launchScreen: RswiftResources.StoryboardReference, RswiftResources.InitialControllerContainer {
      typealias InitialController = UIKit.UIViewController

      let bundle: Foundation.Bundle

      let name = "LaunchScreen"
      func validate() throws {

      }
    }

    /// Storyboard `Main`.
    struct main: RswiftResources.StoryboardReference, RswiftResources.InitialControllerContainer {
      typealias InitialController = GameViewController

      let bundle: Foundation.Bundle

      let name = "Main"
      func validate() throws {

      }
    }
  }
}