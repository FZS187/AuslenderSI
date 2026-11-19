create schema if not exists extensions;
create extension if not exists vector with schema extensions;

create table public.uporabniki (
    id uuid primary key default auth.uid() references auth.users (id) on delete cascade,
    drzavljanstvo_tip text not null check (drzavljanstvo_tip in ('EU', 'NON_EU')),
    jezik text not null default 'sl' check (jezik in ('sl', 'en', 'sr')),
    push_token text,
    ustvarjeno timestamptz not null default now()
);

create table public.postopki (
    id uuid primary key default gen_random_uuid(),
    koda text not null unique,
    naziv jsonb not null,
    opis jsonb not null,
    ikona text,
    vrstni_red integer not null check (vrstni_red > 0)
);

create table public.koraki (
    id uuid primary key default gen_random_uuid(),
    postopek_id uuid not null references public.postopki (id) on delete cascade,
    vrstni_red integer not null check (vrstni_red > 0),
    naziv jsonb not null,
    opis jsonb not null,
    ciljna_skupina text not null default 'ALL' check (ciljna_skupina in ('ALL', 'EU', 'NON_EU')),
    unique (postopek_id, id)
);

create table public.dokumenti (
    id uuid primary key default gen_random_uuid(),
    postopek_id uuid not null references public.postopki (id) on delete cascade,
    korak_id uuid,
    naziv jsonb not null,
    kratek_opis jsonb not null,
    podroben_opis jsonb not null,
    pristojna_ustanova jsonb not null,
    obrazec_url text,
    ciljna_skupina text not null default 'ALL' check (ciljna_skupina in ('ALL', 'EU', 'NON_EU')),
    unique (postopek_id, id),
    foreign key (postopek_id, korak_id)
        references public.koraki (postopek_id, id) on delete set null (korak_id)
);

create table public.uporabnik_koraki (
    id uuid primary key default gen_random_uuid(),
    uporabnik_id uuid not null default auth.uid() references public.uporabniki (id) on delete cascade,
    korak_id uuid not null references public.koraki (id) on delete cascade,
    opravljeno boolean not null default false,
    opravljeno_ob timestamptz,
    unique (uporabnik_id, korak_id)
);

create table public.uporabnik_dokumenti (
    id uuid primary key default gen_random_uuid(),
    uporabnik_id uuid not null default auth.uid() references public.uporabniki (id) on delete cascade,
    dokument_id uuid not null references public.dokumenti (id) on delete cascade,
    pripravljeno boolean not null default false,
    pripravljeno_ob timestamptz,
    unique (uporabnik_id, dokument_id)
);

create table public.opomniki (
    id uuid primary key default gen_random_uuid(),
    uporabnik_id uuid not null default auth.uid() references public.uporabniki (id) on delete cascade,
    postopek_id uuid not null references public.postopki (id) on delete cascade,
    korak_id uuid,
    dokument_id uuid,
    naslov text not null,
    opomba text,
    rok_ob timestamptz not null,
    kanal text not null check (kanal in ('EMAIL', 'PUSH', 'BOTH')),
    poslano boolean not null default false,
    foreign key (postopek_id, korak_id)
        references public.koraki (postopek_id, id) on delete cascade,
    foreign key (postopek_id, dokument_id)
        references public.dokumenti (postopek_id, id) on delete cascade
);

create table public.baza_znanja_rag (
    id uuid primary key default gen_random_uuid(),
    postopek_id uuid references public.postopki (id) on delete set null,
    naslov text not null,
    vsebina text not null,
    vir_url text not null,
    jezik text not null check (jezik in ('sl', 'en', 'sr')),
    embedding extensions.vector(768),
    posodobljeno timestamptz not null default now()
);

create index koraki_postopek_vrstni_red_idx on public.koraki (postopek_id, vrstni_red);
create index dokumenti_postopek_korak_idx on public.dokumenti (postopek_id, korak_id);
create index uporabnik_koraki_korak_idx on public.uporabnik_koraki (korak_id);
create index uporabnik_dokumenti_dokument_idx on public.uporabnik_dokumenti (dokument_id);
create index opomniki_uporabnik_idx on public.opomniki (uporabnik_id);
create index opomniki_postopek_korak_idx on public.opomniki (postopek_id, korak_id);
create index opomniki_postopek_dokument_idx on public.opomniki (postopek_id, dokument_id);
create index opomniki_cakajoci_rok_idx on public.opomniki (rok_ob) where not poslano;
create index baza_znanja_rag_postopek_idx on public.baza_znanja_rag (postopek_id);

alter table public.uporabniki enable row level security;
alter table public.postopki enable row level security;
alter table public.koraki enable row level security;
alter table public.dokumenti enable row level security;
alter table public.uporabnik_koraki enable row level security;
alter table public.uporabnik_dokumenti enable row level security;
alter table public.opomniki enable row level security;
alter table public.baza_znanja_rag enable row level security;

revoke all on table public.uporabniki, public.postopki, public.koraki, public.dokumenti,
    public.uporabnik_koraki, public.uporabnik_dokumenti, public.opomniki, public.baza_znanja_rag
    from public, anon, authenticated;

grant all on table public.uporabniki, public.postopki, public.koraki, public.dokumenti,
    public.uporabnik_koraki, public.uporabnik_dokumenti, public.opomniki, public.baza_znanja_rag
    to service_role;

grant select on table public.postopki, public.koraki, public.dokumenti to anon, authenticated;
grant select on table public.uporabniki to authenticated;
grant insert (id, drzavljanstvo_tip, jezik, push_token),
    update (drzavljanstvo_tip, jezik, push_token) on table public.uporabniki to authenticated;
grant select, insert, update, delete on table public.uporabnik_koraki, public.uporabnik_dokumenti
    to authenticated;
grant select, delete on table public.opomniki to authenticated;
grant insert (uporabnik_id, postopek_id, korak_id, dokument_id, naslov, opomba, rok_ob, kanal),
    update (korak_id, dokument_id, naslov, opomba, rok_ob, kanal)
    on table public.opomniki to authenticated;

create policy postopki_javno_branje on public.postopki
    for select to anon, authenticated using (true);
create policy koraki_javno_branje on public.koraki
    for select to anon, authenticated using (true);
create policy dokumenti_javno_branje on public.dokumenti
    for select to anon, authenticated using (true);

create policy uporabniki_lastni_profil on public.uporabniki
    for all to authenticated using ((select auth.uid()) = id)
    with check ((select auth.uid()) = id);

create policy koraki_lastni_napredek on public.uporabnik_koraki
    for all to authenticated using ((select auth.uid()) = uporabnik_id)
    with check ((select auth.uid()) = uporabnik_id);

create policy dokumenti_lastni_napredek on public.uporabnik_dokumenti
    for all to authenticated using ((select auth.uid()) = uporabnik_id)
    with check ((select auth.uid()) = uporabnik_id);

create policy uporabniki_lastni_opomniki on public.opomniki
    for all to authenticated using ((select auth.uid()) = uporabnik_id)
    with check ((select auth.uid()) = uporabnik_id);
