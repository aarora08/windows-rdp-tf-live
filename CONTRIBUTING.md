# Contribution guide

## Commit Message Format
Titles should be of the form:
```
<type>(<scope>): <subject>

```
The #header is mandatory and the #scope of the header is optional. The #scope should be the module being modified, if applicable.
The #body should contain the motivation. That is where you describe the context of the change.

### Type
Must be one of the following:

- `feat`: A new feature
- `fix`: A bug fix
- `docs`: Documentation only changes
- `style`: Changes that do not affect the meaning of the code (white-space, formatting, missing semi-colons, etc)
- `refactor`: A code change that neither fixes a bug nor adds a feature
- `perf`: A code change that improves performance
- `test`: Adding missing or correcting existing tests
- `chore`: Changes to the build process or auxiliary tools and libraries such as documentation generation

## Releases
We use `semantic-release` to release new versions automatically.

- Commits of type `fix` will bump the patch version: `0.0.1`
- Commits of type `feat` will bump the minor version: `0.1.0`
- Commits with `BREAKING CHANGE{s}` in body or footer will bump the major version: `1.0.0`

All other commit types will trigger no new release.