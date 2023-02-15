//
//  HomeView.swift
//  B-Line
//
//  Created by Joseph Nevado on 2023-02-11.
//

import SwiftUI
import AnimatedTabBar

struct HomeView: View {
    
    @State private var selectedIndex = 0
    @State private var prevSelectedIndex = 0
    
    var body: some View {
        ZStack(){
//            Color.examplePurple.edgesIgnoringSafeArea(.all)
            switch selectedIndex{
            case 1:
                MapView()
            default:
                StopsView()
            }
            VStack(){
                Spacer()
                AnimatedTabBar(selectedIndex: $selectedIndex) {
                    colorButtonAt(0, type: .bell)
                    colorButtonAt(1, type: .calendar)
                    colorButtonAt(2, type: .gear)
                }
                .cornerRadius(16)
                .selectedColor(.exampleGrey)
                .unselectedColor(.exampleLightGrey)
                .ballColor(.white)
                .verticalPadding(20)
                .ballTrajectory(.straight)
                .ballAnimation(.interpolatingSpring(stiffness: 130, damping: 15))
                .indentAnimation(.easeOut(duration: 0.3))
            }
            .frame(maxWidth: .infinity)
            .padding(.horizontal)
        }
        .onChange(of: selectedIndex) { [selectedIndex] _ in
            prevSelectedIndex = selectedIndex
        }
    }
    
    func colorButtonAt(_ index: Int, type: ColorButton.AnimationType) -> some View {
        ColorButton(
            image: Image("colorTab\(index+1)"),
            colorImage: Image("colorTab3Bg"),
            isSelected: selectedIndex == index,
            fromLeft: prevSelectedIndex < index,
            toLeft: selectedIndex < index,
            animationType: type)
    }

    func dropletButtonAt(_ index: Int) -> some View {
        DropletButton(imageName: "tab\(index+1)", dropletColor: .examplePurple, isSelected: selectedIndex == index)
    }

    func wiggleButtonAt(_ index: Int, name: String) -> some View {
        WiggleButton(image: Image(systemName: name), maskImage: Image(systemName: "\(name).fill"), isSelected: selectedIndex == index)
            .scaleEffect(1.2)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
