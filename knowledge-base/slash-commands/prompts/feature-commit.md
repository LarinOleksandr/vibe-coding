# /feature-commit

---

title: feature-commit

---

## Goal

Save the current working state into Git as a single feature commit.

## Actions (agent must execute)

1. Check if there are any changes (tracked or untracked).
2. If there are changes:
   - Update the canonical project docs (context/plan/insights) with the minimum edits required to keep them accurate.
   - Stage everything.
   - Generate a commit message that starts with `feat:` and summarizes the change.
   - Create the commit.
3. In all cases (commit succeeds, fails, or nothing to commit), show the full feature list and statuses from `DOC_PRODUCT_DEVELOPMENT_ROADMAP` (Feature Development section), including subfeatures, in this format:
   - `1. [In Progress] Project setup and deployment`
   - `1.1 [Not Started] Rename repo folder to ideabrowser-clone`
4. Ask what feature should be developed next and require the user to enter a feature number (top-level or subfeature).
5. If the selected feature is already `In Progress` or `Completed`, inform the user there may be duplication and ask them to choose another feature number.
6. After the user enters a valid number, return a concrete thread name suggestion built from the selected item using `KB_THREADS` naming rules.

## Commands

git status --porcelain
git add .
git commit -m "feat: <AUTO_SUMMARY_OF_COMPLETED_WORK>"

## Rules

- Do not ask the human anything before the commit step.
- Do not create tags.
- If `git commit` fails because there is nothing to commit, output `nothing to commit` and continue to step 3.
