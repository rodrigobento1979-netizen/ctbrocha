-- Adicionar coluna arquivado na tabela tickets
alter table tickets add column if not exists arquivado boolean default false;
