-- ══════════════════════════════════════
-- CONTABILIDADE ROCHA — Migration v3
-- Novas funcionalidades:
--   • Telefone/WhatsApp do colaborador (para notificação ao responsável)
--   • Coluna whatsapp em colaboradores
-- ══════════════════════════════════════

-- Adicionar WhatsApp do colaborador (para notificação ao ser atribuído)
alter table colaboradores add column if not exists whatsapp text;

-- ── Índices úteis ──
create index if not exists idx_tickets_setor     on tickets(setor);
create index if not exists idx_tickets_responsavel on tickets(responsavel);
create index if not exists idx_agendamentos_status on agendamentos(status);

-- ══════════════════════════════════════
-- NOTAS DE USO
-- ══════════════════════════════════════
-- 1. Mapeamento setor → responsável é salvo no localStorage do browser.
--    Acesse ⚙️ Config → "Responsável por Setor" e defina cada setor.
--
-- 2. Para que a notificação ao responsável funcione, cadastre o número
--    WhatsApp dele no campo "WhatsApp" na tela de Colaboradores.
--
-- 3. Mensagem fora do horário também é configurada em ⚙️ Config.
--    Ela é enviada automaticamente quando um ticket é criado fora
--    do horário comercial definido.
--
-- 4. Ao anexar arquivo num ticket, o sistema pergunta se deseja
--    enviar via WhatsApp ao cliente antes de finalizar.
