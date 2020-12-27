//
//  HomeHeaderView.swift
//  pokemon-app
//
//  Created by Edno Fedulo on 27/12/20.
//

import UIKit

protocol HomeHeaderViewDelegate:AnyObject {
    func search(query:String?)
}

class HomeHeaderView: UIView {

    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 36)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var subtitleLabel:UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .secondaryLabel
        return label
    }()
    
    lazy var searchTextField: CustomTextField = {
        let textField = CustomTextField()
        
        let iconImageView = UIImageView(image: UIImage(systemName: "magnifyingglass")?.withRenderingMode(.alwaysTemplate))
        iconImageView.tintColor = .secondaryLabel
                                        
        textField.clearButtonMode = .always
        textField.leftView = iconImageView
        textField.leftViewMode = .always
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = .quaternarySystemFill
        textField.layer.cornerRadius = 5
        
        textField.delegate = self
        return textField
    }()
    
    let title:String?
    let subtitle:String?
    let searchPlaceholder:String?
    var delegate:HomeHeaderViewDelegate?
    
    init(title:String, subtitle:String, searchPlaceholder:String) {
        self.title = title
        self.subtitle = subtitle
        self.searchPlaceholder = searchPlaceholder
        super.init(frame: CGRect.zero)
        
        addSubviews()
        setupConstraints()
        setupView()
    }
    
    func addSubviews(){
        self.addSubview(titleLabel)
        self.addSubview(subtitleLabel)
        self.addSubview(searchTextField)
    }
    
    func setupConstraints(){
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10)
        ])
        
        NSLayoutConstraint.activate([
            subtitleLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            subtitleLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            searchTextField.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            searchTextField.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 10),
            searchTextField.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            self.bottomAnchor.constraint(equalTo: searchTextField.bottomAnchor, constant: 10)
        ])
    }
    
    func setupView(){
        self.titleLabel.text = title
        self.subtitleLabel.text = subtitle
        self.searchTextField.placeholder = searchPlaceholder
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension HomeHeaderView:UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        delegate?.search(query: textField.text)
        return false
    }
}
