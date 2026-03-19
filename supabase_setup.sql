-- ============================================================
--  FDV — Sistema de Reservas de Espaços
--  Execute este SQL no Supabase:
--  Painel → SQL Editor → New Query → Cole e clique em Run
-- ============================================================

-- 1. Cria a tabela de reservas
CREATE TABLE IF NOT EXISTS reservas (
  id             BIGSERIAL PRIMARY KEY,          -- ID automático
  created_at     TIMESTAMPTZ DEFAULT NOW(),       -- Data/hora de criação (automático)
  tipo           TEXT NOT NULL,                  -- 'sala' | 'auditorio' | 'lab'
  sala           TEXT NOT NULL,                  -- Nome da sala/espaço
  data           DATE NOT NULL,                  -- Data da reserva (YYYY-MM-DD)
  horario_inicio TEXT NOT NULL,                  -- Ex: '9:10 - 9:30'
  horario_fim    TEXT,                           -- Ex: '11:10 - 12:00' (pode ser nulo)
  horario        TEXT NOT NULL,                  -- Texto completo do horário
  favorecido     TEXT,                           -- Responsável / favorecido
  evento         TEXT,                           -- Curso / descrição do evento
  motivo         TEXT,                           -- Motivo (usado no lab)
  observacoes    TEXT                            -- Observações adicionais
);

-- 2. Habilita Row Level Security (RLS) — boa prática de segurança
ALTER TABLE reservas ENABLE ROW LEVEL SECURITY;

-- 3. Política: qualquer pessoa pode LER as reservas (acesso público)
CREATE POLICY "Leitura pública"
  ON reservas FOR SELECT
  USING (true);

-- 4. Política: qualquer pessoa pode INSERIR reservas (acesso público)
CREATE POLICY "Inserção pública"
  ON reservas FOR INSERT
  WITH CHECK (true);

-- 5. Política: qualquer pessoa pode DELETAR reservas (acesso público)
--    ⚠️  Se quiser restringir deleção apenas a admins,
--        remova esta política e configure autenticação.
CREATE POLICY "Deleção pública"
  ON reservas FOR DELETE
  USING (true);

-- 6. Índices para melhorar performance nas consultas mais comuns
CREATE INDEX idx_reservas_data       ON reservas (data);
CREATE INDEX idx_reservas_sala_data  ON reservas (sala, data);
CREATE INDEX idx_reservas_tipo       ON reservas (tipo);

-- ============================================================
--  ✅ Pronto! Após executar, volte à página HTML e configure:
--     SUPABASE_URL    → Project Settings → API → Project URL
--     SUPABASE_ANON_KEY → Project Settings → API → anon public
-- ============================================================
