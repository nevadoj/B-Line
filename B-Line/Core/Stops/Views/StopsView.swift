//
//  StopsView.swift
//  B-Line
//
//  Created by Joseph Nevado on 2023-02-14.
//

import SwiftUI

struct StopsView: View {
    
    @State private var showStops: Bool = false
    
    init(){
        let appearance = UINavigationBarAppearance()
        appearance.shadowColor = UIColor.clear
        appearance.backgroundColor = UIColor(Color("BPrimary"))
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }
    
    var body: some View {
        ZStack{
            if(showStops){
                SavedStopsView()
            }
            else{
                AuthView(showStops: $showStops)
            }
        }
        .onAppear{
            let authUser = try? AuthenticationManager.shared.getAuthenticatedUser()
            self.showStops = authUser != nil
        }
    }
}

//struct StopsView_Previews: PreviewProvider {
//    static var previews: some View {
//        StopsView()
//    }
//}
