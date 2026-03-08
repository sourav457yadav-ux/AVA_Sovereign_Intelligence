# To‑Do List (Local Storage)

Simple, dependency‑free to‑do app that stores tasks in your browser's localStorage.

Features
- Add tasks
- Edit tasks (double-click or press Enter on a task)
- Mark complete / incomplete
- Delete tasks
- Filter: All / Active / Completed
- Clear completed tasks
- Persists data using localStorage (key: `todo-items-v1`)

How to use
1. Save the files into a single folder maintaining the structure:
   - index.html
   - css/style.css
   - js/app.js
2. Open `index.html` in your browser (no server required).
3. Type a task in the input and press Add or Enter to save.
4. Double-click a task (or click the ✏️ icon) to edit. Press Enter to save or Esc to cancel.
5. Use filters to view active/completed tasks and "Clear completed" to remove finished items.

Notes for developers
- Local storage key: `todo-items-v1`
- The app is intentionally small and readable. You can extend it (drag/drop reorder, due dates, sync with backend) by modifying `js/app.js`.

License: MIT (use/modify freely).