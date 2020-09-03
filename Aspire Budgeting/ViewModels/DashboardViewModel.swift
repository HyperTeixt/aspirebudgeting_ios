//
// DashboardViewModel.swift
// Aspire Budgeting
//

import Foundation

struct DashboardViewModel {

  let currentState: ViewModelState
  let metadata: DashboardMetadata?
  let error: Error?

  private let refreshAction: (() -> Void)

  init(result: Result<DashboardMetadata>?,
       refreshAction: @escaping (() -> Void)) {

    self.refreshAction = refreshAction

    if let result = result {
      switch result {
      case .failure(let error):
        self.error = error
        self.metadata = nil
        self.currentState = .error

      case .success(let metadata):
        self.metadata = metadata
        self.error = nil
        self.currentState = .dataRetrieved
      }
    } else {
      self.metadata = nil
      self.error = nil
      self.currentState = .isLoading
    }
  }

  init(refreshAction: @escaping () -> Void) {
    self.init(result: nil, refreshAction: refreshAction)
  }

  func refresh() {
    refreshAction()
  }

  private func getIndex(for group: String) -> Int {
    return metadata!.groups.firstIndex(of: group)!
  }

  func categoryRows(for group: String) -> [DashboardCategoryRow] {
    return metadata!.groupedCategoryRows[getIndex(for: group)]
  }

  func availableTotals(for group: String) -> DashboardCardView.Totals {
    let index = getIndex(for: group)
    let availableTotal = metadata!.groupedAvailableTotals[index]
    let budgetedTotal = metadata!.groupedBudgetedTotals[index]
    let spentTotal = metadata!.groupedSpentTotals[index]
    return DashboardCardView.Totals(
      availableTotal: availableTotal,
      budgetedTotal: budgetedTotal,
      spentTotals: spentTotal
    )
  }
}