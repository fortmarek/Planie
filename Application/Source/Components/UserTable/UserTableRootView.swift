//
//  UserTableRootView.swift
//  TravelPlanner
//
//  Created by Tadeáš Kříž on 07/09/16.
//  Copyright © 2017 Brightify. All rights reserved.
//


import Reactant
import RxSwift

final class UserTableRootView: ViewBase<CollectionViewState<UserProfile>, PlainTableViewAction<UserCell>>  {

    let tableView: PlainTableView<UserCell> = PlainTableView(reloadable: false)

    override var actions: [Observable<PlainTableViewAction<UserCell>>] {
        return tableView.actions
    }

    override func update() {
        tableView.componentState = componentState
    }

    override func afterInit() {
        tableView.rowHeight = UserCell.height
        tableView.separatorStyle = .none
        tableView.footerView = UIView()
        tableView.tableView.separatorColor = Colors.background
    }

}
