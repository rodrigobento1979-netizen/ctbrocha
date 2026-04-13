-- ══════════════════════════════════════
-- CONTABILIDADE ROCHA — Schema Supabase
-- ══════════════════════════════════════

-- COLABORADORES
create table if not exists colaboradores (
  id uuid primary key default gen_random_uuid(),
  nome text not null,
  cargo text,
  login text unique not null,
  senha text not null,
  created_at timestamptz default now()
);

-- TICKETS
create table if not exists tickets (
  id uuid primary key default gen_random_uuid(),
  cliente text not null,
  whatsapp text,
  assunto text not null,
  setor text not null,
  responsavel text,
  descricao text,
  status text not null default 'novo',
  concluido_em timestamptz,
  created_at timestamptz default now(),
  updated_at timestamptz default now()
);

-- ANOTAÇÕES
create table if not exists anotacoes (
  id uuid primary key default gen_random_uuid(),
  ticket_id uuid references tickets(id) on delete cascade,
  autor text not null,
  texto text not null,
  created_at timestamptz default now()
);

-- ANEXOS
create table if not exists anexos (
  id uuid primary key default gen_random_uuid(),
  ticket_id uuid references tickets(id) on delete cascade,
  nome text not null,
  tamanho integer,
  storage_path text,
  created_at timestamptz default now()
);

-- ══════════ RLS (Row Level Security) ══════════
alter table colaboradores enable row level security;
alter table tickets enable row level security;
alter table anotacoes enable row level security;
alter table anexos enable row level security;

-- Permitir tudo para anon (autenticação é feita pelo próprio painel)
create policy "allow_all_colaboradores" on colaboradores for all to anon using (true) with check (true);
create policy "allow_all_tickets" on tickets for all to anon using (true) with check (true);
create policy "allow_all_anotacoes" on anotacoes for all to anon using (true) with check (true);
create policy "allow_all_anexos" on anexos for all to anon using (true) with check (true);

-- ══════════ STORAGE ══════════
insert into storage.buckets (id, name, public)
values ('anexos-tickets', 'anexos-tickets', false)
on conflict do nothing;

create policy "allow_all_storage" on storage.objects for all to anon using (bucket_id = 'anexos-tickets') with check (bucket_id = 'anexos-tickets');

-- ══════════ COLABORADORES INICIAIS ══════════
insert into colaboradores (nome, cargo, login, senha) values
  ('Marcia',    'Gestora',               'marcia',    'marcia123'),
  ('Daniel',    'Analista Fiscal',        'daniel',    'daniel123'),
  ('Katia',     'Contábil',              'katia',     'katia123'),
  ('Conceição', 'Departamento Pessoal',  'conceicao', 'conceicao123'),
  ('Leonardo',  'Legalização',           'leonardo',  'leonardo123')
on conflict (login) do nothing;
