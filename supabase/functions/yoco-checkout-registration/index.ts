import { serve } from "https://deno.land/std@0.168.0/http/server.ts"

serve(async (req) => {
  // Handle CORS
  if (req.method === "OPTIONS") {
    return new Response("ok", {
      headers: {
        "Access-Control-Allow-Origin": "*",
        "Access-Control-Allow-Methods": "POST",
        "Access-Control-Allow-Headers": "Content-Type, Authorization, X-App-Id",
      }
    })
  }

  if (req.method !== "POST") {
    return new Response(JSON.stringify({ error: "Method not allowed" }), {
      status: 405,
      headers: { "Content-Type": "application/json" },
    })
  }

  try {
    const body = await req.json();
    const { amount_in_cents, customer_email, reference } = body;

    const yocoSecret = Deno.env.get("YOCO_SECRET_KEY");
    if (!yocoSecret) {
      return new Response(JSON.stringify({ error: "YOCO_SECRET_KEY missing" }), { status: 500 });
    }

    const yocoPayload = {
      amount: Math.round(Number(amount_in_cents)),
      currency: "ZAR",
      successUrl: 'https://ridesharel.com/yoco-success',
      cancelUrl: 'https://ridesharel.com/yoco-cancel',
      failureUrl: 'https://ridesharel.com/yoco-failure',
      metadata: {
        reference: reference || "Reg",
        customer_email: customer_email
      }
    }

    const yocoResponse = await fetch("https://online.yoco.com/v1/checkouts", {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
        "Authorization": `Bearer ${yocoSecret}`,
        "X-App-Id": "3e7ef11f-d23c-4259-be49-3fece6f6c461"
      },
      body: JSON.stringify(yocoPayload),
    });

    const responseText = await yocoResponse.text();
    if (!yocoResponse.ok) {
      return new Response(responseText, { status: yocoResponse.status });
    }

    const yocoData = JSON.parse(responseText);
    const redirect_url = yocoData.redirectUrl || yocoData.redirect_url;

    return new Response(JSON.stringify({ redirect_url }), {
      status: 200,
      headers: { "Content-Type": "application/json" },
    });
  } catch (error) {
    return new Response(JSON.stringify({ error: error.message }), { status: 500 });
  }
})
