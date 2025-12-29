import UIKit

class ViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UISearchBarDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var filterSegmentedControleer: UISegmentedControl!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var selectedMediaType: MediaType = .movie
    var items : [SearchItem] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Search"
        
        collectionView.dataSource = self
        collectionView.delegate = self
        searchBar.delegate = self
                
    }

    @IBAction func mediaTypeChanged(_ sender: Any) {
        
        switch (sender as AnyObject).selectedSegmentIndex {
        case 0:
            selectedMediaType = .movie
        case 1:
            selectedMediaType = .music
        case 2:
            selectedMediaType = .ebook
        case 3:
            selectedMediaType = .podcast
        default:
            break
        }
        
    }
    
    //collectionview
    func collectionView(_ collectionView: UICollectionView,layout collectionViewLayout: UICollectionViewLayout,sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let spacing: CGFloat = 10
        let insets: CGFloat = 10
        let totalHorizontalSpace = (spacing * 1) + (insets * 2)
        let availableWidth = collectionView.bounds.width - totalHorizontalSpace
        let itemWidth = floor(availableWidth / 2)
        let itemHeight: CGFloat = itemWidth + 100
        
        return CGSize(width: itemWidth, height: itemHeight)
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        items.count
    }

    func collectionView(_ collectionView: UICollectionView,cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell",for: indexPath) as! SearchCollectionViewCell
        cell.configure(with: items[indexPath.row])
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        let selectedItem = items[indexPath.row]

        guard let detailVC = storyboard?.instantiateViewController(
            withIdentifier: "DetailViewController"
        ) as? DetailVC else {
            return
        }

        detailVC.item = selectedItem
        navigationController?.pushViewController(detailVC, animated: true)
    }

    
    
    
    //searchbar
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {

        guard searchText.count >= 3 else {
            items = []
            collectionView.reloadData()
            return
        }

        APIService.shared.search(term: searchText,mediaType: selectedMediaType) { [weak self] items in
            DispatchQueue.main.async {
                self?.items = items
                self?.collectionView.reloadData()
            }
        }
    }
    
    
}



