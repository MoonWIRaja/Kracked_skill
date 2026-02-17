# Jules Planning - Kracked_Skills Fixes

## Problem Analysis

After a detailed review of the `Kracked_Skills` system, specifically the installation and management scripts (`install.sh`, `uninstall.sh`, `update.sh`, `validate.sh`), several issues and inconsistencies were identified:

1.  **File Placement Inconsistency**: `install.sh` places critical AI tool configuration files (`CLAUDE.md`, `.cursorrules`, `.clinerules`, `.kilocode`, `.roo`) into subdirectories (e.g., `.claude/CLAUDE.md`, `.cursor/.cursorrules`). However, these tools typically expect these files to be in the **root** of the project to function correctly. This likely breaks the integration for users.
2.  **Validation Script Mismatch**: `validate.sh` checks for these configuration files in the root directory, causing validation failures even after a "successful" installation. It also checks for `status.md` in the root, while `install.sh` creates it in `.kracked/KD_output/status/status.md`.
3.  **Uninstallation Logic**: `uninstall.sh` removes legacy files from the root but doesn't fully account for the new directory structure created by `install.sh`.
4.  **Typo in Documentation**: `Planing.md` is a typo and should be `PLANNING.md`.
5.  **Broken Links/Paths**: Some download paths in `install.sh` need to be verified against the repo structure (although checks suggest they are mostly correct).

## Proposed Plan

To address these issues and ensure a robust, "perfect" system, I propose the following changes:

1.  **Fix `install.sh`**:
    *   Modify the `setup_*` functions to place `CLAUDE.md`, `.cursorrules`, `.clinerules`, `.kilocode`, and `.roo` in the **project root**.
    *   Keep `.antigravity/SKILL.md` as is (seems correct for that tool).
    *   Ensure all necessary directories are created.
    *   Ensure `status.md` is created in the correct location (`.kracked/KD_output/status/status.md`) and referenced correctly in the templates.

2.  **Fix `validate.sh`**:
    *   Update paths to check for configuration files in the root (matching the fixed `install.sh`).
    *   Update the check for `status.md` to look in `.kracked/KD_output/status/status.md`.
    *   Ensure all directory checks align with `install.sh`.

3.  **Fix `uninstall.sh`**:
    *   Ensure it removes the configuration files from the root.
    *   Ensure it removes the `.kracked` directory and any other created artifacts.

4.  **Rename `Planing.md`**:
    *   Rename `Planing.md` to `PLANNING.md`.

5.  **Documentation Updates**:
    *   Update `README.md` if it references `Planing.md`.

## Execution Steps

1.  Rename `Planing.md` to `PLANNING.md`.
2.  Modify `install.sh` to place adapter files in root.
3.  Modify `validate.sh` to check correct paths.
4.  Modify `uninstall.sh` to clean up correctly.
5.  Verify changes by running validation checks (simulated).

## Verification

*   Run `validate.sh` after simulated installation to ensure it passes.
*   Check file locations to ensure they match standard tool expectations.
