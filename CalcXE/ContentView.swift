//
//  ContentView.swift
//  CalcXE
//
//  Created by Genuine on 31.08.2021.
//

import CoreData
import SwiftUI

@available(iOS 15.0, *)
struct CalcXEView: View {
    
    @State private var carbohydratesIn100:  String = ""
    @State private var countGramm: String = ""
    
    
    @State var result : AttributedString = ""
    @FocusState private var isFirstResponder :Bool
    
        // main formula : where V - carbohydrates in 100 grammms ;
    //                          Y - product weight;
    //                          1100 == 100 grams multiplied to 11 (carbohydrates in 1 bread unite )
    //                          XE == bread unite
    var body: some View {
        
        func calc(_ V: Double, _ Y: Double) -> String {
            let XE = (V * Y)/1100
            return String(XE)
        }
        
        
        return VStack {
             Text($result.wrappedValue)
                .font(.system(size: 50))
                .fontWeight(.heavy)
               // .frame(width: 300, height: 300 , alignment: .top)
            
            TextField(
                "carbohydrates In 100 grammms",
                text: $carbohydratesIn100
            )
            .disableAutocorrection(true)
            .keyboardType(.numberPad)
            .focused($isFirstResponder)
            
            TextField(
                "product weight",
                text: $countGramm
            )
            .disableAutocorrection(true)
            .keyboardType(.numberPad)
            .focused($isFirstResponder)
            
        }
        .textFieldStyle(.roundedBorder)
        .toolbar {
            ToolbarItemGroup(placement: .keyboard) {
                Spacer()
                
                Button("Done") {
                    result =  AttributedString(calc(Double(carbohydratesIn100) ?? 0 ,
                                                    Double(countGramm) ?? 0 ))
                    isFirstResponder = false // hide keyboard
                }
            }
        }
        
    }
}

@available(iOS 15.0, *)
struct ContentView_Previews: PreviewProvider {
    
    static var previews: some View {
        CalcXEView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
