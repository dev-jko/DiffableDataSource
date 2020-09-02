//
//  ViewController.swift
//  DiffableDataSource
//
//  Created by Jaedoo Ko on 2020/09/01.
//  Copyright © 2020 jko. All rights reserved.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    private let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    private var dataSource: UICollectionViewDiffableDataSource<Section, Todo>!
    private var todos = (0...60).map {
        Todo(id: $0, title: "\($0)", isCompleted: $0 % 2 == 0)
    }
    private var timer = DispatchSource.makeTimerSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpLayout()
        configureCollectionView()
        bindStyles()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        startTimer()
    }

    private func startTimer() {
        timer.schedule(deadline: .now(), repeating: .seconds(3))
        timer.setEventHandler { [weak self] in
            guard let `self` = self else { return }
            self.shuffleTodos()
            self.loadTodos()
        }
        timer.resume()
    }
    
    private func setUpLayout() {
        view.addSubview(collectionView)
        
        collectionView.snp.makeConstraints { make in
            make.edges.equalTo(view)
        }
    }

    private func configureCollectionView() {
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView) { collectionView, indexPath, item in
            if item.isCompleted {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CompletedTodoCell.identifier, for: indexPath) as? CompletedTodoCell
                cell?.configure(item: item)
                return cell
            } else {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: InProgressCell.identifier, for: indexPath) as? InProgressCell
                cell?.configure(item: item)
                return cell
            }
        }
        
        collectionView.dataSource = dataSource
        
        collectionView.register(CompletedTodoCell.self, forCellWithReuseIdentifier: CompletedTodoCell.identifier)
        collectionView.register(InProgressCell.self, forCellWithReuseIdentifier: InProgressCell.identifier)
    }
    
    private func bindStyles() {
        collectionView.backgroundColor = .white
    }
    
    private func loadTodos() {
        let todos = self.todos
        var snapshot = NSDiffableDataSourceSnapshot<Section, Todo>()
        snapshot.appendSections([.inProgress, .completed])
        snapshot.appendItems(todos.filter { !$0.isCompleted }, toSection: .inProgress)
        snapshot.appendItems(todos.filter { $0.isCompleted }, toSection: .completed)
        DispatchQueue.global().async { [weak self] in
            self?.dataSource.apply(snapshot, animatingDifferences: true, completion: { print("apply completion") })
        }
    }
    
    private func shuffleTodos() {
        let randomNumber = Int.random(in: 1...15)
        todos = todos.map { todo in
            guard todo.id % randomNumber == 0 else {
                return todo
            }
            return Todo(id: todo.id, title: todo.title, isCompleted: !todo.isCompleted)
        }
    }
}
