# /feature-start

---

title: feature-start

---

## Goal

Provide context, insights, and the current plan before feature implementation.

## Actions (agent must execute)

1. In the new thread, read these files in order:
   - `DOC_PROJECT_CONTEXT`
   - `DOC_PROJECT_INSIGHTS`
   - `DOC_PRODUCT_DEVELOPMENT_ROADMAP`
2. Ask: "Starting feature: [feature name]. Proceed?"

## Notes

- If the selected feature has subfeatures, include them in the new thread message after the feature name.
- If a feature is already marked `Completed`, inform the user and ask how to proceed.
- If `DOC_PRODUCT_DEVELOPMENT_ROADMAP` is missing or malformed, suggest running `/project-setup`, then stop.
