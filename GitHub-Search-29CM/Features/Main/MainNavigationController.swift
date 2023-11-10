//
//  MainNavigationController.swift
//  GitHub-Search-29CM
//

import SafariServices
import UIKit

import RxSwift
import RxCocoa

final class MainNavigationController: UINavigationController, UINavigationBarDelegate {

  // MARK: Properties

  private let gitHubLoginViewControllerFactory: () -> GitHubLoginViewController
  private var disposeBag = DisposeBag()


  // MARK: UI

  private let loginBarButtonItem = UIBarButtonItem()


  // MARK: Initialize

  init(
    gitHubLoginViewControllerFactory: @escaping () -> GitHubLoginViewController
  ) {
    self.gitHubLoginViewControllerFactory = gitHubLoginViewControllerFactory
    super.init(rootViewController: MainTabBarController())
    self.configureNavigationBar()
    self.bind()
  }

  @available(*, unavailable)
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }


  // MARK: Navigation Bar

  private func configureNavigationBar() {
    let navigationBarAppearance = UINavigationBarAppearance()
    navigationBarAppearance.backgroundColor = UIColor.white
    self.navigationBar.standardAppearance = navigationBarAppearance
    self.navigationBar.scrollEdgeAppearance = navigationBarAppearance
    self.navigationBar.topItem?.title = "GitHub"
    self.navigationBar.topItem?.rightBarButtonItem = self.loginBarButtonItem

    self.loginBarButtonItem.title = "로그인"
  }


  // MARK: Bind

  private func bind() {
    self.loginBarButtonItem.rx.tap
      .bind(onNext: { [weak self] in
        self?.presentLoginPage()
      })
      .disposed(by: self.disposeBag)
  }

  private func presentLoginPage() {
    let gitHubLoginViewController = self.gitHubLoginViewControllerFactory()
    self.present(gitHubLoginViewController, animated: true)
  }
}
