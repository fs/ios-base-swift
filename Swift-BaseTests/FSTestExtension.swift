import XCTest
import OHHTTPStubs

@testable import TwiageHospital

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
        let filtered = segues?.filter({ $0.value(forKey: "identifier") as? String == id })
        return (filtered?.count > 0) 
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

//MARK: - STUB
extension RouterBootstrapProtocol where Self: RouterTypeProtocol {
    
    func performStub(status: Int32,
                     isSuccessResultData: Bool,
                     requestTimeDelay: Double = 0.0,
                     responseTimeDelay: Double = 0.0 /**OHHTTPStubsDownloadSpeedWifi*/) -> OHHTTPStubsDescriptor {
        
        let fileName = isSuccessResultData ? self.bootstrapSuccess : self.bootstrapFailure
        return self.performStub(status: status, fileName: fileName, requestTimeDelay: requestTimeDelay, responseTimeDelay: responseTimeDelay)
    }
    
    func performStub(status: Int32,
                     fileName: String,
                     requestTimeDelay: Double = 0.0,
                     responseTimeDelay: Double = 0.0 /**OHHTTPStubsDownloadSpeedWifi*/) -> OHHTTPStubsDescriptor {
        
        let routerRequest = self.request()
        return stub(condition: { (request) -> Bool in
            guard routerRequest.request?.url == request.url else { return false }
            return true
        }) { (request) -> OHHTTPStubsResponse in
            let filePath = OHPathForFileInBundle(fileName, BUNDLE_FOR_UNIT_TESTS())
            XCTAssertNotNil(filePath, "The file \"\(fileName)\" not found")
            return fixture(filePath: filePath!, status: status, headers: nil).requestTime(requestTimeDelay, responseTime: responseTimeDelay)
        }
    }
}

import ObjectMapper
fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l < r
  case (nil, _?):
    return true
  default:
    return false
  }
}

fileprivate func > <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l > r
  default:
    return rhs < lhs
  }
}

