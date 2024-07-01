import UIKit
import SnapKit

class MenuViewController: UIViewController {

    // UI 요소들 정의
    let titleLabel = UILabel()
    let instructionLabel = UILabel()
    let menuStackView = UIStackView()
    var category: MenuCategory?

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        displayMenu()
    }

    private func configureUI() {
        view.backgroundColor = .white

        // 네비게이션 아이템 설정
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(cancelOrder)),
            UIBarButtonItem(barButtonSystemItem: .bookmarks, target: self, action: #selector(viewCart))
        ]

        // 딜리게이트 패턴 알아보기
        // 타이틀을 클로저로 초기화 방법 알아보기
        // 타이틀 라벨 설정
        titleLabel.text = "SHAKESHACK MENU"
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.boldSystemFont(ofSize: 24)
        view.addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            $0.leading.trailing.equalToSuperview().inset(20)
        }

        // 안내 라벨 설정
        instructionLabel.text = "아래 메뉴판을 보시고 메뉴를 골라 입력해주세요."
        instructionLabel.textAlignment = .center
        instructionLabel.font = UIFont.systemFont(ofSize: 18)
        view.addSubview(instructionLabel)
        
        instructionLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(20)
        }

        // 메뉴 스택뷰 설정
        menuStackView.axis = .vertical
        menuStackView.spacing = 10
        menuStackView.distribution = .fillEqually
        view.addSubview(menuStackView)
        
        menuStackView.snp.makeConstraints {
            $0.top.equalTo(instructionLabel.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
    }

    private func addMenuButton(title: String, action: Selector) {
        let button = UIButton(type: .system)
        button.setTitle(title, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        button.contentHorizontalAlignment = .left
        button.addTarget(self, action: action, for: .touchUpInside)
        menuStackView.addArrangedSubview(button)
    }

    private func displayMenu() {
        guard let category = category else { return }
        for item in category.items {
            let title = "\(item.name) | W \(item.price)"
            addMenuButton(title: title, action: #selector(menuItemTapped(_:)))
        }
    }

    @objc private func menuItemTapped(_ sender: UIButton) {
        guard let title = sender.title(for: .normal),
              let itemName = title.split(separator: "|").first?.trimmingCharacters(in: .whitespaces) else {
            return
        }

        if let category = category, let item = category.items.first(where: { $0.name == itemName }) {
            addItemToCart(item: item)
        }
    }

    @objc private func viewCart() {
        let cartVC = CartViewController()
        navigationController?.pushViewController(cartVC, animated: true)
    }

    @objc private func cancelOrder() {
        Cart.shared.clear()
        let alert = UIAlertController(title: "장바구니 비우기", message: "장바구니를 비웠습니다.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .default, handler: { _ in
            self.navigationController?.popToRootViewController(animated: true)
        }))
        present(alert, animated: true, completion: nil)
    }

    private func addItemToCart(item: MenuItem) {
        Cart.shared.addItem(item)
        let alert = UIAlertController(title: nil, message: "\(item.name)가 장바구니에 추가되었습니다.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
