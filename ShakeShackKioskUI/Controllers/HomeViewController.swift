import UIKit
import SnapKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }

    private func configureUI() {
        view.backgroundColor = .white

        let titleLabel = UILabel()
        titleLabel.text = "SHAKESHACK BURGER에 오신걸 환영합니다."
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.boldSystemFont(ofSize: 24)
        view.addSubview(titleLabel)

        titleLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            $0.leading.trailing.equalToSuperview().inset(20)
        }

        let dineInButton = UIButton(type: .system)
        dineInButton.setTitle("매장식사", for: .normal)
        dineInButton.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        dineInButton.addTarget(self, action: #selector(dineInTapped), for: .touchUpInside)
        view.addSubview(dineInButton)

        dineInButton.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(40)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(200)
            $0.height.equalTo(50)
        }

        let takeOutButton = UIButton(type: .system)
        takeOutButton.setTitle("포장", for: .normal)
        takeOutButton.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        takeOutButton.addTarget(self, action: #selector(takeOutTapped), for: .touchUpInside)
        view.addSubview(takeOutButton)

        takeOutButton.snp.makeConstraints {
            $0.top.equalTo(dineInButton.snp.bottom).offset(20)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(200)
            $0.height.equalTo(50)
        }
    }

    @objc private func dineInTapped() {
        let menuCategoryVC = MenuCategoryViewController()
        navigationController?.pushViewController(menuCategoryVC, animated: true)
    }

    @objc private func takeOutTapped() {
        let menuCategoryVC = MenuCategoryViewController()
        navigationController?.pushViewController(menuCategoryVC, animated: true)
    }
}
