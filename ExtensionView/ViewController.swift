//
//  ViewController.swift
//  ExtensionView
//
//  Created by 강조은 on 2023/12/19.
//

import UIKit

class ViewController: UIViewController {
    
    private let contentScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()
    
    let scrollContentsView = UIView()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [headerView, emptyView, topLabel, botLabel])
        stackView.axis = .vertical
        stackView.spacing = 0
        return stackView
    }()
    
    let headerView: UIButton = {
        let view = UIButton()
        view.setTitle("Header", for: .normal)
        view.backgroundColor = .red
        view.addTarget(self, action: #selector(btnTap), for: .touchUpInside)
        return view
    }()
    
    let emptyView = ContentsView()
    
    let topLabel: ContentsView = {
        let label = ContentsView()
        label.label.text = "첫 번째 문장 첫 번째 문장 첫 번째 문장 첫 번째 문장 첫 번째 문장 첫 번째 문장 첫 번째 문장 첫 번째 문장 첫 번째 문장 첫 번째 문장 첫 번째 문장"
        label.backgroundColor = .blue
        return label
    }()
    
    let botLabel: ContentsView = {
        let label = ContentsView()
        label.label.text = "세 번째 문장 세 번째 문장 세 번째 문장 세 번째 문장"
        label.backgroundColor = .purple
        return label
    }()
    
    let contentsView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        contentsView.backgroundColor = .yellow
        
        let label = UILabel()
        label.text = String(repeating: "@@@@@@@@@@@@@@", count: 100)
        label.textAlignment = .center
        label.numberOfLines = 0
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        contentsView.translatesAutoresizingMaskIntoConstraints = false
        label.translatesAutoresizingMaskIntoConstraints = false
        topLabel.translatesAutoresizingMaskIntoConstraints = false
        contentScrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollContentsView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(contentScrollView)
        contentScrollView.addSubview(scrollContentsView)
        scrollContentsView.addSubview(stackView)
        scrollContentsView.addSubview(contentsView)
        contentsView.addSubview(label)
        
        NSLayoutConstraint.activate([
            contentScrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            contentScrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            contentScrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            contentScrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            scrollContentsView.topAnchor.constraint(equalTo: contentScrollView.topAnchor),
            scrollContentsView.leadingAnchor.constraint(equalTo: contentScrollView.leadingAnchor),
            scrollContentsView.trailingAnchor.constraint(equalTo: contentScrollView.trailingAnchor),
            scrollContentsView.bottomAnchor.constraint(equalTo: contentScrollView.bottomAnchor),
            scrollContentsView.widthAnchor.constraint(equalTo: contentScrollView.widthAnchor),
            
            stackView.topAnchor.constraint(equalTo: scrollContentsView.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: scrollContentsView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: scrollContentsView.trailingAnchor),

            contentsView.topAnchor.constraint(equalTo: stackView.bottomAnchor),
            contentsView.leadingAnchor.constraint(equalTo: scrollContentsView.leadingAnchor),
            contentsView.trailingAnchor.constraint(equalTo: scrollContentsView.trailingAnchor),
            contentsView.bottomAnchor.constraint(equalTo: scrollContentsView.bottomAnchor),
            
            label.topAnchor.constraint(equalTo: contentsView.topAnchor),
            label.leadingAnchor.constraint(equalTo: contentsView.leadingAnchor),
            label.trailingAnchor.constraint(equalTo: contentsView.trailingAnchor),
            label.bottomAnchor.constraint(equalTo: contentsView.bottomAnchor)
        ])
        scrollContentsView.heightAnchor.constraint(equalTo: contentScrollView.heightAnchor).priority = .init(UILayoutPriority.defaultHigh.rawValue)
        
        topLabel.alpha = 1
        botLabel.alpha = 1
        
        topLabel.isHidden = true
        botLabel.isHidden = true
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

class ContentsView: UIView {
    
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
