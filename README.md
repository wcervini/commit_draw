# Commit Draw

A Neovim plugin for managing commit drafts and automated changelog generation using Conventional Commits.

## Features

- **Interactive Commit Drafts**: Add commits with interactive prompts following Conventional Commits format
- **Automatic Versioning**: Semantic versioning based on commit types (feat → minor, fix → patch, breaking → major)
- **Changelog Generation**: Automated CHANGELOG.md creation from commit drafts
- **Git Integration**: Direct Git commit execution using draft content
- **Visual Editing**: Open and edit commit draft file directly in Neovim

## Installation

### Manual Installation

```lua
-- Add to your Neovim config
vim.opt.rtp:append("~/.config/nvim/path/to/commit-draw")
require("commit_draw").setup()
```

### Using Packer

```lua
use {
    "wcervini/commit_draw",
    config = function()
        require("commit_draw").setup()
    end
}
```

### Using Lazy.nvim

```lua
return {
    "wcervini/commit_draw",
    config = function()
        require("commit_draw").setup()
    end
}
```

## Configuration

Default configuration:

```lua
require("commit_draw").setup({
    commit_draw_path = ".git/COMMIT_DRAFT",   -- Path for commit draft file
    changelog_path = "CHANGELOG.md",          -- Path for changelog file
    version_file = "VERSION",                 -- Path for version file
    auto_clear = true,                         -- Auto-clear draft after applying
})
```

## Usage

### Step-by-Step Workflow

1. **Add commits to draft**:

   ```vim
   :CommitDrawAdd
   ```

   Interactive prompts will guide you through:
   - Commit type (feat, fix, chore, docs, style, refactor, perf, test, build, ci, revert)
   - Optional scope
   - Description
   - Optional notes

2. **Review draft**:

   ```vim
   :CommitDrawOpen
   ```

   Opens the draft file for manual editing. Example draft content:

   ```
   feat(api): add new authentication endpoint
   fix(auth): resolve token expiration issue !
   chore: update dependencies
   ```

3. **Generate release**:

   ```vim
   :CommitDrawApply
   ```

   This will:
   - Parse the commit draft
   - Calculate new semantic version
   - Update CHANGELOG.md
   - Update VERSION file
   - Clear the draft (if auto_clear is true)

4. **Commit to Git**:

   ```vim
   :CommitDrawCommit
   ```

   Performs actual Git commit using the draft content.

### Complete Workflow Example

```vim
" Add multiple commits to draft
:CommitDrawAdd
" Select: feat, api, "add user management endpoints"
:CommitDrawAdd
" Select: fix, auth, "fix login timeout issue"

" Review and edit draft
:CommitDrawOpen

" Generate release (creates CHANGELOG and updates VERSION)
:CommitDrawApply

" Commit changes to Git
:CommitDrawCommit
```

## File Structure

The plugin creates and manages these files:

- **`.git/COMMIT_DRAFT`**: Contains commit entries in Conventional Commits format
- **`CHANGELOG.md`**: Generated changelog with version history
- **`VERSION`**: Current semantic version (e.g., "1.2.3")

## Command Reference

| Command            | Description                                   |
| ------------------ | --------------------------------------------- |
| `CommitDrawAdd`    | Interactive commit addition to draft          |
| `CommitDrawApply`  | Apply draft to generate release and changelog |
| `CommitDrawCommit` | Perform Git commit using draft content        |
| `CommitDrawOpen`   | Open commit draft file for editing            |

## Conventional Commits Support

Supported commit types:

- `feat`: New feature (minor version bump)
- `fix`: Bug fix (patch version bump)
- `chore`: Maintenance tasks
- `docs`: Documentation changes
- `style`: Code style changes
- `refactor`: Code refactoring
- `perf`: Performance improvements
- `test`: Test-related changes
- `build`: Build system changes
- `ci`: CI/CD changes
- `revert`: Revert previous commit

Breaking changes are indicated with `!` after the type.

## Semantic Versioning

The plugin follows semantic versioning rules:

- **Major**: Breaking changes (commits with `!`)
- **Minor**: New features (`feat` type commits)
- **Patch**: Bug fixes (`fix` type commits)

## Example Output

### Generated CHANGELOG.md

```markdown
## 1.2.3

- feat(api): add new authentication endpoint
- fix(auth): resolve token expiration issue
- chore: update dependencies
```

### Generated VERSION file

```
1.2.3
```

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Submit a pull request

## License

MIT License - see LICENSE.md for details.

