//
//  ContentView.swift
//  CoreML_Training
//
//  Created by Jacopo Mangiavacchi on 3/18/20.
//  Copyright © 2020 Jacopo Mangiavacchi. All rights reserved.
//

import SwiftUI
import CoreML

struct ContentView: View {
    @State var model = HousingModel()
    
    @State var changeRatio = false
    @State var newRatio = 0.8

    var body: some View {
        Form {
            Section(header: Text("Dataset")) {
                HStack {
                    VStack {
                        if changeRatio {
                            Text("\(model.data.numTrainRecords) Train Samples")
                            Text("\(model.data.numTestRecords) Test Samples")
                        }
                        else {
                            Text("\(model.data.numTrainRecords) Train Samples")
                            Text("\(model.data.numTestRecords) Test Samples")
                        }
                    }
                    Spacer()
                    if changeRatio {
                        Text("\(Int(newRatio*100)) %")
                    }
                    else {
                        Text("\(Int(model.data.trainPercentage * 100)) %")
                    }
                    Spacer()
                    HStack {
                        if self.changeRatio {
                            Button(action: {
                                self.changeRatio = false
                            }) {
                                Text("Cancel")
                            }
                        }
                        Button(action: {
                            if self.changeRatio {
                                self.model.randomizeData(trainPercentage: Float(self.newRatio))
                                self.changeRatio = false
                            }
                            else {
                                self.changeRatio = true
                            }
                            
                        }) {
                            if changeRatio {
                                Text("Confirm").foregroundColor(.red)
                            }
                            else {
                                Text("Change")
                            }
                        }
                    }
                }
                if changeRatio {
                    HStack {
                        Slider(value: $newRatio, in: 0.1...0.99, step: 0.01)
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
