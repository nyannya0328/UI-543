//
//  CameraViewModel.swift
//  UI-543
//
//  Created by nyannyan0328 on 2022/04/17.
//

import SwiftUI
import AVFoundation

class CameraViewModel:NSObject, ObservableObject,AVCapturePhotoCaptureDelegate {
    @Published var isToken : Bool = false
    @Published var session = AVCaptureSession()
    @Published var alert : Bool = false
    
    @Published var outPut = AVCapturePhotoOutput()
    @Published var preView : AVCaptureVideoPreviewLayer!
    
    @Published var isSaved : Bool = false
    @Published var picData : Data = Data(count: 0)
    
    
    func check(){
        
        switch AVCaptureDevice.authorizationStatus(for: .video){
            
        case.authorized :
            setUP()
            return
            
        case .notDetermined : AVCaptureDevice.requestAccess(for: .video) { (status) in
            if status{
                
                
                self.setUP()
            }
            
            
            
        }
            
        case.denied : self.alert.toggle()
            return
            
    
        default : return
            
        }
        
        
        
        
    }
    
    func setUP(){
        
        
        do{
            
            self.session.beginConfiguration()
            
            let device = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back)
            
            let input = try AVCaptureDeviceInput(device: device!)
            
            if self.session.canAddInput(input){
                
                
                self.session.addInput(input)
            }
            
            if self.session.canAddOutput(self.outPut){
                
                
                self.session.canAddOutput(self.outPut)
            }
            self.session.commitConfiguration()
            
            
        }
        catch{
            
            print(error.localizedDescription)
        }
        
        
    }
    
    func takePic(){
        
        
        DispatchQueue.global(qos: .background).async {
            
            
            self.outPut.capturePhoto(with: AVCapturePhotoSettings(), delegate: self)
            self.session.startRunning()
            
            
            DispatchQueue.main.async {
                
                withAnimation{
                    
                    self.isToken.toggle()
                }
                
            }
        }
    }
    
    func reTake(){
        
        DispatchQueue.global(qos: .background).async {
            
            self.session.startRunning()
            
            
            DispatchQueue.main.async {
                
                withAnimation{
                    self.isToken.toggle()
                }
            }
            self.isSaved = false
            
        }
    }
    
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        
        
        if error != nil{return}
        
        
        guard let imageData = photo.fileDataRepresentation() else{return}
        
        
        self.picData = imageData
    }
    
    func savePick(){
        
        let image = UIImage(data: self.picData)!
        
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
        
        self.isSaved = true
        
    }
    
}


