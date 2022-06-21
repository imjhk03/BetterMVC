import Danger

let danger = Danger()

// Pull out the edited files
let editedFiles = danger.git.modifiedFiles + danger.git.createdFiles
let hasChangelogEntry = danger.git.modifiedFiles.contains("CHANGELOG.md")

// Example from danger
// Let people bail from the CHANGELOG check
let hasSkipChangelog = danger.github.pullRequest.body.contains("#no_changelog")

// Request for a CHANGELOG entry with each app change
if editedFiles.count > 0 && !hasChangelogEntry && !hasSkipChangelog {
    fail("Please add a CHANGELOG entry for these changes. If you would like to skip this check, add `#no_changelog` to the PR body and re-run CI.")
}
