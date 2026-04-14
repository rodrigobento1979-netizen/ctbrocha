-- ══════════════════════════════════════
-- CONTABILIDADE ROCHA — Migration
-- Novas tabelas: clientes e agendamentos
-- ══════════════════════════════════════

-- CLIENTES
create table if not exists clientes (
  id uuid primary key default gen_random_uuid(),
  cnpj text unique,
  nome text not null,
  contato text,
  telefone text not null,
  created_at timestamptz default now(),
  updated_at timestamptz default now()
);

-- AGENDAMENTOS DE COBRANÇA
create table if not exists agendamentos (
  id uuid primary key default gen_random_uuid(),
  cliente_id uuid references clientes(id) on delete cascade,
  telefone text,                          -- telefone de envio (pode sobrescrever o do cliente)
  tipo text not null default 'avulso',    -- 'avulso' | 'recorrente'
  data_envio date,                        -- apenas para tipo 'avulso'
  dia_mes integer,                        -- apenas para tipo 'recorrente' (1-28)
  hora text not null default '09:00',     -- HH:MM
  mensagem text not null,
  status text not null default 'pendente', -- 'pendente' | 'enviado'
  ultimo_envio timestamptz,
  created_at timestamptz default now(),
  updated_at timestamptz default now()
);

-- RLS
alter table clientes enable row level security;
alter table agendamentos enable row level security;

create policy "allow_all_clientes" on clientes for all to anon using (true) with check (true);
create policy "allow_all_agendamentos" on agendamentos for all to anon using (true) with check (true);
