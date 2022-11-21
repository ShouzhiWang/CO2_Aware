//
//  GHGPerCapita.swift
//  CO2 Aware
//
//  Created by 王首之 on 10/5/22.
//

import Foundation


//struct GHG data type
struct GHG: Identifiable, Hashable {
    var country: String = ""
    var emission: String = ""
    var id = UUID()
    
    init(raw: [String]) {
        country = raw[0]
        emission = raw[1].filter { !$0.isWhitespace }
    }
}

//Loading the data
func loadCSV() -> [GHG] {
    var finalCSV = [GHG]()
    var data = ""
    
    guard let filePath = Bundle.main.path(forResource: "GHGPerCap", ofType: "csv") else{
        return []
    }
    do {
        data = try String(contentsOfFile: filePath)
    }
    catch {
        print("error")
        return []
    }
    
    let rows = data.components(separatedBy: "\n")
    
    let columnCount = rows.first?.components(separatedBy: ",").count
    //rows.removeFirst()
    
    for row in rows {
        let columns = row.components(separatedBy: ",")
        if columns.count == columnCount {
            let GHGStruct = GHG.init(raw: columns)
            finalCSV.append(GHGStruct)
        }
        
    }
    
    return finalCSV
}

