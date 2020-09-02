//
//  Cells.swift
//  DiffableDataSource
//
//  Created by Jaedoo Ko on 2020/09/02.
//  Copyright © 2020 jko. All rights reserved.
//

import UIKit
import SnapKit

protocol CellType: class {
    associatedtype Item
    
    static var identifier: String { get }
    
    func configure(item: Item)
}

extension CellType {
    static var identifier: String {
        return (Self.self as AnyClass).description()
    }
}

class CompletedTodoCell: UICollectionViewCell, CellType {

    private let title: UILabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUpLayout()
        bindStyles()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpLayout() {
        contentView.addSubview(title)
        
        title.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(10)
        }
    }
    
    private func bindStyles() {
        contentView.backgroundColor = .white
        
        title.backgroundColor = .yellow
        title.textColor = .black
        title.textAlignment = .center
    }
    
    func configure(item: Todo) {
        title.text = item.title
    }
}

class InProgressCell: UICollectionViewCell, CellType {
    
    private let title: UILabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUpLayout()
        bindStyles()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpLayout() {
        contentView.addSubview(title)
        
        title.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(10)
        }
    }
    
    private func bindStyles() {
        contentView.backgroundColor = .white
        
        title.backgroundColor = .white
        title.textColor = .gray
        title.textAlignment = .center
    }
    
    func configure(item: Todo) {
        title.text = item.title
    }
}
