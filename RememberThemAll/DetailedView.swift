//
//  DetailedView.swift
//  RememberThemAll
//
//  Created by Alex Po on 07.06.2022.
//

import SwiftUI

struct DetailedView: View {
    var currentPhoto: PresentedPhoto
    
    var body: some View {
        VStack {
            Image(uiImage: currentPhoto.image)
                .resizable()
                .scaledToFit()
                .frame(width: .infinity, height: 400)
            Text(currentPhoto.name)
                .font(.title)
                .padding(.bottom)
            Spacer()
        }
        .padding()
    }
}

struct DetailedView_Previews: PreviewProvider {
    static var previews: some View {
        DetailedView(currentPhoto: PresentedPhoto.example)
    }
}
