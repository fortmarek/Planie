//
//  CitySelectionRootView.swift
//  TravelPlanner
//
//  Created by Tadeáš Kříž on 03/09/16.
//  Copyright © 2017 Brightify. All rights reserved.
//

import Reactant
import RxSwift 



final class CitySelectionRootView: ViewBase<[City], PlainTableViewAction<CityCell>> {

    let tableView: PlainTableView<CityCell> = PlainTableView(cellFactory: CityCell.init, reloadable: true)

    override var actions: [Observable<PlainTableViewAction<CityCell>>] {
        return tableView.actions

    }

    override func afterInit() {
        tableView.estimatedRowHeight = CityCell.height
        tableView.footerView = UIView()
    }


}
