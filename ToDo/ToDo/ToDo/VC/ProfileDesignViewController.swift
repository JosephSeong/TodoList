//
//  ProfileDesignViewController.swift
//  ToDo
//
//  Created by Joseph on 1/29/24.
//

import UIKit
import SnapKit

class ProfileDesignViewController: UIViewController {

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "프로필"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        return label
    }()

    private let menuBtn: UIButton = {
        let button = UIButton(type: .system)
        let symbolConfiguration = UIImage.SymbolConfiguration(pointSize: 20, weight: .regular)
        let menuSymbol = UIImage(systemName: "line.horizontal.3", withConfiguration: symbolConfiguration)
        button.setImage(menuSymbol, for: .normal)
        button.tintColor = UIColor.black
        button.addTarget(self, action: #selector(menuTap), for: .touchUpInside)
        return button
    }()

    private let profileImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Ellipse 1")
        imageView.tintColor = UIColor.systemBlue
        return imageView
    }()

    private let postNum: UILabel = {
        let label = UILabel()
        label.text = "7"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 16.5, weight: .bold)
        return label
    }()

    private let postLabel: UILabel = {
        let label = UILabel()
        label.text = "게시물"
        label.textAlignment = .center
        return label
    }()

    private let followerNum: UILabel = {
        let label = UILabel()
        label.text = "0"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 16.5, weight: .bold)
        return label
    }()

    private let followerLabel: UILabel = {
        let label = UILabel()
        label.text = "팔로워"
        label.textAlignment = .center
        return label
    }()

    private let followingNum: UILabel = {
        let label = UILabel()
        label.text = "0"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 16.5, weight: .bold)
        return label
    }()

    private let followingLabel: UILabel = {
        let label = UILabel()
        label.text = "팔로잉"
        label.textAlignment = .center
        return label
    }()

    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "르탄이"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 16.5, weight: .semibold)
        return label
    }()

    private let explaneLabel: UILabel = {
        let label = UILabel()
        label.text = "iOS Developer 🍎"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 14, weight: .light)
        return label
    }()

    private let linkLabel: UILabel = {
        let label = UILabel()
        label.text = "spartacodingclub.kr"
        label.textAlignment = .center
        label.textColor = .systemBlue
        label.font = UIFont.systemFont(ofSize: 14, weight: .light)
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.white

        setupUI()
        setupConstraints()
    }

    private func setupUI() {
        view.addSubview(titleLabel)
        view.addSubview(menuBtn)
        view.addSubview(profileImage)
        view.addSubview(postNum)
        view.addSubview(postLabel)
        view.addSubview(followerNum)
        view.addSubview(followerLabel)
        view.addSubview(followingNum)
        view.addSubview(followingLabel)
        view.addSubview(nameLabel)
        view.addSubview(explaneLabel)
        view.addSubview(linkLabel)
    }

    private func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
        }

        menuBtn.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.trailing.equalToSuperview().offset(-10)
        }

        profileImage.snp.makeConstraints { make in
            make.top.equalTo(menuBtn.snp.bottom).offset(14)
            make.leading.equalToSuperview().offset(10)
            make.width.height.equalTo(88)
        }

        postNum.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(40)
            make.leading.equalTo(profileImage.snp.trailing).offset(65)
        }

        postLabel.snp.makeConstraints { make in
            make.top.equalTo(postNum.snp.bottom).offset(4)
            make.leading.equalTo(profileImage.snp.trailing).offset(50)
        }

        followerNum.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(40)
            make.leading.equalTo(postNum.snp.trailing).offset(65)
        }

        followerLabel.snp.makeConstraints { make in
            make.top.equalTo(postNum.snp.bottom).offset(4)
            make.leading.equalTo(postLabel.snp.trailing).offset(30)
        }

        followingNum.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(40)
            make.leading.equalTo(followerNum.snp.trailing).offset(65)
        }

        followingLabel.snp.makeConstraints { make in
            make.top.equalTo(postNum.snp.bottom).offset(4)
            make.leading.equalTo(followerLabel.snp.trailing).offset(30)
        }

        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(profileImage.snp.bottom).offset(15)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(15)
        }

        explaneLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(4)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(15)
        }

        linkLabel.snp.makeConstraints { make in
            make.top.equalTo(explaneLabel.snp.bottom).offset(4)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(15)
        }
    }

    @objc private func menuTap() {
        print("메뉴 버튼 탭")
    }
}




// MARK: - Extension
extension ProfileDesignViewController {

}
