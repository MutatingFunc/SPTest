import SwiftUI

public enum SnapshotDevice {
    case iPad13
    case iPad12_9Gen2
    case iPhone15Max
    case iPhone15
    case iPhone8Plus
    
    public enum Orientation {
        case portrait
        case landscape
    }
    
    var portraitPoints: CGSize {
        switch self {
        case .iPad13:
            CGSize(width: 1024, height: 1366)
        case .iPad12_9Gen2:
            CGSize(width: 1024, height: 1366)
        case .iPhone15Max:
            CGSize(width: 430, height: 932)
        case .iPhone15:
            CGSize(width: 393, height: 852)
        case .iPhone8Plus:
            CGSize(width: 414, height: 736)
        }
    }
    
    public func points(for orientation: Orientation) -> CGSize {
        let size = self.portraitPoints
        let isPortrait = orientation == .portrait
        return if isPortrait {
            size
        } else {
            CGSize(width: size.height, height: size.width)
        }
    }
    
    public var scale: Double {
        switch self {
        case .iPad13:
            2
        case .iPad12_9Gen2:
            2
        case .iPhone15Max:
            3
        case .iPhone15:
            3
        case .iPhone8Plus:
            3
        }
    }
    
    public func safeAreaInsets(for orientation: Orientation) -> EdgeInsets {
        switch (self, orientation == .portrait) {
        case (.iPad13, _):
            EdgeInsets(top: 24, leading: 0, bottom: 20, trailing: 0)
        case (.iPad12_9Gen2, _):
            EdgeInsets(top: 20, leading: 0, bottom: 0, trailing: 0)
        case (.iPhone15Max, true):
            EdgeInsets(top: 47, leading: 0, bottom: 34, trailing: 0)
        case (.iPhone15Max, false):
            EdgeInsets(top: 0, leading: 47, bottom: 21, trailing: 47)
        case (.iPhone15, true):
            EdgeInsets(top: 47, leading: 0, bottom: 34, trailing: 0)
        case (.iPhone15, false):
            EdgeInsets(top: 0, leading: 47, bottom: 21, trailing: 47)
        case (.iPhone8Plus, true):
            EdgeInsets(top: 20, leading: 0, bottom: 0, trailing: 0)
        case (.iPhone8Plus, false):
            EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        }
    }
    
    public func sizeClasses(for orientation: Orientation) -> (horizontal: UserInterfaceSizeClass, vertical: UserInterfaceSizeClass) {
        switch (self, orientation == .portrait) {
        case (.iPad13, _):
            (.regular, .regular)
        case (.iPad12_9Gen2, _):
            (.regular, .regular)
        case (.iPhone15Max, true):
            (.compact, .regular)
        case (.iPhone15Max, false):
            (.regular, .compact)
        case (.iPhone15, true):
            (.compact, .regular)
        case (.iPhone15, false):
            (.compact, .compact)
        case (.iPhone8Plus, true):
            (.compact, .regular)
        case (.iPhone8Plus, false):
            (.compact, .compact)
        }
    }
}
