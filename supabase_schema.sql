create table if not exists public.rescue_reports (
  id uuid default gen_random_uuid() primary key,
  folio text not null,
  created_at timestamptz default now() not null,
  photo_url text,
  location text not null,
  gps_coordinates text,
  latitude numeric,
  longitude numeric,
  health_status text not null,
  description text,
  video_url text,
  reporter_name text not null,
  reporter_phone text not null,
  privacy text default 'private' not null check (privacy in ('private', 'public')),
  status text default 'pendiente' not null check (status in ('pendiente', 'en_camino', 'atendido', 'cerrado'))
);

alter table public.rescue_reports enable row level security;

create policy "rescue_reports_insert_policy"
  on public.rescue_reports
  for insert
  to anon, authenticated
  with check (true);

create policy "rescue_reports_select_public_policy"
  on public.rescue_reports
  for select
  to anon, authenticated
  using (privacy = 'public');

create index if not exists idx_rescue_reports_created_at on public.rescue_reports(created_at desc);
create index if not exists idx_rescue_reports_status on public.rescue_reports(status);
create index if not exists idx_rescue_reports_privacy on public.rescue_reports(privacy);
