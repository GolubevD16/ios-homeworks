//
//  Status.swift
//  Navigation
//
//  Created by Дмитрий Голубев on 18.10.2021.
//

import UIKit

class StatusView: UIView {
    
    var delegate: ShowAlert?
    var tit: String?
    var residents: [ResidentModel]?
    
    private enum Constants{
        static let buttomWidth: Double = 250
        static let buttomHeight: Int = 44
    }
    
    lazy var alertButton: CustomButton = {
        alertButton = CustomButton(title: "Big red button", titleColor: .white, onTap: delegate?.showAlert)
        alertButton.translatesAutoresizingMaskIntoConstraints = false
        addSubview(alertButton)
        // Большая красная кнопка
        
        
        return alertButton
    }()
    
    lazy var label: UILabel = {
        label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.backgroundColor = .white
        label.toAutoLayout()
        addSubview(label)
        
        return label
    }()
    
    lazy var label2: UILabel = {
        label2 = UILabel()
        label2.font = .systemFont(ofSize: 16)
        label2.backgroundColor = .white
        label2.toAutoLayout()
        addSubview(label2)
        
        return label2
    }()
    
    lazy var tableView: UITableView = {
        tableView = UITableView(frame: .zero, style: .plain)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "MyTable")
        tableView.toAutoLayout()
        tableView.dataSource = self
        addSubview(tableView)
        
        return tableView
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        NotificationCenter.default.addObserver(self, selector: #selector(reloadDate), name: .addResident, object: nil)
    }
    
    @objc func reloadDate(){
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    override func layoutSubviews() {
        setupButton()
        NSLayoutConstraint.activate([
            alertButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            alertButton.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -250),
            
            label.centerXAnchor.constraint(equalTo: alertButton.centerXAnchor),
            label.bottomAnchor.constraint(equalTo: alertButton.topAnchor, constant: -32),
            
            label2.centerXAnchor.constraint(equalTo: label.centerXAnchor),
            label2.bottomAnchor.constraint(equalTo: label.topAnchor, constant: -32),
            
            tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
            tableView.topAnchor.constraint(equalTo: alertButton.bottomAnchor, constant: 16),
            tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8),
            tableView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -52),
        ])
    }
    
    private func setupButton() {
        alertButton.titleLabel?.font = .boldSystemFont(ofSize: 20)
        alertButton.layer.backgroundColor = UIColor.red.cgColor
    }
}

extension StatusView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return residents?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyTable", for: indexPath)
        cell.textLabel?.text = residents?[indexPath.row].name
        
        return cell
    }
    
}
