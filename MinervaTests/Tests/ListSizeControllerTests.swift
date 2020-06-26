//
// Copyright © 2020 Optimize Fitness Inc.
// Licensed under the MIT license
// https://github.com/OptimizeFitness/Minerva/blob/master/LICENSE
//

import Foundation
import Minerva
import RxSwift
import XCTest

public final class ListSizeControllerTests: CommonSetupTestCase {
  public func testSectionSizing_verticalScrolling() {
    let cellModels = createCellModels(count: 19)
    let section = ListSection(cellModels: cellModels, identifier: "Section")

    let updateExpectation = expectation(description: "Update Expectation")
    listController.update(with: [section], animated: false) { finished in
      XCTAssertTrue(finished)
      updateExpectation.fulfill()
    }
    wait(for: [updateExpectation], timeout: 5)

    let containerSize = collectionVC.view.frame.size
    let size = listController.size(of: section, containerSize: containerSize)
    XCTAssertEqual(size, CGSize(width: collectionVC.view.frame.width, height: 1_900))
  }

  public func testSectionSizing_verticalScrolling_equalDistribution() {
    let cellModels = createCellModels(count: 19)
    var section = ListSection(cellModels: cellModels, identifier: "Section")
    section.constraints.distribution = .equally(cellsInRow: 3)

    let updateExpectation = expectation(description: "Update Expectation")
    listController.update(with: [section], animated: false) { finished in
      XCTAssertTrue(finished)
      updateExpectation.fulfill()
    }
    wait(for: [updateExpectation], timeout: 5)

    let containerSize = collectionVC.view.frame.size
    let size = listController.size(of: section, containerSize: containerSize)
    XCTAssertEqual(size, CGSize(width: collectionVC.view.frame.width, height: 700))
  }

  public func testSectionSizing_verticalScrolling_proportionalDistribution() {
    let cellModels = createCellModels(count: 19)
    var section = ListSection(cellModels: cellModels, identifier: "Section")
    section.constraints.distribution = .proportionally

    let updateExpectation = expectation(description: "Update Expectation")
    listController.update(with: [section], animated: false) { finished in
      XCTAssertTrue(finished)
      updateExpectation.fulfill()
    }
    wait(for: [updateExpectation], timeout: 5)

    let containerSize = collectionVC.view.frame.size
    let size = listController.size(of: section, containerSize: containerSize)
    XCTAssertEqual(size, CGSize(width: collectionVC.view.frame.width, height: 1_000))
  }

  public func testSectionSizing_verticalScrolling_proportionalDistributionWithLastCellFillingWidth() {

    func runTest(totalCells: Int, minimumWidth: CGFloat, expectLastCellSize: CGSize, expectSectionSize: CGSize) {
      let cellModels = createCellModelsWithRelativeLastCell(count: totalCells)
      var section = ListSection(cellModels: cellModels, identifier: "Section")
      section.constraints.distribution = .proportionallyWithLastCellFillingWidth(minimumWidth: minimumWidth)

      let updateExpectation = expectation(description: "Update Expectation")
      listController.update(with: [section], animated: false) { finished in
        XCTAssertTrue(finished)
        updateExpectation.fulfill()
      }
      wait(for: [updateExpectation], timeout: 5)

      let containerSize = collectionVC.view.frame.size
      let size = listController.size(of: section, containerSize: containerSize)
      let sizeConstraints = ListSizeConstraints(containerSize: containerSize, sectionConstraints: section.constraints)
      let lastCellSize = listController.size(of: section.cellModels.last!, with: sizeConstraints)
      XCTAssertEqual(lastCellSize, expectLastCellSize)
      XCTAssertEqual(size, expectSectionSize)
    }

    // collection view is width 200. text input has height 45. cells are height 50.
    runTest(totalCells: 1, minimumWidth: 100, expectLastCellSize: CGSize(width: 200, height: 45), expectSectionSize: CGSize(width: 200, height: 45))
    // add a cell, forces row to be height 50
    runTest(totalCells: 2, minimumWidth: 100, expectLastCellSize: CGSize(width: 150, height: 45), expectSectionSize: CGSize(width: 200, height: 50))
    // add another cell. last cell shrinks in width.
    runTest(totalCells: 3, minimumWidth: 100, expectLastCellSize: CGSize(width: 100, height: 45), expectSectionSize: CGSize(width: 200, height: 50))
    // last cell is pushed onto new row, so it is full width (200)
    runTest(totalCells: 4, minimumWidth: 100, expectLastCellSize: CGSize(width: 200, height: 45), expectSectionSize: CGSize(width: 200, height: 95))
  }

