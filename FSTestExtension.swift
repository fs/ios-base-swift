import XCTest

@testable import Swift_Base

//MARK: -
extension XCTestCase {
    func testActions(forControl control: UIControl, getActionsForTarget target:(object: AnyObject, event: UIControlEvents), mustBeNumberOfActions: Int, mustBeSelectors: Set<Selector>) {
        let actions = control.actions(forTarget: target.object, forControlEvent: target.event)
        XCTAssertNotNil(actions, "\(control) not have targets")
        XCTAssertEqual(actions!.count, mustBeNumberOfActions, "Action of \(control) not equal \(mustBeNumberOfActions)")
        for currentAction in actions! {
            let currentSelector = Selector(currentAction)
            XCTAssertTrue(mustBeSelectors.contains(currentSelector))
        }
    }
    
    func testSendAction(selector: Selector, to: Any? = nil, from: Any? = nil) {
        UIApplication.shared.sendAction(selector, to: to, from: from, for: nil)
    }
}

//MARK: -
extension UIViewController {
    func canPerformSegue(_ id: String) -> Bool {
        let segues = self.value(forKey: "storyboardSegueTemplates") as? [NSObject]
        guard let filtered = segues?.filter({ $0.value(forKey: "identifier") as? String == id }) else { return false }
        return filtered.count > 0
    }

    // Just so you dont have to check all the time
    func performSegue(_ id: String, sender: AnyObject?) -> Bool {
        if self.canPerformSegue(id) {
            self.performSegue(withIdentifier: id, sender: sender)
            return true
        }
        return false
    }
}

//MARK: -
extension UITableView {
    func touchRandomVisibleCell(_ inSection: Int, animated: Bool = false, scrollPosition: UITableViewScrollPosition = .none) -> Bool {
        guard var indexPathsForVisibleRows = self.indexPathsForVisibleRows , indexPathsForVisibleRows.count > 0 else { return false }
        indexPathsForVisibleRows = indexPathsForVisibleRows.filter { (indexPath) -> Bool in
            return (indexPath as NSIndexPath).section == inSection
        }

        guard indexPathsForVisibleRows.count > 0 else { return false }

        let index = Int(arc4random_uniform(UInt32(indexPathsForVisibleRows.count)))
        let indexPath = indexPathsForVisibleRows[index]
        self.selectRow(at: indexPath, animated: animated, scrollPosition: scrollPosition)
        self.delegate?.tableView?(self, didSelectRowAt: indexPath)
        return true
    }
}

extension UICollectionView {
    func touchRandomVisibleCell(_ inSection: Int, animated: Bool = false, scrollPosition: UICollectionViewScrollPosition = UICollectionViewScrollPosition()) -> Bool {
        var indexPathsForVisibleItems = self.indexPathsForVisibleItems
        guard indexPathsForVisibleItems.count > 0 else { return false }
        indexPathsForVisibleItems = indexPathsForVisibleItems.filter { (indexPath) -> Bool in
            return (indexPath as NSIndexPath).section == inSection
        }

        guard indexPathsForVisibleItems.count > 0 else { return false }

        let index = Int(arc4random_uniform(UInt32(indexPathsForVisibleItems.count)))
        let indexPath = indexPathsForVisibleItems[index]
        self.selectItem(at: indexPath, animated: animated, scrollPosition: scrollPosition)
        self.delegate?.collectionView?(self, didSelectItemAt: indexPath)
        return true
    }
}

//MARK: -
extension UIAlertAction {
    typealias HandlerAction = ((UIAlertAction) -> Void)

    var handler: HandlerAction? {
        return self.value(forKey: "simpleHandler") as? HandlerAction
    }
}

