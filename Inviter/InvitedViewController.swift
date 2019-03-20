//
//  InvitedViewController.swift
//  Inviter
//
//  Created by Lucas Salton Cardinali on 20/03/19.
//  Copyright © 2019 Lucas Salton Cardinali. All rights reserved.
//

import UIKit

final class InvitedViewController: UIViewController {

    init(repository: CustomerRepository = CustomerRepository()) {
        self.repository = repository
        super.init(nibName: nil, bundle: nil)
        title = "Invited"
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    let repository: CustomerRepository
    let invitedView = InvitedView.loadFromNib()

    override func loadView() {
        self.view = invitedView
    }

    override func viewDidLoad() {
        repository.fetchCustomers { result in
            switch result {
            case let .success(customers):
                let models = customers.map({ customer in
                    return TitleSubtitleViewModel(title: customer.name, subtitle: "test")
                })
                invitedView.setupView(models: models)
            case let .failure(error):
                print(error)
            }
        }
    }

}
