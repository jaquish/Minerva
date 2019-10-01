//
//  UpdateUserCoordinator.swift
//  MinervaExample
//
//  Copyright © 2019 Optimize Fitness, Inc. All rights reserved.
//

import Foundation
import UIKit

import Minerva
import PromiseKit

final class UpdateUserCoordinator: PromiseCoordinator<UpdateUserDataSource, CollectionViewController> {

  private let dataManager: DataManager

  // MARK: - Lifecycle

  init(navigator: Navigator, dataManager: DataManager, user: User) {
    self.dataManager = dataManager
    let dataSource = UpdateUserDataSource(user: user)
    let viewController = CollectionViewController()
    super.init(navigator: navigator, viewController: viewController, dataSource: dataSource)
    self.refreshBlock = { dataSource, animated in
      dataSource.reload(animated: animated)
    }
    dataSource.delegate = self
    viewController.title = "Update User"
  }

  private func save(user: User) {
    LoadingHUD.show(in: viewController.view)
    dataManager.update(user: user).done { [weak self] () -> Void in
      guard let strongSelf = self else { return }
      strongSelf.navigator.dismiss(strongSelf.viewController, animated: true, completion: nil)
    }.catch { [weak self] error -> Void in
      self?.viewController.alert(error, title: "Failed to save the user")
    }.finally { [weak self] in
      LoadingHUD.hide(from: self?.viewController.view)
    }
  }
}

// MARK: - UpdateUserDataSourceDelegate
extension UpdateUserCoordinator: UpdateUserDataSourceDelegate {
  func updateUserActionSheetDataSource(
    _ updateUserActionSheetDataSource: UpdateUserDataSource,
    selected action: UpdateUserDataSource.Action
  ) {
    switch action {
    case .save(let user):
      save(user: user)
    }
  }
}
