-- Adicionar colunas competencia e documento na tabela agendamentos
alter table agendamentos add column if not exists competencia text; -- formato YYYY-MM (ex: 2025-03)
alter table agendamentos add column if not exists documento  text; -- tipo de documento livre
