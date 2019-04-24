//
//  ContainerViewController.swift
//  Neum
//
//  Created by Hitesh Ahuja on 24/04/19.
//  Copyright © 2019 Organization. All rights reserved.
//


import UIKit
import CoreLocation

struct helo{
    var a = 10
    var ab : Int
}

class ContainerViewController : UIViewController {
    
    @IBOutlet weak private var pageStackView: UIStackView!
    
    @IBOutlet var addressTxtField: UITextField!
    
    @IBOutlet var collectionView: UICollectionView!
    
    private var pageViewController: UIPageViewController!
    private var pageControl: UIPageControl!
    private var modelController : PageModelController<PageableViewController>!
    public var navigationOrientation = UIPageViewController.NavigationOrientation.horizontal
    public var transitionStyle = UIPageViewController.TransitionStyle.scroll
    
    private var interactor: NeumBusinessLogic?
    var locManager = CLLocationManager()
    var currentLocation: CLLocation!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        // Do any additional setup after loading the view.
        title = "Home"
        navigationController?.navigationBar.barTintColor = UIColor.black
        navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor : UIColor.white,
            NSAttributedString.Key.font : UIFont(name: "Futura", size: 22)!
        ]

        setup()
        
        setupPaginationUI()
        
        setupLocationManager()
        
       
    }
    
    /// This function will setup all the necessary protocols required for the view controllers.
    private func setup() {
        let viewController = self
        let interactor = NeumInteractor()
        let presenter = NeumPresenter()
        viewController.interactor = interactor
        interactor.presenter = presenter
        presenter.viewController = viewController
    }
    
    private func setupPaginationUI(){
        let values = ["jotun", "jotun", "jotun", "jotun"]
        self.modelController = PageModelController<PageableViewController>(storyboard: self.storyboard, viewControllerIdentifier: "Page", values: values)
        
        guard let first = self.modelController.firstViewController else {
            print("Failed to get first")
            return
        }
        
        self.pageViewController = UIPageViewController(transitionStyle: self.transitionStyle, navigationOrientation: self.navigationOrientation, options: nil)
        
        self.pageViewController.dataSource = self.modelController
        self.pageViewController.delegate = self
        self.pageViewController.setViewControllers([first], direction: .forward, animated: false, completion: nil)
        
        self.pageStackView.addArrangedSubview(self.pageViewController.view)
        self.addChild(self.pageViewController)
        
        self.pageControl = UIPageControl(frame: CGRect())
        self.pageControl!.numberOfPages = values.count
        self.pageControl!.currentPageIndicatorTintColor = UIColor.gray.withAlphaComponent(0.8)
        self.pageControl!.pageIndicatorTintColor = UIColor.gray.withAlphaComponent(0.2)
        self.pageStackView.addArrangedSubview(self.pageControl!)
    }
    
    
    private func setupLocationManager(){
        locManager.requestWhenInUseAuthorization()
        locManager.startUpdatingLocation()
        locManager.delegate = self
        fetchLastUpdatedLocation()
    }

    private func fetchLastUpdatedLocation(){
        if (CLLocationManager.authorizationStatus() == CLAuthorizationStatus.authorizedWhenInUse ||
            CLLocationManager.authorizationStatus() == CLAuthorizationStatus.authorizedAlways){
            guard let currentLocation = locManager.location else {
                return
            }
            print(currentLocation.coordinate.latitude)
            print(currentLocation.coordinate.longitude)
            
            //fetch lat long address
            interactor?.getAddressDetails(lat: currentLocation.coordinate.latitude, long: currentLocation.coordinate.longitude)
        }
    }
}


extension ContainerViewController : UIPageViewControllerDelegate{
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        guard let first = pageViewController.viewControllers?.first, finished, completed else {
            return
        }
        self.pageControl.currentPage = first.view.tag
    }
    
}

extension ContainerViewController: NeumPresenterToViewProtocol {
    func displayFetchAddress(address : String) {
        addressTxtField.text = address
    }
}

extension ContainerViewController : UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return CategoryInfoKey.allCases.count/2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
         let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCell", for: indexPath) as! CategoryCell
        
        if indexPath.section == 0{
            cell.categoryImage.image = UIImage(named: CategoryInfoKey(rawValue: indexPath.row)?.categoryImageName() ?? "ac")
            cell.categoryText.text = CategoryInfoKey(rawValue: indexPath.row)?.description()
        }else{
            cell.categoryImage.image = UIImage(named: CategoryInfoKey(rawValue: indexPath.row + CategoryInfoKey.allCases.count/2)?.categoryImageName() ?? "ac")
            cell.categoryText.text = CategoryInfoKey(rawValue: indexPath.row + CategoryInfoKey.allCases.count/2)?.description()
        }
        
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
}


extension ContainerViewController : CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        fetchLastUpdatedLocation()
    }
}
