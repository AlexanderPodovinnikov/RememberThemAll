//
//  DetailedView.swift
//  RememberThemAll
//
//  Created by Alex Po on 07.06.2022.
//

import SwiftUI

struct DetailView: View {
    let currentPhoto: PresentedPhoto
    @State var isShowingMap = false
    //@State private var orientation = UIDevice.current.orientation //TODO
    
    var body: some View {
        NavigationView {
            VStack {
                Image(uiImage: currentPhoto.image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 350, height: 350)
                    .padding(.bottom)
                if currentPhoto.location != nil {
                    Button() {
                        isShowingMap.toggle()
                    } label: {
                        Text("View on the map")
                    }
                }
                Spacer()
            }
            .padding()
        }
        .navigationTitle(currentPhoto.name)
        // stacked
        .sheet(isPresented: $isShowingMap) {
            MapView(location: currentPhoto.location!)
                .padding([.leading,.trailing])
        }
    }
}

struct DetailedView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            DetailView(currentPhoto: PresentedPhoto.example)
                .previewInterfaceOrientation(.portrait)
                
        }
    }
}
