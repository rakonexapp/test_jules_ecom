# Palette's Journal 🎨

This journal tracks CRITICAL UX/accessibility learnings specific to this Flutter e-commerce app.

---

## 2026-01-31 - Initial UX Audit

**Context:** First review of the Flutter e-commerce app with splash and login screens.

**Observations:**
- App uses Material Design with custom purple theme (#7528F0)
- Login screen has phone input with country code selector
- Missing semantic labels for icon buttons (close, skip)
- No focus management or keyboard accessibility indicators
- TextField lacks proper semantic labels for screen readers
- No loading states or disabled button feedback
- No form validation feedback

**Priority Opportunities Identified:**
1. ✨ Add semantic labels to icon-only buttons (close, skip)
2. ✨ Add Semantics widget to phone input for screen reader accessibility
3. ✨ Add focus visible indicators for keyboard navigation
4. ✨ Add tooltip to "Use Email-ID" button explaining the alternative
5. ✨ Add disabled state handling to CONTINUE button with visual feedback

---
