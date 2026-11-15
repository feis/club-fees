# AGENTS.md — 羽球社分帳專案規範

## 開發流程

每次功能修改或新增完成後，**必須自行驗收**才能提交。

### 驗收清單

1. **瀏覽器測試**：用 browser 工具打開部署網址，確認頁面正常載入、無 console error
2. **功能測試**：實際操作每個互動元素（登入、分帳計算、儲存紀錄、歷史紀錄、刪除等）
3. **部署檢查**：確認 GitHub Pages 已更新並可正常存取
4. **Commit & Push**：驗收通過後才 commit 和 push

### 不允許的行為

- 不要只改 code 就 commit，沒有實際測試過
- 不要假設功能正常，必須用瀏覽器工具親自驗證
- Console error 出現時必須先修復再繼續

## 專案技術摘要

- **前端**：單一 `index.html`，內含 HTML/CSS/JS
- **後端**：Supabase (club-ledger, ref: rycbqfodgauneccmcprr)
- **部署**：GitHub Pages → https://feis.github.io/club-fees/
- **資料庫**：`ledger` 表（RLS enabled，authenticated 可 CRUD）
- **登入**：Email + Password，Supabase Auth
