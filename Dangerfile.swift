import Danger
import DangerXCodeSummary // package: https://github.com/f-meloni/danger-swift-xcodesummary.git
import Foundation

let danger = Danger()

// Pull out the edited files and find ones that come from a sub-folder
// where our app lives
let editedFiles = danger.git.modifiedFiles + danger.git.createdFiles
let editedAppFiles = editedFiles.filter { $0.contains("/App") }

// Let people bail from the CHANGELOG check
let hasSkipChangelog = danger.github.pullRequest.body?.contains("#no_changelog")
let hasSkipChangelogLabel = danger.github.issue.labels.first { $0.name == "Skip Changelog" }
let skipCheck = hasSkipChangelog ?? false || (hasSkipChangelogLabel != nil)

// Request for a CHANGELOG entry with each app change
if editedAppFiles.count > 0 && !skipCheck {
  fail("Please add a CHANGELOG entry for these changes. If you would like to skip this check, add `#no_changelog` to the PR body and re-run CI.")
}

// Make it more obvious that a PR is a work in progress and shouldn't be merged yet
if danger.github.pullRequest.title.contains("WIP") {
    warn("PR is classed as Work in Progress")
}

// Warn when there is a big PR
if (danger.github.pullRequest.additions ?? 0) > 500 {
    warn("Big PR, try to keep changes smaller if you can")
}

// Run Swiftlint
//SwiftLint.lint(inline: true, configFile: ".swiftlint.yml")

// Xcode summary
func filePathForPlatform(_ platform: String) -> String {
    return "xcodebuild-\(platform).json"
}
func labelTestSummary(label: String, platform: String) throws {
    let file = filePathForPlatform(platform)
    let json = danger.utils.readFile(file)

    guard let data = json.data(using: .utf8),
        var jsonDictionary = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] else {
        throw CocoaError(.fileReadCorruptFile)
    }

    jsonDictionary["tests_summary_messages"] = (jsonDictionary["tests_summary_messages"] as? [String])?.map { label + ": " + $0 }
    try String(data: JSONSerialization.data(withJSONObject: jsonDictionary, options: []), encoding: .utf8)?.write(toFile: file, atomically: false, encoding: .utf8)
}
func summary(platform: String) {
    XCodeSummary(filePath: filePathForPlatform(platform)).report()
}

try labelTestSummary(label: "iOS", platform: "ios")

summary(platform: "ios")
