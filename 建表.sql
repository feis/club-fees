-- ============================================
-- 羽球社共用帳本 — ledger 表
-- 專案: club-ledger (rycbqfodgauneccmcprr)
-- ============================================

CREATE TABLE ledger (
  id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  court_fee BIGINT NOT NULL,
  shuttle_fee BIGINT NOT NULL,
  total_fee BIGINT NOT NULL,
  paying_count INTEGER NOT NULL,
  free_count INTEGER NOT NULL,
  members JSONB NOT NULL
);

COMMENT ON TABLE ledger IS '羽球社分帳紀錄';
COMMENT ON COLUMN ledger.court_fee IS '場地費總額（元）';
COMMENT ON COLUMN ledger.shuttle_fee IS '羽毛球費總額（元）';
COMMENT ON COLUMN ledger.total_fee IS '本次活動總費用（元）';
COMMENT ON COLUMN ledger.paying_count IS '付費人數';
COMMENT ON COLUMN ledger.free_count IS '新人免費人數';
COMMENT ON COLUMN ledger.members IS '每人明細，格式: [{name, isNew, amount}]';

-- 依建立時間倒序排列，方便查詢最新紀錄
CREATE INDEX idx_ledger_created_at ON ledger(created_at DESC);

-- ============================================
-- Row Level Security (RLS)
-- ============================================

ALTER TABLE "public"."ledger" ENABLE ROW LEVEL SECURITY;

-- 完全拒絕 anon（未登入）存取
DROP POLICY IF EXISTS "Allow anonymous access" ON "public"."ledger";
CREATE POLICY "Deny anonymous" ON "public"."ledger"
  FOR ALL
  TO anon
  USING (false)
  WITH CHECK (false);

-- 已登入社員：可讀、寫、更新、刪
CREATE POLICY "Authenticated members can insert" ON "public"."ledger"
  FOR INSERT
  TO authenticated
  WITH CHECK (true);

CREATE POLICY "Authenticated members can select" ON "public"."ledger"
  FOR SELECT
  TO authenticated
  USING (true);

CREATE POLICY "Authenticated members can update" ON "public"."ledger"
  FOR UPDATE
  TO authenticated
  USING (true)
  WITH CHECK (true);

CREATE POLICY "Authenticated members can delete" ON "public"."ledger"
  FOR DELETE
  TO authenticated
  USING (true);
