//
//  ViewController.swift
//  Contact Screen
//
//  Created by Ozgun Dogus on 5.02.2024.
//

import UIKit

class HomeViewController: UIViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    private var pageViewController: UIPageViewController!
    private var pages: [UIViewController] = []
    private lazy var segmentedControl: UISegmentedControl = {
        let sc = UISegmentedControl(items: ["For You", "All", "Bookmarks"])
        sc.selectedSegmentIndex = 0
        sc.addTarget(self, action: #selector(segmentedControlChanged(_:)), for: .valueChanged)
        return sc
      }()
      
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBlue.withAlphaComponent(0.4)
        setupNavigationBar()
        setupPageViewController()
        setupSegmentedControl()
    }
    private func setupSegmentedControl() {
        let font = UIFont.systemFont(ofSize: 16)
        segmentedControl.setTitleTextAttributes([NSAttributedString.Key.font: font], for: .normal)

        let containerView = UIView()
        containerView.backgroundColor = .clear
        containerView.translatesAutoresizingMaskIntoConstraints = false

       
        containerView.addSubview(segmentedControl)
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false

        
        NSLayoutConstraint.activate([
            segmentedControl.topAnchor.constraint(equalTo: containerView.topAnchor),
            segmentedControl.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            segmentedControl.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            segmentedControl.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            
            containerView.widthAnchor.constraint(equalToConstant: 300),
            containerView.heightAnchor.constraint(equalToConstant: 30),
        ])

        navigationItem.titleView = containerView

       
    }

    
    
    
    private func setupNavigationBar() {
        navigationItem.title = "News"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        if #available(iOS 15.0, *) {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = UIColor.systemBackground
            appearance.titleTextAttributes = [.foregroundColor: UIColor.black]
            appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.black]
            
            navigationController?.navigationBar.standardAppearance = appearance
            navigationController?.navigationBar.scrollEdgeAppearance = navigationController?.navigationBar.standardAppearance
        } else {
           
            navigationController?.navigationBar.barTintColor = UIColor.yellow
            navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
            navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        }
        
        navigationController?.navigationBar.isTranslucent = false
    }

    
    private func setupPageViewController() {
        pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        
        pageViewController.dataSource = self
        pageViewController.delegate = self
        
        for _ in 0..<3 {
            pages.append(ContentViewController())
        }
        
        if let firstPage = pages.first {
            pageViewController.setViewControllers([firstPage], direction: .forward, animated: true, completion: nil)
        }
        
        addChild(pageViewController)
        view.addSubview(pageViewController.view)
        pageViewController.didMove(toParent: self)
        
        pageViewController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            pageViewController.view.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            pageViewController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            pageViewController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            pageViewController.view.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height / 1.2)
        ])
    }
    
    @objc func segmentedControlChanged(_ sender: UISegmentedControl) {
        let index = sender.selectedSegmentIndex
        let direction: UIPageViewController.NavigationDirection = index > presentationIndex(for: pageViewController) ? .forward : .reverse
        pageViewController.setViewControllers([pages[index]], direction: direction, animated: true, completion: nil)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = pages.firstIndex(of: viewController) else { return nil }
        let previousIndex = viewControllerIndex - 1
        guard previousIndex >= 0 else { return nil }
        guard pages.count > previousIndex else { return nil }
        return pages[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = pages.firstIndex(of: viewController) else { return nil }
        let nextIndex = viewControllerIndex + 1
        guard pages.count > nextIndex else { return nil }
        return pages[nextIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if completed, let visibleViewController = pageViewController.viewControllers?.first, let index = pages.firstIndex(of: visibleViewController) {
            segmentedControl.selectedSegmentIndex = index
        }
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return pages.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        guard let firstViewController = pageViewController.viewControllers?.first,
              let firstViewControllerIndex = pages.firstIndex(of: firstViewController) else {
            return 0
        }
        return firstViewControllerIndex
    }
}


