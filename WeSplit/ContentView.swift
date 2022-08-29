//
//  ContentView.swift
//  WeSplit
//
//  Created by Nadya Farchana Fidaroina on 25/08/22.
//

import SwiftUI

struct ContentView: View {
    @FocusState private var amountIsFocused: Bool
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 20
    let tipPercentages = [10, 15, 20, 25, 0]
    var totalPerPerson: Double {
        let peopelCount = Double(numberOfPeople + 2)
        let tipSelection = Double(tipPercentage)
        
        let tipValue = checkAmount / 100 * tipSelection
        let grandTotal = checkAmount + tipValue
        let amountPerPerson = grandTotal / peopelCount
        
        return amountPerPerson
    }
    var totalAmount: Double {
        let tipSelection = Double(tipPercentage)
        let tipValue = checkAmount / 100 * tipSelection
        let grandTotal = checkAmount + tipValue
        
        return grandTotal
    }
        var body: some View {
            NavigationView {
                Form {
                    Section {
                        TextField("Amount", value: $checkAmount, format: .currency(code: Locale.current.currencyCode ?? "IDR")).keyboardType(.decimalPad).focused($amountIsFocused)
                    }
                    Section {
                        Picker("Number of people", selection: $numberOfPeople) {
                            ForEach(2 ..< 100) {
                                Text("\($0) people")
                            }
                        }
                    }
                    Section {
                        Picker("Tip Percentage", selection: $tipPercentage) {
                            ForEach(0 ..< 101) {
                                Text("\($0) %")
                            }
                        }.pickerStyle(.segmented)
                    } header: {
                        Text("How much tip do you want to leave?")
                    }
                    Section {
                        Text(totalPerPerson, format: .currency(code: Locale.current.currencyCode ?? "USD"))
                    } header: {
                        Text("Amount per person")
                    }
                    Section {
                        Text(totalAmount, format:  .currency(code: Locale.current.currencyCode ?? "USD"))
                    } header: {
                        Text("Total Amount")
                    }
                }.navigationTitle("We Split")
                    .toolbar {
                        ToolbarItemGroup(placement: .keyboard) {
                            Button("Done") {
                                amountIsFocused = false
                            }
                        }
                    }
            }
        }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
