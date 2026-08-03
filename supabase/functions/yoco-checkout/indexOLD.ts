import { serve } from "https://deno.land/std@0.168.0/http/server.ts"                                                                    
                                                                                                                                          
  serve(async (req) => {                                                                                                                  
    // Handle CORS preflight
    if (req.method === "OPTIONS") {
      return new Response("ok", {
        headers: {
          "Access-Control-Allow-Origin": "*",
          "Access-Control-Allow-Methods": "POST",
          "Access-Control-Allow-Headers": "Content-Type, Authorization",
        }
      })
    }

    if (req.method !== "POST") {                                                                                                          
      return new Response(JSON.stringify({ error: "Method not allowed" }), {                                                              
        status: 405,                                                                                                                      
        headers: { "Content-Type": "application/json" },                                                                                  
      })                                                                                                                                  
    }                                                                                                                                     
                                                                                                                                          
    let body                                                                                                                              
    try {                                                                                                                                 
      body = await req.json()                                                                                                             
    } catch {                                                                                                                             
      return new Response(JSON.stringify({ error: "Invalid JSON" }), {                                                                    
        status: 400,                                                                                                                      
        headers: { "Content-Type": "application/json" },                                                                                  
      })                                                                                                                                  
    }                                                                                                                                     
                                                                                                                                          
    const { amount_in_cents, currency, reference, description, customer_email, metadata } = body
                                                                                                                                          
    if (!amount_in_cents || isNaN(Number(amount_in_cents)) || Number(amount_in_cents) <= 0) {
      return new Response(                                                                                                                
        JSON.stringify({ error: "Invalid or missing amount (in cents)" }),
        { status: 400, headers: { "Content-Type": "application/json" } }
      )
    }                                                                                                                                     
                                                                                                                                          
    const yocoSecret = Deno.env.get("YOCO_SECRET_KEY")
    if (!yocoSecret) {
      return new Response(
        JSON.stringify({ error: "Server not configured: YOCO_SECRET_KEY missing" }),
        { status: 500, headers: { "Content-Type": "application/json" } }
      )
    }

    // Prepare Yoco request (V1 Production Spec)
    const yocoPayload = {                                                                                                                 
      amount: Math.round(Number(amount_in_cents)),
      currency: "ZAR",
      successUrl: 'https://ridesharel.com/yoco-success',
      cancelUrl: 'https://ridesharel.com/yoco-cancel',
      failureUrl: 'https://ridesharel.com/yoco-failure',
      metadata: {
        ...(metadata || {}),
        reference: (reference as string || "Payment").trim(),
        description: description || "RideShare Payment"
      }
    }
                                                                                                                                          
    try {                                                                                                                                 
      const yocoResponse = await fetch("https://online.yoco.com/v1/checkouts", {
        method: "POST",                                                                                                                   
        headers: {                                                                                                                        
          "Content-Type": "application/json",                                                                                             
          Authorization: `Bearer ${yocoSecret}`,                                                                                          
        },                                                                                                                                
        body: JSON.stringify(yocoPayload),                                                                                                
      })

      const responseText = await yocoResponse.text();

      if (!yocoResponse.ok) {
        let errorData;
        try { errorData = JSON.parse(responseText); } catch { errorData = responseText; }

        return new Response(                                                                                                              
          JSON.stringify({                                                                                                                
            error: "Yoco API Error",
            status: yocoResponse.status,
            details: errorData,
          }),                                                                                                                             
          { status: yocoResponse.status, headers: { "Content-Type": "application/json" } }                                                
        )                                                                                                                                 
      }                                                                                                                                   
                                                                                                                                          
      const yocoData = JSON.parse(responseText);
      const redirect_url = yocoData.redirectUrl || yocoData.redirect_url;

      if (!redirect_url) {
        return new Response(JSON.stringify({ error: "No redirect URL in Yoco response", details: yocoData }), {
          status: 500,
          headers: { "Content-Type": "application/json" }
        })
      }

      return new Response(                                                                                                                
        JSON.stringify({ redirect_url }),
        { status: 200, headers: { "Content-Type": "application/json" } }                                                                  
      )                                                                                                                                   
    } catch (error) {                                                                                                                     
      return new Response(                                                                                                                
        JSON.stringify({ error: "Failed to connect to Yoco", details: error.message }),                                                   
        { status: 502, headers: { "Content-Type": "application/json" } }                                                                  
      )                                                                                                                                   
    }                                                                                                                                     
  })
