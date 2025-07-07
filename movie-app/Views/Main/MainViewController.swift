//
//  MainViewController.swift
//  movie-app
//
//  Created by Omar on 06/07/2025.
//

import Combine
import UIKit

class MainViewController: BaseViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    private var viewModel: MoviesViewModel?
    private var cancellables = Set<AnyCancellable>()
    private var movies: [MovieModel] = []

    func setupCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        let nib = UINib(nibName: "MovieCardCellView", bundle: nil)
        collectionView.register(
            nib,
            forCellWithReuseIdentifier: "MovieCardCellView"
        )
    }



    override func viewDidLoad() {
        self.title = "Popular Movies"
        setupCollectionView()
        if viewModel == nil {
            let movieRepository = MovieRepositoryImpl(
                remoteDataSource: MovieRemoteDataSource(),
                localDataSource: MovieLocalDataSource(),
            )
            self.viewModel = MoviesViewModel(movieRepository: movieRepository)
        }
        Task {
            await viewModel?.getMovies()
        }

        // Observe published movies
        viewModel!.$moviesList
            .receive(on: RunLoop.main)
            .sink { [weak self] data in
                self?.movies = data as? [MovieModel] ?? []
                self?.collectionView.reloadData()
            }
            .store(in: &cancellables)
        super.viewDidLoad()
    }

}

extension MainViewController: UICollectionViewDataSource {
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return movies.count
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let movie = movies[indexPath.item]
        let cell =
            collectionView.dequeueReusableCell(
                withReuseIdentifier: "MovieCardCellView",
                for: indexPath
            ) as! MovieCardCellView
        cell.configure(with: movie)
        return cell
    }
}

extension MainViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let width = (collectionView.frame.width - 10) / 2
        return CGSize(width: width, height: 250)
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumLineSpacingForSectionAt section: Int
    ) -> CGFloat {
        return 20
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumInteritemSpacingForSectionAt section: Int
    ) -> CGFloat {
        return 0
    }
}

extension ViewController: UICollectionViewDelegate {
    func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        print(indexPath.item)
    }

}
