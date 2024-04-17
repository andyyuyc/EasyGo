//
//  Alarms.swift
//  EasyGO
//
//  Created by Andy Yu on 4/11/24.
//

import SwiftUI
import Firebase

struct Alarms: View {
    
    @State private var selectedDate = Date()
    @State public var isContentView = false
    private let db = Firestore.firestore()
    
    var body: some View {
        ZStack() {
            ZStack() {
                Rectangle()
                    .foregroundColor(.clear)
                    .frame(width: 430, height: 203)
                    .background(
                        Image("430x203")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                    )
                
                Rectangle()
                    .foregroundColor(.clear)
                    .frame(width: 430, height: 738)
                    .background(
                        Image("430x846")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                    )
                
                Rectangle()
                    .foregroundColor(.clear)
                    .frame(width: 430, height: 419)
                    .background(
                        Image("Alarms_1")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                    )
                    .cornerRadius(21)
                    .offset(x: 0, y: 300)
                
                
                DatePicker("Set Alarm", selection: $selectedDate, displayedComponents: .hourAndMinute)
                                    .datePickerStyle(WheelDatePickerStyle())
                                    .labelsHidden()
                                    .frame(width: 200, height: 100)
                                    .offset(x: -30, y: 400)
                
//                Button(action: {
//                    
//                    let time = Timestamp(date: selectedDate)
//                    self.addTimeToFirestore(time)
//
//                }) {
//                    Text("Set")
//                        .font(Font.custom("SF Pro", size: 20))
//                        .lineSpacing(22)
//                        .foregroundColor(Color(red: 1, green: 0, blue: 0))
//                        .offset(x: 153.50, y: 400)
//                }
                
                
                HStack(spacing: 0) {
                    Text("Search")
                        .font(Font.custom("SF Pro", size: 17))
                        .lineSpacing(22)
                        .foregroundColor(.white)
                }
                .padding(EdgeInsets(top: 7, leading: -150, bottom: 7, trailing: 8))
                .frame(width: 355, height: 36)
                .background(Color(red: 0.46, green: 0.46, blue: 0.50).opacity(0.24))
                .cornerRadius(10)
                .offset(x: 23.50, y: -330)
                HStack(spacing: 16) {
                    HStack(alignment: .top, spacing: 10) {
                        Image("Menu")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                    }
                }
                .padding(EdgeInsets(top: 11, leading: 0, bottom: 11, trailing: 0))
                .frame(width: 43, height: 44)
                .offset(x: -187.50, y: -340)
                
                
                
                ZStack() {
                    
                    NavigationLink(isActive: $isContentView) {
                        ContentView()
                    } label: {
                    }
                    
                    Button(action: {
                        isContentView = true
                    }) {
                        
                        Rectangle()
                            .foregroundColor(.clear)
                            .frame(width: 60, height: 60)
                            .background(
                                Image("Exit")
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .fullScreenCover(isPresented: $isContentView, content: {
                                        ContentView()
                                        
                                    })
                            );
                        
                    }
                        
                        
                    }
                    .offset(x: 180, y: 130)
                
                ZStack() {
                    Button(action: {
                        print("Selected Date: \(selectedDate)")
                        let time = Timestamp(date: selectedDate)
                        self.addTimeToFirestore(time)
                        
                    }) {
                        Text("Set")
                            .font(Font.custom("SF Pro", size: 20))
                            .lineSpacing(22)
                            .foregroundColor(Color(red: 1, green: 0, blue: 0))
                    }
                    .offset(x: 153.50, y: 400)
                }

            }
            .frame(width: 430, height: 846)
            .offset(x: 0, y: -53)
            
            
        }
        .onAppear {
                        print("View appeared")
                    }
    }
    
    private func addTimeToFirestore(_ time: Timestamp) {
        db.collection("StopTime").addDocument(data: [
            "time": time
        ]) { error in
            if let error = error {
                print("Error adding document: \(error)")
            } else {
                print("Document added successfully")
            }
        }
    }
}


struct Alarms_Previews: PreviewProvider {
    static var previews: some View {
        Alarms()
    }
}
