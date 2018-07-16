import UIKit

protocol TableViewSetUpService: class {
    associatedtype T
    func setUp(tableView: UITableView, cell: UITableViewCell.Type?)
    func dequeueReusableCell<T: UITableViewCell>(tableView: UITableView, forIndexPath indexPath: IndexPath) -> T
    
}

extension TableViewSetUpService where Self: UIViewController & UITableViewDataSource & UITableViewDelegate {
    func setUp(tableView: UITableView, cell: UITableViewCell.Type? = nil) {
        tableView.delegate = self
        tableView.dataSource = self
        if let cell = cell {
            tableView.register(UINib(nibName: cell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: cell.reuseIdentifier)
        }
    }
    
    func dequeueReusableCell<T: UITableViewCell>(tableView: UITableView, forIndexPath indexPath: IndexPath) -> T {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.reuseIdentifier)")
        }
        return cell
    }
}

protocol CollectionViewSetUpService: class {
    associatedtype T
    func setUp(collectionView: UICollectionView, cell: UICollectionViewCell.Type?)
    func dequeueReusableCell<T: UICollectionViewCell>(collectionView: UICollectionView, forIndexPath indexPath: IndexPath) -> T
}

extension CollectionViewSetUpService where Self: UIViewController & UICollectionViewDelegate & UICollectionViewDataSource {
    func setUp(collectionView: UICollectionView, cell: UICollectionViewCell.Type? = nil){
        collectionView.delegate = self
        collectionView.dataSource = self
        if let cell = cell {
            collectionView.register(UINib(nibName: cell.reuseIdentifier, bundle: nil), forCellWithReuseIdentifier: cell.reuseIdentifier)
        }
    }
    
    func dequeueReusableCell<T: UICollectionViewCell>(collectionView: UICollectionView, forIndexPath indexPath: IndexPath) -> T {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.reuseIdentifier)")
        }
        return cell
    }
}
