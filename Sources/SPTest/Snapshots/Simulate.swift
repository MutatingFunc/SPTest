import SwiftUI

public extension View {
    @ViewBuilder
    func snapshot(_ device: SnapshotDevice, orientation: SnapshotDevice.Orientation = .portrait) -> some View {
        ExportButton(device: device, orientation: orientation) {
            self
                .simulate(device, orientation: orientation)
        }
    }
    
    @ViewBuilder
    func simulate(_ device: SnapshotDevice, orientation: SnapshotDevice.Orientation = .portrait) -> some View {
        let points = device.points(for: orientation)
        let inset = device.safeAreaInsets(for: orientation)
        let sizeClasses = device.sizeClasses(for: orientation)
        self
            .safeAreaPadding(.top, inset.top)
            .safeAreaPadding(.leading, inset.leading)
            .safeAreaPadding(.trailing, inset.trailing)
            .safeAreaPadding(.bottom, inset.bottom)
            .environment(\.displayScale, device.scale)
            .compositingGroup()
            .frame(width:  points.width, height: points.height)
            .ignoresSafeArea(.all, edges: .all)
            .fixedSize()
            .environment(\.horizontalSizeClass, sizeClasses.horizontal)
            .environment(\.verticalSizeClass, sizeClasses.vertical)
    }
}

#Preview("Snapshot") {
    Text("Hello world")
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background {
            Color.green
        }
        .background {
            Color.red.edgesIgnoringSafeArea(.all)
        }
        .snapshot(.iPhone8Plus)
}

#Preview("Simulate") {
    Text("Hello world")
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background {
            Color.green
        }
        .background {
            Color.red.edgesIgnoringSafeArea(.all)
        }
        .simulate(.iPhone8Plus)
}
