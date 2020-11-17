//
//  AspireSegmentedItem.swift
//  Aspire Budgeting
//

import SwiftUI

struct AspireSegmentedItem: View {
  let title: String
  let itemIndex: Int
  @Binding var selectedSegment: Int

  private var opacity: Double {
    selectedSegment == itemIndex ? 1 : 0.1
  }

  var body: some View {
    VStack {
      Spacer()
      Button(
        action: {
          self.selectedSegment = self.itemIndex
        }, label: {
          Text(title)
            .tracking(1)
            .font(.rubikRegular(size: 18))
            .foregroundColor(.white)
            .opacity(self.opacity)
        }
      ).disabled(selectedSegment == self.itemIndex)
      Spacer()
      if selectedSegment == itemIndex {
        Rectangle()
          .frame(height: 3)
          .foregroundColor(Colors.segmentRed)
      }
    }
    .frame(minWidth: 0, maxWidth: .infinity, maxHeight: 55)
  }
}

struct AspireSegmentedItem_Previews: PreviewProvider {
  static var previews: some View {
    AspireSegmentedItem(
      title: "Dashboard",
      itemIndex: 0,
      selectedSegment: .constant(0)
    )
  }
}
