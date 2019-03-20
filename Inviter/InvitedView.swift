//
//  InvitedView.swift
//  Inviter
//
//  Created by Lucas Salton Cardinali on 20/03/19.
//  Copyright © 2019 Lucas Salton Cardinali. All rights reserved.
//

import Foundation
import Reusable

final class InvitedView: UIView, NibLoadable {

    @IBOutlet weak var tableView: UITableView!
    var models: [TitleSubtitleViewModel] = []

    func setupView(models: [TitleSubtitleViewModel]) {
        self.models = models
        if tableView.dataSource != nil {
            tableView.reloadData()
        } else {
            tableView.dataSource = self
        }
    }
}

extension InvitedView: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell
        if let dequeuedCell = tableView.dequeueReusableCell(withIdentifier: "InvitedCell") {
            cell = dequeuedCell
        } else {
            cell = UITableViewCell(style: .default, reuseIdentifier: "InvitedCell")
        }

        let model = models[indexPath.row]

        cell.textLabel?.text = model.title
        cell.detailTextLabel?.text = model.subtitle

        return cell
    }
}
