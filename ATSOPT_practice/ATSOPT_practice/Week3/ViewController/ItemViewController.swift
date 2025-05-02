//
//  ItemViewController.swift
//  ATSOPT_practice
//
//  Created by 최주리 on 4/26/25.
//

import UIKit

import SnapKit
import Then

final class ItemViewController: UIViewController {
    private let itemList: [ItemModel] = ItemModel.dummy()
    
    private let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    private let carrotLineSpacing: CGFloat = 10
    private let carrotInterLineSpacing: CGFloat = 21
    private let cellHeight: CGFloat = 198
    private let carrotInset = UIEdgeInsets(top: 48, left: 20, bottom: 10, right: 20)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.register(ItemCollectionViewCell.self, forCellWithReuseIdentifier: ItemCollectionViewCell.identifier)
//        setCollectionViewLayout()
        setDelegate()
        
        setLayout()
    }
}

extension ItemViewController {
    private func setLayout() {
        view.addSubview(collectionView)
        
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    private func setDelegate() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    private func setCollectionViewLayout() {
//        let flowLayout = UICollectionViewFlowLayout()
//        
//        let screenWidth = UIScreen.main.bounds.width
//        let doubleCellWidth = screenWidth - carrotInset.left - carrotInset.right - carrotInterLineSpacing
        
//        flowLayout.itemSize = CGSize(width: doubleCellWidth / 2, height: 198)
//        flowLayout.minimumLineSpacing = carrotLineSpacing
//        flowLayout.minimumInteritemSpacing = carrotInterLineSpacing
//        self.collectionView.setCollectionViewLayout(flowLayout, animated: false)
    }
}

extension ItemViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenWidth = UIScreen.main.bounds.width
        let cellWidth = screenWidth - carrotInset.left - carrotInset.right - carrotInterLineSpacing
        
        return CGSize(width: cellWidth / 2, height: 198)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return carrotLineSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return carrotInterLineSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return carrotInset
    }
}

extension ItemViewController: UICollectionViewDelegate {
    
}

extension ItemViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return itemList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ItemCollectionViewCell.identifier, for: indexPath) as? ItemCollectionViewCell else { return UICollectionViewCell() }
        
        cell.dataBind(itemList[indexPath.row])
        return cell
    }
}

#Preview {
    ItemViewController()
}
