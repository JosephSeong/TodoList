//
//  ProfileDesignViewController.swift
//  ToDo
//
//  Created by Joseph on 1/29/24.
//

import UIKit
import SnapKit

class ProfileDesignViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.white

        let titleLabel = UILabel()
        titleLabel.text = "profile"
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(titleLabel)

        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top) // .offset(20)
        }
    }




}
