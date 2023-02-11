const githubPlugin = "@semantic-release/github";

module.exports = {
    "branches": ["main"],
    "tagFormat": "v${version}",
    "preset": "conventionalcommits",
    "presetConfig": {
        // https://github.com/conventional-changelog/conventional-changelog-config-spec/blob/master/versions/2.0.0/README.md
    },
    // https://github.com/semantic-release/commit-analyzer#configuration
    // "releaseRules": [],
    "parserOpts": {
    // https://github.com/conventional-changelog/conventional-changelog/tree/master/packages/conventional-commits-parser#conventionalcommitsparseroptions
        "mergePattern": "^Merge pull request #(\\d+) from (.*)$",
        "mergeCorrespondence": ["id", "source"],
        "noteKeywords": ["BREAKING CHANGE", "BREAKING CHANGES"]
    },
    "plugins": [
        "@semantic-release/commit-analyzer",
        "@semantic-release/release-notes-generator",
        githubPlugin
    ]
}
