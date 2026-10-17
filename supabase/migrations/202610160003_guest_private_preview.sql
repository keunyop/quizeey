begin;
create function public.quizeey_forum_mine(p_capability_hash text) returns jsonb
language sql stable security definer set search_path='' as $$
  select coalesce(jsonb_agg(to_jsonb(owned)), '[]'::jsonb) from (
    select p.id,p.topic_id,p.parent_id,p.display_name,p.body,p.visibility,p.created_at,p.updated_at,
      t.exam_id,t.question_id,t.locale,t.title,
      revision.id as pending_revision_id,revision.body as pending_body
    from quizeey_private.post_owners o
    join quizeey_private.guest_capabilities c using(capability_hash)
    join public.quizeey_posts p on p.id=o.post_id
    join public.quizeey_topics t on t.id=p.topic_id
    left join lateral (select r.id,r.body from quizeey_private.post_revisions r where r.post_id=p.id and r.visibility='pending' order by r.created_at desc,r.id limit 1) revision on true
    where c.capability_hash=p_capability_hash and c.expires_at>now() and p.visibility in ('pending','approved')
    order by p.created_at desc,p.id limit 20
  ) owned;
$$;
revoke all on function public.quizeey_forum_mine(text) from public,anon,authenticated;
grant execute on function public.quizeey_forum_mine(text) to service_role;
commit;
