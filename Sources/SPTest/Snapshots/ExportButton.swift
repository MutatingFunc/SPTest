import SwiftUI

struct ExportButton<Content: View>: View {
    var device: SnapshotDevice
    var orientation: SnapshotDevice.Orientation
    @ViewBuilder var content: () -> Content
    @State private var snapshot: Snapshot? = nil
    
    var presentation: Binding<Bool> {
        Binding {
            snapshot != nil
        } set: { newValue in
            if !newValue {
                snapshot = nil
            }
        }
    }
    
    var body: some View {
        content()
            .overlay {
                VStack {
                    if let snapshot {
                        ShareLink(item: snapshot, preview: .init("Screenshot"))
                    } else {
                        Button {
                            export()
                        } label: {
                            Label("Snapshot", systemImage: "camera")
                        }
                    }
                }
                .buttonStyle(.borderedProminent)
                .fixedSize()
            }
    }
    
    @MainActor
    func export() {
        let renderer = ImageRenderer(content: content())
        renderer.proposedSize = .init(device.points(for: orientation))
        renderer.scale = device.scale
        if let image = renderer.uiImage {
            self.snapshot = Snapshot(image: image)
        } else {
            print("Failed to render")
        }
    }
}

private struct Snapshot: Transferable {
    var image: UIImage
    static var transferRepresentation: some TransferRepresentation {
        DataRepresentation(exportedContentType: .png) { snapshot in
            snapshot.image.pngData()!
        }.suggestedFileName("Snapshot")
    }
}

#Preview("Export") {
    ExportButton(device: .iPhone8Plus, orientation: .portrait) {
        Text("Hello world!")
    }
}
