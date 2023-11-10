//
//  MainTabBarController.swift
//  GitHub-Search-29CM
//

import UIKit

final class MainTabBarController: UITabBarController {

  // MARK: Initialize

  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    self.configureTabBar()

    self.viewControllers = [
      SearchViewController(),
      ProfileViewController(),
    ]
  }

  @available(*, unavailable)
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }


  // MARK: View LifeCycle

  override func viewDidLoad() {
    self.view.backgroundColor = .white
  }


  // MARK: TabBar

  private func configureTabBar() {
    self.tabBar.isTranslucent = false
  }
}
