//  AspectLayoutCV.swift
//  DemoCollection
//
//  Created by Hemang Solanki on 29/08/23.

import UIKit

class HorizontalMasonryLayout: UICollectionViewLayout {
    
//    private var cache = [UICollectionViewLayoutAttributes]()
//    private var contentHeight: CGFloat = 0.0
//    private var xOffset: CGFloat = 0.0
//
//    private var cellPadding: CGFloat = 6
//
//    private var contentWidth: CGFloat {
//        guard let collectionView = collectionView else {
//            return (collectionView?.bounds.width)!
//        }
//        return max(xOffset, collectionView.bounds.width)
//    }
//
//    override var collectionViewContentSize: CGSize {
//        return CGSize(width: contentWidth, height: contentHeight)
//    }
//
//    override func prepare() {
//        guard cache.isEmpty, let collectionView = collectionView else {
//            return
//        }
//
//        let contentWidth = collectionView.bounds.width - (collectionView.contentInset.left + collectionView.contentInset.right)
//        var yOffset: CGFloat = 0
//
//        for item in 0 ..< collectionView.numberOfItems(inSection: 0) {
//            let indexPath = IndexPath(item: item, section: 0)
//
//            // Fetch image's aspect ratio, this is a placeholder. Ensure you have the actual aspect ratio for your images.
//            let imageAspectRatio: CGFloat = 0.75
//
//            let photoWidth: CGFloat = contentWidth / 3 - cellPadding * 2
//            let photoHeight = photoWidth / imageAspectRatio
//
//            if yOffset + photoHeight > collectionView.bounds.height {
//                yOffset = 0
//                xOffset += contentWidth / 3
//            }
//
//            let frame = CGRect(x: xOffset, y: yOffset, width: photoWidth, height: photoHeight)
//            let insetFrame = frame.insetBy(dx: cellPadding, dy: cellPadding)
//
//            let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
//            attributes.frame = insetFrame
//            cache.append(attributes)
//
//            yOffset += photoHeight
//            contentHeight = max(contentHeight, yOffset)
//        }
//    }
//
//    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
//        var visibleLayoutAttributes = [UICollectionViewLayoutAttributes]()
//
//        for attributes in cache {
//            if attributes.frame.intersects(rect) {
//                visibleLayoutAttributes.append(attributes)
//            }
//        }
//        return visibleLayoutAttributes
//    }
//
//    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
//        return cache[indexPath.item]
//    }
    
    private var cache = [UICollectionViewLayoutAttributes]()
    private var contentWidth: CGFloat = 0.0
    private var columnsCount = 5
    private var cellPadding: CGFloat = 6

    private var contentHeight: CGFloat {
        guard let collectionView = collectionView else {
            return 0
        }
        let insets = collectionView.contentInset
        return collectionView.bounds.height - (insets.top + insets.bottom)
    }

    override var collectionViewContentSize: CGSize {
        return CGSize(width: contentWidth, height: contentHeight)
    }

    override func prepare() {
        guard cache.isEmpty, let collectionView = collectionView else {
            return
        }
        var offsets = Array(repeating: CGFloat(0), count: columnsCount)
        var column = 0
        for item in 0 ..< collectionView.numberOfItems(inSection: 0) {
            let indexPath = IndexPath(item: item, section: 0)
            let photoHeight: CGFloat = CGFloat(arc4random_uniform(100) + 50)
            let height = cellPadding * 2 + photoHeight
            let frame = CGRect(x: offsets[column], y: CGFloat(column) * contentHeight / CGFloat(columnsCount), width: height, height: contentHeight / CGFloat(columnsCount))
            let insetFrame = frame.insetBy(dx: cellPadding, dy: cellPadding)
            let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            attributes.frame = insetFrame
            cache.append(attributes)
            contentWidth = max(contentWidth, frame.maxX)
            offsets[column] = offsets[column] + height
            column = column >= (columnsCount - 1) ? 0 : (column + 1)
        }
    }

    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var visibleLayoutAttributes = [UICollectionViewLayoutAttributes]()
        for attributes in cache {
            if attributes.frame.intersects(rect) {
                visibleLayoutAttributes.append(attributes)
            }
        }
        return visibleLayoutAttributes
    }

    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return cache[indexPath.item]
    }

}
