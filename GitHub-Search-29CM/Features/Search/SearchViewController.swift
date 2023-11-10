//
//  SearchViewController.swift
//  GitHub-Search-29CM
//

import UIKit

final class SearchViewController: UIViewController {

  // MARK: Initialize

  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    self.configureTabBar()
  }

  @available(*, unavailable)
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }


  // MARK: View LifeCycle

  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.backgroundColor = .red
  }


  // MARK: TabBar

  private func configureTabBar() {
    self.tabBarItem.title = "Search"
    self.tabBarItem.image = UIImage(systemName: "magnifyingglass")
  }
}
