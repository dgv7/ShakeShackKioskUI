import UIKit
import SnapKit

class CartViewController: UIViewController {

    let cartStackView = UIStackView()
    let totalLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        updateCartView()
    }

    private func configureUI() {
        view.backgroundColor = .white
        title = "Cart"

        // 장바구니 스택뷰 설정
        cartStackView.axis = .vertical
        cartStackView.spacing = 10
        cartStackView.distribution = .equalSpacing
        view.addSubview(cartStackView)
        
        cartStackView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            $0.leading.trailing.equalToSuperview().inset(20)
        }

        // 장바구니 비우기 버튼
        let clearButton = UIButton(type: .system)
        clearButton.setTitle("Clear Cart", for: .normal)
        clearButton.addTarget(self, action: #selector(clearCart), for: .touchUpInside)
        view.addSubview(clearButton)
        
        clearButton.snp.makeConstraints {
            $0.top.equalTo(cartStackView.snp.bottom).offset(20)
            $0.centerX.equalToSuperview()
        }

        // 합계 라벨 설정
        totalLabel.font = UIFont.boldSystemFont(ofSize: 18)
        totalLabel.textAlignment = .right
        view.addSubview(totalLabel)
        
        totalLabel.snp.makeConstraints {
            $0.top.equalTo(clearButton.snp.bottom).offset(20)
            $0.trailing.equalToSuperview().inset(20)
        }
    }

    @objc private func clearCart() {
        Cart.shared.clear()
        updateCartView()
    }

    private func updateCartView() {
        cartStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        
        var total: Double = 0.0

        for (item, count) in Cart.shared.items {
            let itemStackView = UIStackView()
            itemStackView.axis = .horizontal
            itemStackView.distribution = .fillProportionally
            itemStackView.alignment = .center

            let itemName = UILabel()
            itemName.text = item.name
            itemName.setContentHuggingPriority(.defaultLow, for: .horizontal)

            let itemCount = UILabel()
            itemCount.text = "x\(count)"
            itemCount.setContentHuggingPriority(.defaultHigh, for: .horizontal)

            let itemPrice = UILabel()
            itemPrice.text = String(format: "W %.1f", item.price * Double(count))
            itemPrice.setContentHuggingPriority(.defaultHigh, for: .horizontal)

            let minusButton = UIButton(type: .system)
            minusButton.setTitle("-", for: .normal)
            minusButton.tag = item.hashValue
            minusButton.addTarget(self, action: #selector(decreaseItemCount(_:)), for: .touchUpInside)
            
            let plusButton = UIButton(type: .system)
            plusButton.setTitle("+", for: .normal)
            plusButton.tag = item.hashValue
            plusButton.addTarget(self, action: #selector(increaseItemCount(_:)), for: .touchUpInside)
            
            let removeButton = UIButton(type: .system)
            removeButton.setImage(UIImage(systemName: "trash"), for: .normal)
            removeButton.tag = item.hashValue
            removeButton.addTarget(self, action: #selector(removeItemTapped(_:)), for: .touchUpInside)

            itemStackView.addArrangedSubview(itemName)
            itemStackView.addArrangedSubview(minusButton)
            itemStackView.addArrangedSubview(itemCount)
            itemStackView.addArrangedSubview(plusButton)
            itemStackView.addArrangedSubview(itemPrice)
            itemStackView.addArrangedSubview(removeButton)
            
            cartStackView.addArrangedSubview(itemStackView)
            
            total += item.price * Double(count)
        }

        totalLabel.text = String(format: "합계: W %.1f", total)
    }

    @objc private func increaseItemCount(_ sender: UIButton) {
        guard let item = Cart.shared.items.keys.first(where: { $0.hashValue == sender.tag }) else { return }
        Cart.shared.addItem(item)
        updateCartView()
    }

    @objc private func decreaseItemCount(_ sender: UIButton) {
        guard let item = Cart.shared.items.keys.first(where: { $0.hashValue == sender.tag }) else { return }
        Cart.shared.removeItem(item)
        updateCartView()
    }

    @objc private func removeItemTapped(_ sender: UIButton) {
        guard let item = Cart.shared.items.keys.first(where: { $0.hashValue == sender.tag }) else { return }
        Cart.shared.removeItem(item)
        updateCartView()
    }
}
