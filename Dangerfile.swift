import Danger
import DangerSwiftLint

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

SwiftLint.lint()

// Instead of making a markdown table in the main message
// sprinkle those comments inline, this can be a bit noisy
// but it definitely feels magical.
SwiftLint.lint(inline: true)

// Have different runs of SwiftLint against different sub-folders
SwiftLint.lint(directory: "Sources", configFile: ".swiftlint.yml")
SwiftLint.lint(directory: "Tests", configFile: "Tests/HarveyTests/.swiftlint.yml")

// The equivalent to running `swiftlint` in the root of the folder
SwiftLint.lint(lintAllFiles: true)

// Use a different path for SwiftLint
SwiftLint.lint(swiftlintPath: "Pods/SwiftLint/swiftlint")