  public func testSectionSizing_horizontalScrolling() {
    let cellModels = createCellModels(count: 19)
    var section = ListSection(cellModels: cellModels, identifier: "Section")
    section.constraints.scrollDirection = .horizontal

    let updateExpectation = expectation(description: "Update Expectation")
    listController.update(with: [section], animated: false) { finished in
      XCTAssertTrue(finished)
      updateExpectation.fulfill()
    }
    wait(for: [updateExpectation], timeout: 5)

    let containerSize = collectionVC.view.frame.size

    let size = listController.size(of: section, containerSize: containerSize)
    XCTAssertEqual(size, CGSize(width: 1_425, height: 500))
  }

  /* MarginCell tests */

  public func testSectionSizing_marginCell_expandsToFillHeight() {
    let sizeManager = FakeSizeManagerForMarginCells()
    listController.sizeDelegate = sizeManager

    let marginCell = MarginCellModel()
    let cellModels: [ListCellModel] = createCellModels(count: 1) + [marginCell]
    let section = ListSection(cellModels: cellModels, identifier: "Section")

    let updateExpectation = expectation(description: "Update Expectation")
    listController.update(with: [section], animated: false) { finished in
      XCTAssertTrue(finished)
      updateExpectation.fulfill()
    }
    wait(for: [updateExpectation], timeout: 5)

    let containerSize = collectionVC.view.frame.size
    let size = listController.size(of: section, containerSize: containerSize)
    XCTAssertEqual(size, containerSize) // The layout fills the entire height because of the MarginCell

    let listSizeContraints = ListSizeConstraints(containerSize: containerSize, sectionConstraints: section.constraints)
    let marginCellSize = listController.size(of: marginCell, with: listSizeContraints)
    XCTAssertEqual(marginCellSize, CGSize(width: 200, height: 400))
  }

  public func testSectionSizing_multipleMarginCells_expandEquallyToFillHeight() {
    let sizeManager = FakeSizeManagerForMarginCells()
    listController.sizeDelegate = sizeManager

    let marginCellAbove = MarginCellModel()
    let marginCellBelow = MarginCellModel()

    let cellModels: [ListCellModel] = [marginCellAbove] + createCellModels(count: 1) + [marginCellBelow]
    let section = ListSection(cellModels: cellModels, identifier: "Section")

    let updateExpectation = expectation(description: "Update Expectation")
    listController.update(with: [section], animated: false) { finished in
      XCTAssertTrue(finished)
      updateExpectation.fulfill()
    }
    wait(for: [updateExpectation], timeout: 5)

    let containerSize = collectionVC.view.frame.size
    let size = listController.size(of: section, containerSize: containerSize)
    XCTAssertEqual(size, containerSize) // The margin cell filled the remaining height

    let listSizeContraints = ListSizeConstraints(containerSize: containerSize, sectionConstraints: section.constraints)
    let marginCellAboveSize = listController.size(of: marginCellAbove, with: listSizeContraints)
    XCTAssertEqual(marginCellAboveSize, CGSize(width: 200, height: 200))
    let marginCellBelowSize = listController.size(of: marginCellBelow, with: listSizeContraints)
    XCTAssertEqual(marginCellBelowSize, CGSize(width: 200, height: 200))
  }

