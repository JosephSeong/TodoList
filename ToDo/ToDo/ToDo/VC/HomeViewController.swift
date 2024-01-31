//
//  HomeViewController.swift
//  ToDo
//
//  Created by Joseph on 1/12/24.
//

import UIKit
import SnapKit

class HomeViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()

        let urlString = "https://spartacodingclub.kr/css/images/scc-og.jpg"

        guard let url = URL(string: urlString) else { return }
        let request = URLRequest(url: url)

        let task = URLSession.shared.dataTask(with: request, completionHandler: { data, response, error in
            guard let data = data else { return }

            let image = UIImage(data: data)

            DispatchQueue.main.sync { [weak self] in
                self?.imageView.image = image
            }
        })
        task.resume()




        // 버튼 생성 및 설정
        let profileBtn = UIButton(type: .system)
        profileBtn.addTarget(self, action: #selector(goToProfile), for: .touchUpInside)

        let symbolName = "person.crop.square"
        let buttonImage = UIImage(systemName: symbolName)
        profileBtn.setImage(buttonImage, for: .normal)

        // 아이콘
        profileBtn.tintColor = UIColor.systemIndigo
        profileBtn.imageView?.snp.makeConstraints { make in
            make.width.equalTo(45)
            make.height.equalTo(35)
        }

        // 버튼 레이아웃 설정
        profileBtn.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(profileBtn)

        view.addSubview(profileBtn)
        profileBtn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-240)
        }
    }

    @objc func goToProfile() {
        let profileDesignVC = ProfileDesignViewController()
        //self.navigationController?.pushViewController(profileVC, animated:true)
        self.present(profileDesignVC, animated: true, completion: nil)
    }
}
