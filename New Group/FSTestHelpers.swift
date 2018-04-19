import Foundation

//MARK: - Tests types
enum TestKeys {
    static let testing = "Testing"
}

enum ApplicationLaunchSettings {
    case example(String)
    
    var key: String {
        switch self {
        case .example(_): return "EXAMPLE_SETTING"
        }
    }
    
    var value: String {
        switch self {
        case .example(let value): return value
        }
    }
}

enum TestingMode: String {
    case Unit   = "Unit"
    case UI     = "UI"
    
    init() {
        guard let modeString = GET_ENVIRONMENT(key: TestKeys.testing) else {
            fatalError("Testing mode not defined")
        }
        
        switch modeString {
        case TestingMode.Unit.rawValue:
            self = .Unit
            
        case TestingMode.UI.rawValue:
            self = .UI
            
        default:
            fatalError("Testing mode is wrong")
        }
    }
}

//MARK: -
func IS_RUNNING_TESTS() -> Bool {
    return GET_ENVIRONMENT(key: TestKeys.testing) != nil
}

func IS_RUNNING_UI_TESTS() -> Bool {
    return GET_ENVIRONMENT(key: TestKeys.testing) != nil && TestingMode() == .UI
}

func IS_RUNNING_UNIT_TESTS() -> Bool {
    return GET_ENVIRONMENT(key: TestKeys.testing) != nil && TestingMode() == .Unit
}

func HAS_LAUNCH_ARGUMENT(argument: String) -> Bool {
    let arguments = ProcessInfo.processInfo.arguments
    return arguments.contains(argument)
}

func GET_ENVIRONMENT(key: String) -> String? {
    let environments = ProcessInfo.processInfo.environment
    return environments[key]
}

//MARK: - Bundles
func BUNDLE_FOR_UNIT_TESTS() -> Bundle {
    return Bundle(identifier: "com.flatstack.Swift-BaseTests")!
}

func BUNDLE_FOR_UI_TESTS() -> Bundle {
    return Bundle(identifier: "FS.Swift-BaseUITests")!
}

func INFO_DICTIONARY_FOR_CURRENT_BUNDLE() -> [String : Any]? {
    if IS_RUNNING_UNIT_TESTS() {
        return BUNDLE_FOR_UNIT_TESTS().infoDictionary
    } else if IS_RUNNING_UI_TESTS() {
        fatalError("The UI tests running like a separate application and Info.plist don't available")
    } else {
        return Bundle.main.infoDictionary
    }
}
