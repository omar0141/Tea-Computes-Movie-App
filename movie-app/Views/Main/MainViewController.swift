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
        
        // Observe published movies
        viewModel!.$moviesList
            .receive(on: RunLoop.main)
            .sink { [weak self] data in
                self?.movies = data
                self?.collectionView.reloadData()
            }
            .store(in: &cancellables)
        
        Task {
            await viewModel?.getMovies()
        }

        
        super.viewDidLoad()
    }

}



// MARK: Collection View DataSource

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
        cell.configure(with: movie,viewModel: viewModel)
        return cell
    }
}



// MARK: Collection View Delegate Flow Layout

extension MainViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let width = (collectionView.frame.width - 20) / 2
        return CGSize(width: width, height: 300)
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
        return 20
    }
}



//MARK: Collection View Delegate

extension MainViewController: UICollectionViewDelegate {
    func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        AppRouter.shared.navigate(to: .details, data: ["movie": movies[indexPath.item], "viewModel": viewModel!])
    }

}
