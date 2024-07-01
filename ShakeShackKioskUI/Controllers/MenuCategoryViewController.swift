import UIKit
import SnapKit

class MenuCategoryViewController: UIViewController {

    // UI 요소들 정의
    let titleLabel = UILabel()
    let instructionLabel = UILabel()
    let menuStackView = UIStackView()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }

    private func configureUI() {
        view.backgroundColor = .white

        // 네비게이션 아이템 설정
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(cancelOrder)),
            UIBarButtonItem(barButtonSystemItem: .bookmarks, target: self, action: #selector(viewCart))
        ]

        // 타이틀 라벨 설정
        titleLabel.text = "SHAKESHACK CATEGORY"
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

        // 카테고리 버튼들 추가
        addCategoryButton(title: "1. Burgers         | 앵거스 비프 통살을 다져만든 버거", category: .burgers)
        addCategoryButton(title: "2. Frozen Custard  | 매장에서 신선하게 만드는 아이스크림", category: .frozenCustard)
        addCategoryButton(title: "3. Drinks          | 매장에서 직접 만드는 음료", category: .drinks)
        addCategoryButton(title: "4. Beer            | 뉴욕 브루클린 브루어리에서 양조한 맥주", category: .beer)
    }

    private func addCategoryButton(title: String, category: MenuCategory) {
        let button = UIButton(type: .system)
        button.setTitle(title, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        button.contentHorizontalAlignment = .left
        button.accessibilityIdentifier = category.rawValue // 카테고리를 태그로 설정
        button.addTarget(self, action: #selector(categoryButtonTapped(_:)), for: .touchUpInside)
        menuStackView.addArrangedSubview(button)
    }

    @objc private func categoryButtonTapped(_ sender: UIButton) {
        guard let categoryTitle = sender.accessibilityIdentifier, let category = MenuCategory(rawValue: categoryTitle) else {
            return
        }
        let menuVC = MenuViewController()
        menuVC.category = category // 선택된 카테고리 설정
        navigationController?.pushViewController(menuVC, animated: true)
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
}
