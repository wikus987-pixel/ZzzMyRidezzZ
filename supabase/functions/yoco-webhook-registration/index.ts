import { createClient } from 'https://esm.sh/@supabase/supabase-js@2'

const json = (body: any, status = 200) => new Response(JSON.stringify(body), {
  status,
  headers: { "Content-Type": "application/json" }
});

Deno.serve(async (req) => {
  if (req.method !== "POST") return json({ error: "Method not allowed" }, 405);

  try {
    const event = await req.json();
    console.log("INCOMING WEBHOOK:", JSON.stringify(event));

    // Get email from Yoco's message
    const email = event?.payload?.customer?.email || event?.payload?.metadata?.customer_email;

    if (!email) return json({ ok: false, error: "No email found" }, 400);

    const eventName = (event?.event || "").toLowerCase();
    const status = (event?.payload?.status || "").toLowerCase();
    const isSuccess = eventName.includes("succeeded") || status.includes("succeeded");

    // Initialize Supabase correctly
    const supabase = createClient(
      Deno.env.get('SUPABASE_URL') ?? '',
      Deno.env.get('SERVICE_ROLE_KEY') ?? Deno.env.get('SUPABASE_SERVICE_ROLE_KEY') ?? ''
    )

    const cleanEmail = email.trim().toLowerCase();

    if (isSuccess) {
      console.log(`Verifying: ${cleanEmail}`);
      const { error } = await supabase
        .from('verified_payments')
        .update({ verified: true, status: 'yoco_verified' })
        .ilike('Email', cleanEmail);

      if (error) throw error;
      return json({ ok: true, verified: true });
    } else {
      console.log(`Deleting failed payment: ${cleanEmail}`);
      const { error } = await supabase
        .from('verified_payments')
        .delete()
        .ilike('Email', cleanEmail);

      if (error) throw error;
      return json({ ok: true, deleted: true });
    }
  } catch (err) {
    console.error("WEBHOOK ERROR:", err.message);
    return json({ ok: false, error: err.message }, 500);
  }
});
