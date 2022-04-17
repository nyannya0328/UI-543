//
//  Home.swift
//  UI-543
//
//  Created by nyannyan0328 on 2022/04/17.
//

import SwiftUI

struct Home: View {
    @StateObject var model = CameraViewModel()
    var body: some View {
      
          
        if model.isToken{
            
            VStack{
                
                Button {
                    
                    model.reTake()
                    
                } label: {
                    
                    
                    Image(systemName: "arrow.triangle.2.circlepath.camera.fill")
                        .foregroundColor(.black)
                        .padding()
                        .background(.white,in: Circle())
                }
                .frame(maxWidth:.infinity,alignment: .trailing)
                
                
                Spacer()
                
                
                Button {
                    
                    if !model.isSaved{model.savePick()}
                    
                } label: {
                    
                    
                    Text(model.isSaved ? "SAVED" : "Save")
                        .foregroundColor(.black)
                        .fontWeight(.bold)
                        .padding(.vertical,10)
                        .padding(.horizontal)
                        .background(.white,in:Capsule())
                       
                }
                
                .frame(maxWidth:.infinity,alignment: .leading)
                
                
                

            }
            .padding()
            
            
        }
        else{
            
            
            Button {
                
                model.takePic()
                
            } label: {
                
                ZStack{
                    
                    Circle()
                        .fill(.white)
                        .frame(width: 65, height: 65)
                    
                    
                    Circle()
                        .stroke(.white,lineWidth: 2)
                    
                        .frame(width: 75, height: 75)
                }
                .frame(maxHeight:.infinity,alignment: .bottom)
            }
            

        }
        
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
