//
//  CameraPreView.swift
//  UI-543
//
//  Created by nyannyan0328 on 2022/04/17.
//

import SwiftUI
import AVKit

struct CameraPreView: UIViewRepresentable {
    @EnvironmentObject var model : CameraViewModel
    func makeUIView(context: Context) -> some UIView {
        
        let view = UIView(frame: UIScreen.main.bounds)
        model.preView = AVCaptureVideoPreviewLayer(session: model.session)
        
        model.preView.frame = view.frame
        model.preView.videoGravity = .resizeAspectFill
        view.layer.addSublayer(model.preView)
        model.session.startRunning()
        
        
        return view
        
    }
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
        
    }
}


