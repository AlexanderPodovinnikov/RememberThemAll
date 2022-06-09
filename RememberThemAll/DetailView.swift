//
//  DetailedView.swift
//  RememberThemAll
//
//  Created by Alex Po on 07.06.2022.
//

import SwiftUI

struct DetailView: View {
    var currentPhoto: PresentedPhoto
    //@State private var orientation = UIDevice.current.orientation //TODO
    
    var body: some View {
        GeometryReader {geo in
            let hSize = geo.size.height // not good
            let vSize = geo.size.width // not good
            VStack {
                Image(uiImage: currentPhoto.image)
                    .resizable()
                    .scaledToFit()
                    .frame(
                        width: hSize > vSize ? geo.size.width - 40 : geo.size.height / 3 * 2,
                        height: hSize > vSize ? geo.size.width - 40 : geo.size.height / 3 * 2
                    )
                    Text(currentPhoto.name)
                    .font(.title)
                    .padding(.top)
                Spacer()
            }
            .frame(maxWidth: .infinity)
            .padding()
            
        }
    }
}

struct DetailedView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            DetailView(currentPhoto: PresentedPhoto.example)
                .previewInterfaceOrientation(.portraitUpsideDown)
            DetailView(currentPhoto: PresentedPhoto.example)
                .previewInterfaceOrientation(.landscapeLeft)
        }
    }
}