  public func testSectionSizing_multipleMarginCells_expandEquallyToFillHeight_evenInDifferentSections() {
    let sizeManager = FakeSizeManagerForMarginCells()
    listController.sizeDelegate = sizeManager

    let marginCellInSection0 = MarginCellModel()
    let marginCellInSection1 = MarginCellModel()

    let section0models: [ListCellModel] = createCellModels(count: 2, idPrefix: "section0") + [marginCellInSection0]
    let section0 = ListSection(cellModels: section0models, identifier: "section0")

    let section1models: [ListCellModel] = createCellModels(count: 2, idPrefix: "section1") + [marginCellInSection1]
    let section1 = ListSection(cellModels: section1models, identifier: "section1")

    let updateExpectation = expectation(description: "Update Expectation")
    listController.update(with: [section0, section1], animated: false) { finished in
      XCTAssertTrue(finished)
      updateExpectation.fulfill()
    }
    wait(for: [updateExpectation], timeout: 5)

    let containerSize = collectionVC.view.frame.size
    let section0size = listController.size(of: section0, containerSize: containerSize)
    let halfSize = CGSize(width: containerSize.width, height: containerSize.height / 2.0)
    // Since each section is identical, they each should take 50% of height.
    XCTAssertEqual(section0size, halfSize)
    XCTAssertEqual(section0size, halfSize)

    // marginCellInSection0 took up 50% of 'free' height
    let listSizeContraints0 = ListSizeConstraints(containerSize: containerSize, sectionConstraints: section0.constraints)
    let marginCellInSection0Size = listController.size(of: marginCellInSection0, with: listSizeContraints0)
    XCTAssertEqual(marginCellInSection0Size, CGSize(width: 200, height: 50))

    // marginCellInSection1 took up 50% of 'free' height
    let listSizeContraints1 = ListSizeConstraints(containerSize: containerSize, sectionConstraints: section1.constraints)
    let marginCellInSection1Size = listController.size(of: marginCellInSection1, with: listSizeContraints1)
    XCTAssertEqual(marginCellInSection1Size, CGSize(width: 200, height: 50))
  }

  public func testSectionSizing_marginCells_shrinkToHeightOf1_whenContentHeightExceedsFrame() {
    let sizeManager = FakeSizeManagerForMarginCells()
    listController.sizeDelegate = sizeManager

    let marginCellInSection0 = MarginCellModel()
    let marginCellInSection1 = MarginCellModel()

    let section0models: [ListCellModel] = createCellModels(count: 10, idPrefix: "section0") + [marginCellInSection0]
    let section0 = ListSection(cellModels: section0models, identifier: "section0")

    let section1models: [ListCellModel] = createCellModels(count: 10, idPrefix: "section1") + [marginCellInSection1]
    let section1 = ListSection(cellModels: section1models, identifier: "section1")

    let updateExpectation = expectation(description: "Update Expectation")
    listController.update(with: [section0, section1], animated: false) { finished in
      XCTAssertTrue(finished)
      updateExpectation.fulfill()
    }
    wait(for: [updateExpectation], timeout: 5)

    let containerSize = collectionVC.view.frame.size

    // marginCellInSection0 shrunk to 1pt in height
    let listSizeContraints0 = ListSizeConstraints(containerSize: containerSize, sectionConstraints: section0.constraints)
    let marginCellInSection0Size = listController.size(of: marginCellInSection0, with: listSizeContraints0)
    XCTAssertEqual(marginCellInSection0Size, CGSize(width: 200, height: 1))

    // marginCellInSection1 shrunk to 1pt in height
    let listSizeContraints1 = ListSizeConstraints(containerSize: containerSize, sectionConstraints: section0.constraints)
    let marginCellInSection1Size = listController.size(of: marginCellInSection1, with: listSizeContraints1)
    XCTAssertEqual(marginCellInSection1Size, CGSize(width: 200, height: 1))
  }

  public func testSectionSizing_marginCells_whenDistributionIs_proportionallyWithLastCellFillingWidth() {
    // A more complicated layout since both MarginCells and proportionallyWithLastCellFillingWidth use
    // .relative cell sizing
    let sizeManager = FakeSizeManagerForMarginCells()
    listController.sizeDelegate = sizeManager

    // section 0 with proportionallyWithLastCellFillingWidth
    let section0models: [ListCellModel] = createCellModelsWithRelativeLastCell(count: 5)
    var section0 = ListSection(cellModels: section0models, identifier: "section-0")
    section0.constraints.distribution = .proportionallyWithLastCellFillingWidth(minimumWidth: 100)

    // section 1 with a margin cell
    let marginCellInSection1 = MarginCellModel()
    let section1models: [ListCellModel] = createCellModels(count: 5) + [marginCellInSection1]
    let section1 = ListSection(cellModels: section1models, identifier: "section-1")

    let updateExpectation = expectation(description: "Update Expectation")
    listController.update(with: [section0, section1], animated: false) { finished in
      XCTAssertTrue(finished)
      updateExpectation.fulfill()
    }
    wait(for: [updateExpectation], timeout: 5)

    let containerSize = collectionVC.view.frame.size

    let listSizeContraints1 = ListSizeConstraints(containerSize: containerSize, sectionConstraints: section1.constraints)
    let marginCellInSection1Size = listController.size(of: marginCellInSection1, with: listSizeContraints1)
    XCTAssertEqual(marginCellInSection1Size, CGSize(width: 200, height: 1))
  }
}
