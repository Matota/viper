//
//  NeumPresenter.swift
//  Neum
//
//  Created by Hitesh Ahuja on 24/04/19.
//  Copyright © 2019 Organization. All rights reserved.
//

import Foundation

protocol NeumPresenterToViewProtocol: NSObjectProtocol {
    func displayFetchAddress(address: String)
}


/// This protocol will be conform by the presenter and it will make sure it passes the data in the form of model classes to the viewcontrollers.
protocol NeumPresentationLogic {
     func presentAddressDetails(response: String)
}

/// This class is just to support the protocol to convert api response to the model class and pass it along to the view controller
class NeumPresenter: NeumPresentationLogic {
    weak var viewController: NeumPresenterToViewProtocol?

    func presentAddressDetails(response: String) {
        viewController?.displayFetchAddress(address: response)
    }
}

