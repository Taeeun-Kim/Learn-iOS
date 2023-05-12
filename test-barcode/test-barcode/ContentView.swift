//
//  ContentView.swift
//  test-barcode
//
//  Created by Taeeun Kim on 08.05.23.
//

import AVFoundation
import SwiftUI

struct ContentView: View {
    @State private var barcodeData = ""

    var body: some View {
        VStack {
            CameraView(barcodeData: $barcodeData)
                .frame(maxWidth: .infinity, maxHeight: 300)
            
            Text("Barcode data: \(barcodeData)")
                .padding()
            
            Spacer()
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
struct CameraView: UIViewRepresentable {
    @Binding var barcodeData: String
    
  func makeUIView(context: Context) -> UIView {
      let captureSession = AVCaptureSession()
      guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else { return UIView() }
      let videoInput: AVCaptureDeviceInput
      do {
          videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
      } catch {
          return UIView()
      }
      
      if (captureSession.canAddInput(videoInput)) {
          captureSession.addInput(videoInput)
      } else {
          return UIView()
      }
      
      let metadataOutput = AVCaptureMetadataOutput()
      
      if (captureSession.canAddOutput(metadataOutput)) {
          captureSession.addOutput(metadataOutput)
          
          metadataOutput.setMetadataObjectsDelegate(context.coordinator, queue: DispatchQueue.main)
          metadataOutput.metadataObjectTypes = [.ean13, .ean8, .pdf417]
      } else {
          return UIView()
      }
      
      let previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
      previewLayer.videoGravity = .resizeAspectFill
      
      let cameraView = UIView(frame: CGRect.zero)
      cameraView.layer.addSublayer(previewLayer)
    
    DispatchQueue.main.async {
      previewLayer.frame = cameraView.bounds
    }

      
      DispatchQueue.global().async {
          captureSession.startRunning()
      }
    
      
      return cameraView
  }


    
    func updateUIView(_ uiView: UIView, context: Context) {
        // Do nothing
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, AVCaptureMetadataOutputObjectsDelegate {
        var parent: CameraView
        
        init(_ parent: CameraView) {
            self.parent = parent
        }
        
        func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
            guard let metadataObject = metadataObjects.first else {
                return
            }
            
            if let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject,
               let code = readableObject.stringValue {
                parent.barcodeData = code
            }
        }
    }
}
