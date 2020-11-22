//
//  ContentView.swift
//  ScrollWaveEffect
//
//  Created by Casper Daris on 22/11/2020.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        
        ZStack {
            
            ZStack {
                VStack {
                    LinearGradient(gradient: Gradient(colors: [Color("Oranje1"), Color("Oranje2")]), startPoint: .top, endPoint: .bottom)
                        .frame(height: UIScreen.main.bounds.height - 200)
                    Color("Blauw6")
                        .frame(height: .infinity, alignment: .bottom)
                }
            }
            
            ScrollView(.vertical, showsIndicators: false) {
                VStack {
                    
                    Capsule()
                        .frame(width: 60, height: 20)
                        .foregroundColor(.white)
                        .padding(.top, 100)
                    
                    Text("Dit is een test!")
                        .font(.title)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.center)
                        .padding(.top, 40)
                    
                    Text("Ik heb deze app gemaakt om te oefenen met custom shapes.")
                        .fontWeight(.light)
                        .foregroundColor(Color.black.opacity(0.8))
                        .multilineTextAlignment(.center)
                        .padding(.all, 40)
                    
                    GeometryReader { geometry in
                        ZStack {
                            
                            // Achterste Wave
                            Wave(waveHeight: 25, waveLength: 40, phase: Angle(degrees: Double(geometry.frame(in: .global).minY) - 90))
                                .foregroundColor(Color("Blauw2"))
                            
                            // Midden Wave
                            Wave(waveHeight: 18, waveLength: 50, phase: Angle(degrees: (Double(geometry.frame(in: .global).minY) + 45) * -1 * 0.3))
                                .foregroundColor(Color("Blauw4"))
                            
                            // Voorste Wave
                            Wave(waveHeight: 10, waveLength: 60, phase: Angle(degrees: Double(geometry.frame(in: .global).minY)))
                                .foregroundColor(Color("Blauw6"))
                        }
                    }
                    .frame(height: UIScreen.main.bounds.height, alignment: .center)
                }
            }
        }
        .edgesIgnoringSafeArea(.all)
    }
}

struct Wave: Shape {
    
    var waveHeight: CGFloat
    var waveLength: CGFloat
    var phase: Angle
    
    // Deze path() functie beschrijft de vorm van de shape met gebruik van een rechthoek als referentiekader
    func path(in rect: CGRect) -> Path {
        
        // De path die je uiteindelijk gaat returnen
        var path = Path()
        
        // Begin de path bij de linker onderhoek
        path.move(to: CGPoint(x: 0, y: rect.maxY))
        
        for x in stride(from: 0, to: rect.width, by: 1) {
            
            // Lengte van de Wave
            let relativeX: CGFloat = x / waveLength
            
            let sine = CGFloat(sin(relativeX + CGFloat(phase.radians)))
            
            let y = waveHeight * sine
            
            // Linker bovenhoek
            path.addLine(to: CGPoint(x: x, y: y))
        }
        
        // Rechter bovenhoek
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.midY))
        
        // Rechter onderhoek
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        
        return path
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
