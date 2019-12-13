//
//  AddTransactionView.swift
//  Aspire Budgeting
//
//  Created by TeraMo Labs on 12/8/19.
//  Copyright © 2019 TeraMo Labs. All rights reserved.
//

import SwiftUI

struct AddTransactionView: View {
  @EnvironmentObject var sheetsManager: GoogleSheetsManager
  
  @State private var amountString = ""
  @State private var showDatePicker = false
  @State private var selectedDate = Date()
  
    var body: some View {
      ScrollView {
        AmountTextField(amount: $amountString)
        AspireButton(title: "Select Date", type: .green, imageName: "calendar_icon") {
          withAnimation {
            self.showDatePicker.toggle()
          }
          
          }.frame(height: 50).padding()
        if showDatePicker {
          DatePicker(selection: $selectedDate, in: ...Date(), displayedComponents: .date) {
            Text("")
          }.foregroundColor(Color.white)
        }
      }.background(Colors.aspireGray)
        .edgesIgnoringSafeArea(.all)
        .onTapGesture {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
      }
      
  }
}

//struct AddTransactionView_Previews: PreviewProvider {
//    static var previews: some View {
//        AddTransactionView()
//    }
//}
