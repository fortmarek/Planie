//
//  UserTableRootView.swift
//  TravelPlanner
//
//  Created by Tadeáš Kříž on 07/09/16.
//  Copyright © 2017 Brightify. All rights reserved.
//


import Reactant
import RxSwift

final class UserTableRootView: ViewBase<[UserProfile], PlainTableViewAction<UserCell>>  {

    let tableView: PlainTableView<UserCell> = PlainTableView(cellFactory: UserCell.init, reloadable: false)

    override var actions: [Observable<PlainTableViewAction<UserCell>>] {
        return tableView.actions
    }

    override func afterInit() {
        tableView.rowHeight = UserCell.height
        tableView.separatorStyle = .none
        tableView.footerView = UIView()
        tableView.tableView.separatorColor = Colors.background
    }

    override func update() {
        tableView.componentState = .items(componentState)
    }

}
