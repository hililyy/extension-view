//
//  ViewController.swift
//  ExtensionView
//
//  Created by 강조은 on 2023/12/19.
//

import UIKit

class ViewController: UIViewController {
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [headerView, topLabel, botLabel, threeHeaderView, footerLabel])
        stackView.axis = .vertical
        stackView.spacing = 0
        return stackView
    }()
    
    let headerView: HeaderView = {
        let view = HeaderView()
        view.label.text = "Header"
        view.backgroundColor = .red
        return view
    }()
    
    let topLabel: contentsView = {
        let label = contentsView()
        label.label.text = "첫 번째 문장 첫 번째 문장 첫 번째 문장 첫 번째 문장 첫 번째 문장 첫 번째 문장 첫 번째 문장 첫 번째 문장 첫 번째 문장 첫 번째 문장 첫 번째 문장"
        label.backgroundColor = .blue
        return label
    }()
    
    let botLabel: contentsView = {
        let label = contentsView()
        label.label.text = "세 번째 문장 세 번째 문장 세 번째 문장 세 번째 문장 세 번째 문장 세 번째 문장 세 번째 문장 세 번째 문장 세 번째 문장 세 번째 문장 세 번째 문장"
        label.backgroundColor = .purple
        return label
    }()
    
    let threeHeaderView: HeaderView = {
        let view = HeaderView()
        view.label.text = "Three"
        view.backgroundColor = .systemPink
        return view
    }()
    
    let footerLabel: HeaderView = {
        let view = HeaderView()
        view.label.text = "Footer"
        view.backgroundColor = .gray
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        stackView.setCustomSpacing(8.0, after: topLabel)
        stackView.setCustomSpacing(8.0, after: botLabel)
        
        let btn = UIButton(type: .system)
        btn.setTitle("Animate", for: [])
        btn.addTarget(self, action: #selector(btnTap(_:)), for: .touchUpInside)
        
        [stackView, btn].forEach { v in
            
            v.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(v)
            
            NSLayoutConstraint.activate([
                v.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20.0),
                v.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20.0),
            ])
        }
        
        NSLayoutConstraint.activate([
            
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20.0),
            
            // put button near bottom
            btn.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -40.0),
            
        ])
        
    }
    
    @objc func btnTap(_ sender: UIButton) {

        UIView.animate(withDuration: 0.5) {
            
            self.topLabel.alpha = self.topLabel.isHidden ? 1.0 : 0.0
            self.botLabel.alpha = self.botLabel.isHidden ? 1.0 : 0.0
            
            self.topLabel.isHidden.toggle()
            self.botLabel.isHidden.toggle()
            
        }
    }
}

class HeaderView: UIView {
    let label = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    func commonInit() {
        label.textAlignment = .center
        self.addSubview(label)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: topAnchor, constant: 10.0),
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10.0),
            label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 10.0),
            label.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 10.0),
            label.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}

class contentsView: UIView {
    
    let label = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    func commonInit() {
        self.addSubview(label)
        label.numberOfLines = 0
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: topAnchor, constant: 0.0),
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0.0),
            label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0.0),
        ])
        
        let c = label.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0.0)
        c.priority = .required - 1
        c.isActive = true
        
        
        label.setContentCompressionResistancePriority(.required, for: .vertical)
        
        
        self.clipsToBounds = true
    }
}
