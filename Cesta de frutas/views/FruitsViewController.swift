//
//  FruitsViewController.swift
//  Cesta de frutas
//
//  Created by Joel Júnior on 27/01/20.
//  Copyright © 2020 jnr. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class FruitsViewController: UIViewController {
    
    var fruitsViewModel = FruitsViewModel()
    var isDeleting = false
    
    let tableView: UITableView = {
        var tableView = UITableView()
        tableView.backgroundColor = .white
        tableView.tableFooterView = UIView()
        return tableView
    }()
    
    let buttonAdd: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(rgb: Colors.blue)
        let image = UIImage(named: "ic_add")?.withRenderingMode(.alwaysTemplate)
        button.setImage(image, for: .normal)
        button.layer.cornerRadius = 30
        button.tintColor = .white
        return button
    }()
    
    let buttonDelete: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(rgb: Colors.blue)
        let image = UIImage(named: "ic_delete")?.withRenderingMode(.alwaysTemplate)
        button.setImage(image, for: .normal)
        button.layer.cornerRadius = 30
        button.imageView!.tintColor = .white
        return button
    }()
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Cesta de Frutas"
        view.backgroundColor = .white
        navigationController?.navigationBar.barTintColor = UIColor(rgb: Colors.blue)
        navigationController?.navigationBar.isTranslucent = false
        
        tableView.register(FruitCell.self, forCellReuseIdentifier: "FruitCell")
                                
        fruitsViewModel.dataSource.bind(to: tableView.rx.items(cellIdentifier: "FruitCell")) {
            index,fruit,cell in
            
            if let cellToUse = cell as? FruitCell {
                cellToUse.setCell(index: index + 1, fruit: fruit)
            }
        }.disposed(by: disposeBag)
        
        tableView.rx.modelSelected(Fruit.self).subscribe(onNext: { (fruit) in
            if self.isDeleting {
                let alert = UIAlertController(title: "Exemplo de Delete", message: "Tem certeza que deseja excluir \(fruit.name)?", preferredStyle: .alert)
    
                alert.addAction(UIAlertAction(title: "Sim", style: .default, handler: { _ in
                    self.fruitsViewModel.delete(fruit: fruit)
                    if let selectedRowIndexPath = self.tableView.indexPathForSelectedRow {
                        self.tableView.deselectRow(at: selectedRowIndexPath, animated: true)
                    }
                }))
    
                alert.addAction(UIAlertAction(title: "Não", style: .cancel, handler: { _ in
                    if let selectedRowIndexPath = self.tableView.indexPathForSelectedRow {
                        self.tableView.deselectRow(at: selectedRowIndexPath, animated: true)
                    }
                }))
                
                self.present(alert, animated: true, completion: nil)
            } else {
                if let selectedRowIndexPath = self.tableView.indexPathForSelectedRow {
                    self.tableView.deselectRow(at: selectedRowIndexPath, animated: true)
                }
            }
        }).disposed(by: disposeBag)
        
        setupViews()
    }

    func setupViews() {
        view.addSubview(tableView)
        view.addSubview(buttonAdd)
        view.addSubview(buttonDelete)

        view.addConstraintWithFormat(format: "H:|[v0]|", views: tableView)
        view.addConstraintWithFormat(format: "V:|[v0]|", views: tableView)
        
        view.addConstraintWithFormat(format: "H:[v0(60)]-24-|", views: buttonAdd)
        view.addConstraintWithFormat(format: "H:[v0(60)]-24-|", views: buttonDelete)
        view.addConstraintWithFormat(format: "V:[v0(60)]-24-[v1(60)]-40-|", views: buttonDelete, buttonAdd)
        
        buttonAdd.addTarget(self, action: #selector(clickAdd), for: .touchUpInside)
        buttonDelete.addTarget(self, action: #selector(clickDelete), for: .touchUpInside)

    }
    
    @objc func clickAdd() {
        let alert = UIAlertController(title: "Exemplo de Insert", message: "Insira um nome para a fruta a ser adicionada a cesta:", preferredStyle: .alert)

        alert.addTextField()

        alert.addAction(UIAlertAction(title: "Salvar", style: .default, handler: { [weak alert] (_) in
            let textField = alert?.textFields![0]
            
            let text = textField?.text?.replacingOccurrences(of: " ", with: "") ?? ""
            
            if (text != "") {
                self.fruitsViewModel.insert(fruit: Fruit(name: text))
//                self.tableView.reloadData()
            }
        }))
        
        alert.addAction(UIAlertAction(title: "Cancelar", style: .cancel, handler: nil))

        self.present(alert, animated: true, completion: nil)
    }
    
    @objc func clickDelete() {
        if isDeleting {
            isDeleting = false
            let image = UIImage(named: "ic_delete")?.withRenderingMode(.alwaysTemplate)
            buttonDelete.setImage(image, for: .normal)
        } else {
            isDeleting = true
            let image = UIImage(named: "ic_cancel")?.withRenderingMode(.alwaysTemplate)
            buttonDelete.setImage(image, for: .normal)
        }
    }
}
