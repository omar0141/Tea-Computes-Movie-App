//
//  MovieCardView.swift
//  movie-app
//
//  Created by Omar on 07/07/2025.
//

import SDWebImage
import UIKit

class MovieCardCellView: UICollectionViewCell {

    @IBOutlet weak var movieImage: UIImageView!

    @IBOutlet weak var movieLabel: UILabel!

    @IBOutlet weak var rateLabel: UILabel!

    @IBOutlet weak var favouriteButton: UIButton!

    private var viewModel: MoviesViewModel?

    private var movie: MovieModel?

    func configure(with movie: MovieModel, viewModel: MoviesViewModel?) {
        if self.viewModel == nil {
            self.viewModel = viewModel
        }
        self.movie = movie
        movieLabel.text = movie.title
        rateLabel.text = String(floor(movie.voteAverage * 10) / 10)
        movieImage.sd_setImage(
            with: URL(string: ApiEndPoints.ImageUrl + movie.posterPath),
            placeholderImage: UIImage(named: movie.title)
        )
        let imageName = movie.isFavourite ? "heart.fill" : "heart"
        let image = UIImage(systemName: imageName)

        favouriteButton.setImage(image, for: .normal)
    }

    @IBAction func onFavouriteToggle(_ sender: Any) {
        viewModel?.toggleFavorite(movie: movie!)
    }
}
