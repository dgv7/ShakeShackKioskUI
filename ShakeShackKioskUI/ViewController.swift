import UIKit
import SnapKit

class MenuViewController: UIViewController {

    // UI 요소들 정의
    let titleLabel = UILabel()
    let instructionLabel = UILabel()
    let menuStackView = UIStackView()
    let resultTextView = UITextView()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }

    private func configureUI() {
        view.backgroundColor = .white

        // 타이틀 라벨 설정
        titleLabel.text = "SHAKESHACK BURGER 에 오신걸 환영합니다."
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

        // 메뉴 버튼들 추가
        addMenuButton(title: "1. Burgers         | 앵거스 비프 통살을 다져만든 버거", action: #selector(burgersButtonTapped))
        addMenuButton(title: "2. Frozen Custard  | 매장에서 신선하게 만드는 아이스크림", action: #selector(frozenCustardButtonTapped))
        addMenuButton(title: "3. Drinks          | 매장에서 직접 만드는 음료", action: #selector(drinksButtonTapped))
        addMenuButton(title: "4. Beer            | 뉴욕 브루클린 브루어리에서 양조한 맥주", action: #selector(beerButtonTapped))
        addMenuButton(title: "5. Order           | 장바구니를 확인 후 주문합니다.", action: #selector(orderButtonTapped))
        addMenuButton(title: "6. Cancel          | 진행중인 주문을 취소합니다.", action: #selector(cancelButtonTapped))
        
        // 결과 텍스트뷰 설정
        resultTextView.font = UIFont.systemFont(ofSize: 16)
        resultTextView.isEditable = false
        view.addSubview(resultTextView)
        
        resultTextView.snp.makeConstraints {
            $0.top.equalTo(menuStackView.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(200)
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

    @objc private func burgersButtonTapped() {
        displayBurgersMenu()
    }

    @objc private func frozenCustardButtonTapped() {
        resultTextView.text = "매장에서 신선하게 만드는 아이스크림"
    }

    @objc private func drinksButtonTapped() {
        resultTextView.text = "매장에서 직접 만드는 음료"
    }

    @objc private func beerButtonTapped() {
        resultTextView.text = "뉴욕 브루클린 브루어리에서 양조한 맥주"
    }

    @objc private func orderButtonTapped() {
        let cartVC = CartViewController()
        navigationController?.pushViewController(cartVC, animated: true)
    }

    @objc private func cancelButtonTapped() {
        Cart.shared.items.removeAll()
        resultTextView.text = "진행중인 주문을 취소합니다."
    }

    private func displayBurgersMenu() {
        let burgersMenu = """
        [ Burgers MENU ]
        1. ShackBurger   | W 6.9 | 토마토, 양상추, 쉑소스가 토핑된 치즈버거
        2. SmokeShack    | W 8.9 | 베이컨, 체리 페퍼에 쉑소스가 토핑된 치즈버거
        3. Shroom Burger | W 9.4 | 몬스터 치즈와 체다 치즈로 속을 채운 베지테리안 버거
        4. Cheeseburger  | W 6.9 | 포테이토 번과 비프패티, 치즈가 토핑된 치즈버거
        5. Hamburger     | W 5.4 | 비프패티를 기반으로 야채가 들어간 기본버거
        0. 뒤로가기      | 뒤로가기
        """
        resultTextView.text = burgersMenu
    }
}
