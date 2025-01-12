//
//  WelcomeView.swift
//  Abschluss-Arbeit-IOS
//
//  Created by Aubeid Barikzi on 20.04.24.
//

import SwiftUI

struct WelcomeView: View {
    @State private var showAuthView = false
    
    var body: some View {
        ZStack {
            
            Image("logo3")
                .resizable()
                .scaledToFill()
                .aspectRatio(contentMode: .fit)
                .edgesIgnoringSafeArea(.all)
                .background(.clear)
            
            
            
            
            //            VStack {
            //                Text("Willkommen!")
            //                    .font(.largeTitle)
            //                    .fontWeight(.bold)
            //                    .foregroundColor(.white)
            //                
            //                Spacer()
            //            }
            //            .padding()
        }
        
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                withAnimation(.easeInOut(duration: 0.5)) {
                    showAuthView = true
                }
            }
        }
        .fullScreenCover(isPresented: $showAuthView) {
            AuthView()
                .transition(.identity)
        }
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}
