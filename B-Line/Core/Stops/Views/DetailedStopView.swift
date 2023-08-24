//
//  DetailedStopView.swift
//  B-Line
//
//  Created by Joseph Nevado on 2023-08-23.
//

import SwiftUI

struct DetailedStopView: View {
    
    var stop: Stops
//    var bus: StopEstimates
    
    var body: some View {
        Text(stop.Name.capitalized)
    }
}

//struct DetailedStopView_Previews: PreviewProvider {
//    static var previews: some View {
//        DetailedStopView()
//    }
//}
