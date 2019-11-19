//
// Copyright © 2019 Optimize Fitness Inc.
// Licensed under the MIT license
// https://github.com/OptimizeFitness/Minerva/blob/master/LICENSE
//

import Foundation
import UIKit

public final class ImageCellModel: BaseListCellModel, ListSelectableCellModel {

  public var selectionAction: ((_ cellModel: ImageCellModel, _ indexPath: IndexPath) -> Void)?
  private let cellIdentifier: String
  public var imageColor: UIColor?
  public var contentMode: UIView.ContentMode = .scaleAspectFit
  public var directionalLayoutMargins = NSDirectionalEdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16)

  public let image: UIImage
  public let imageSize: CGSize

  public convenience init(image: UIImage, imageSize: CGSize) {
    self.init(identifier: "ImageCellModel", image: image, imageSize: imageSize)
  }

  public init(identifier: String, image: UIImage, imageSize: CGSize) {
    self.image = image
    self.imageSize = imageSize
    self.cellIdentifier = identifier
    super.init()
  }

  // MARK: - BaseListCellModel

  override public var identifier: String {
    return cellIdentifier
  }

  override public func identical(to model: ListCellModel) -> Bool {
    guard let model = model as? Self, super.identical(to: model) else { return false }
    return image == model.image
      && imageSize == model.imageSize
      && contentMode == model.contentMode
      && imageColor == model.imageColor
  }

  override public func size(
    constrainedTo containerSize: CGSize,
    with templateProvider: () -> ListCollectionViewCell
  ) -> ListCellSize {
    let width = containerSize.width
    let cell = templateProvider()
    let cellHeight = imageSize.height + cell.layoutMargins.top + cell.layoutMargins.bottom
    return .explicit(size: CGSize(width: width, height: cellHeight))
  }
}

public final class ImageCell: BaseListCell<ImageCellModel> {

  private let imageView: UIImageView = {
    let imageView = UIImageView()
    return imageView
  }()
  private let imageWidthConstraint: NSLayoutConstraint

  override public init(frame: CGRect) {
    imageWidthConstraint = imageView.widthAnchor.constraint(equalToConstant: 0)
    super.init(frame: frame)
    contentView.addSubview(imageView)
    setupConstraints()
  }

  override public func prepareForReuse() {
    super.prepareForReuse()
    imageView.image = nil
  }

  override public func bind(model: ImageCellModel, sizing: Bool) {
    super.bind(model: model, sizing: sizing)
    imageWidthConstraint.constant = model.imageSize.width
    contentView.directionalLayoutMargins = model.directionalLayoutMargins

    guard !sizing else { return }

    imageView.contentMode = model.contentMode

    if let imageColor = model.imageColor {
      imageView.image = model.image.withRenderingMode(.alwaysTemplate)
      imageView.tintColor = imageColor
    } else {
      imageView.image = model.image
    }
  }
}

// MARK: - Constraints
extension ImageCell {
  private func setupConstraints() {
    let layoutGuide = contentView.layoutMarginsGuide
    imageView.anchor(toLeading: nil, top: layoutGuide.topAnchor, trailing: nil, bottom: layoutGuide.bottomAnchor)
    imageView.centerXAnchor.constraint(equalTo: layoutGuide.centerXAnchor).isActive = true

    imageWidthConstraint.isActive = true

    contentView.shouldTranslateAutoresizingMaskIntoConstraints(false)
  }
}
