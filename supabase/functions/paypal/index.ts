import { serve } from "https://deno.land/std@0.168.0/http/server.ts";
import { corsHeaders } from "./cors.ts";

const PAYPAL_CLIENT_ID = Deno.env.get("PAYPAL_CLIENT_ID") ?? "";
const PAYPAL_SECRET = Deno.env.get("PAYPAL_SECRET") ?? "";
const PAYPAL_LIVE = (Deno.env.get("PAYPAL_LIVE") ?? "false") === "true";

const BASE_URL = PAYPAL_LIVE
  ? "https://api-m.paypal.com"
  : "https://api-m.sandbox.paypal.com";

async function getAccessToken(): Promise<string> {
  if (!PAYPAL_CLIENT_ID || !PAYPAL_SECRET) {
    throw new Error("Missing PayPal credentials: check PAYPAL_CLIENT_ID and PAYPAL_SECRET in secrets");
  }
  const credentials = btoa(`${PAYPAL_CLIENT_ID}:${PAYPAL_SECRET}`);
  const res = await fetch(`${BASE_URL}/v1/oauth2/token`, {
    method: "POST",
    headers: {
      Authorization: `Basic ${credentials}`,
      "Content-Type": "application/x-www-form-urlencoded",
    },
    body: "grant_type=client_credentials",
  });

  if (!res.ok) {
    const errorText = await res.text();
    throw new Error(`Failed to get PayPal access token: ${res.status} ${errorText}`);
  }

  const data = await res.json();
  if (!data.access_token) {
    throw new Error("No access_token in PayPal response");
  }
  return data.access_token;
}

async function createOrder(amount: number, description: string, email: string) {
  const token = await getAccessToken();
  const res = await fetch(`${BASE_URL}/v2/checkout/orders`, {
    method: "POST",
    headers: {
      Authorization: `Bearer ${token}`,
      "Content-Type": "application/json",
      Accept: "application/json",
    },
    body: JSON.stringify({
      intent: "CAPTURE",
      purchase_units: [
        {
          amount: { currency_code: "USD", value: amount.toFixed(2) },
          description,
          custom_id: email,
        },
      ],
      application_context: {
        brand_name: "RideShare",
        landing_page: "BILLING",
        shipping_preference: "NO_SHIPPING",
        user_action: "PAY_NOW",
        return_url: "ridesharel://paypalpay",
        cancel_url: "ridesharel://paypalpay?cancel=1",
      },
    }),
  });

  if (!res.ok) {
    const errorText = await res.text();
    let errorMsg = `PayPal order creation failed: ${res.status}`;
    try {
      const errorJson = JSON.parse(errorText);
      if (errorJson?.error?.message) {
        errorMsg += `: ${errorJson.error.message}`;
      } else if (errorJson?.message) {
        errorMsg += `: ${errorJson.error}`;
      } else {
        errorMsg += `: ${errorText}`;
      }
    } catch (_) {
      errorMsg += `: ${errorText}`;
    }
    throw new Error(errorMsg);
  }

  return await res.json();
}

async function captureOrder(orderId: string) {
  const token = await getAccessToken();
  const res = await fetch(
    `${BASE_URL}/v2/checkout/orders/${orderId}/capture`,
    {
      method: "POST",
      headers: {
        Authorization: `Bearer ${token}`,
        "Content-Type": "application/json",
        Accept: "application/json",
      },
    }
  );

  if (!res.ok) {
    const errorText = await res.text();
    let errorMsg = `PayPal capture failed: ${res.status}`;
    try {
      const errorJson = JSON.parse(errorText);
      if (errorJson?.error?.message) {
        errorMsg += `: ${errorJson.error.message}`;
      } else if (errorJson?.message) {
        errorMsg += `: ${errorJson.error}`;
      } else {
        errorMsg += `: ${errorText}";
      }
    } catch (_) {
      errorMsg += `: ${errorText}";
    }
    throw new Error(errorMsg);
  }

  return await res.json();
}

async function getOrderStatus(orderId: string) {
  const token = await getAccessToken();
  const res = await fetch(`${BASE_URL}/v2/checkout/orders/${orderId}`, {
    headers: {
      Authorization: `Bearer ${token}`,
      "Content-Type": "application/json",
      Accept: "application/json",
    },
  });

  if (!res.ok) {
    const errorText = await res.text();
    throw new Error(`Failed to fetch order status: ${res.status} ${errorText}`);
  }

  return await res.json();
}

function jsonResponse(data: unknown, status = 200) {
  return new Response(JSON.stringify(data), {
    status,
    headers: { ...corsHeaders, "Content-Type": "application/json" },
  });
}

serve(async (req) => {
  if (req.method === "OPTIONS") {
    return new Response("ok", { headers: corsHeaders });
  }

  try {
    const url = new URL(req.url);

    // Health check
    if (req.method === "GET" && url.pathname.endsWith("/paypal")) {
      return jsonResponse({
        ok: true,
        live: PAYPAL_LIVE,
        baseUrl: BASE_URL,
        hasClientId: !!PAYPAL_CLIENT_ID,
        hasSecret: !!PAYPAL_SECRET,
      });
    }

    if (req.method !== "POST") {
      return jsonResponse(
        { success: false, error: "Method not allowed" },
        405
      );
    }

    let body: { action?: string; usdAmount?: number; description?: string; userEmail?: string };
    try {
      body = await req.json();
    } catch (e) {
      return jsonResponse(
        { success: false, error: "Invalid JSON in request body" },
        400
      );
    }

    const action = body.action as string | undefined;

    // Handle create-order
    if (action === "create-order") {
      const { usdAmount, description, userEmail } = body;
      if (
        typeof usdAmount !== "number" ||
        !isFinite(usdAmount) ||
        usdAmount <= 0
      ) {
        return jsonResponse(
          { success: false, error: "Invalid or missing usdAmount" },
          400
        );
      }
      if (!description || typeof description !== "string") {
        return jsonResponse(
          { success: false, error: "Invalid or missing description" },
          400
        );
      }

      try {
        const order = await createOrder(
          Number(usdAmount),
          String(description),
          String(userEmail ?? "")
        );

        // Extract approve URL from HATEOAS links
        let approveUrl: string | null = null;
        if (order.links && Array.isArray(order.links)) {
          const approveLink = order.links.find(
            (link: { rel?: string; href?: string }) => link.rel === "approve"
          );
          if (approveLink?.href) {
            approveUrl = approveLink.href;
          }
        }

        if (!approveUrl) {
          return jsonResponse(
            { success: false, error: "No approve URL returned by PayPal" },
            500
          );
        }

        return jsonResponse({
          success: true,
          orderId: order.id,
          approveUrl,
        });
      } catch (error) {
        return jsonResponse(
          { success: false, error: String(error) },
          500
        );
      }
    }

    // Handle capture-order
    if (action === "capture-order") {
      const { orderId } = body;
      if (!orderId || typeof orderId !== "string") {
        return jsonResponse(
          { success: false, error: "Invalid or missing orderId" },
          400
        );
      }

      try {
        const result = await captureOrder(String(orderId));
        const purchaseUnit = result.purchase_units?.[0];
        const payments = purchaseUnit?.payments?.captures?.[0];
        const status = result.status ?? "UNKNOWN";
        const captureId = payments?.id ?? null;

        // Consider it a success if:
        // - status is COMPLETED, OR
        // - it's already captured (common edge case)
        const isSuccess =
          status === "COMPLETED" ||
          result.detail?.[0]?.issue === "ORDER_ALREADY_CAPTURED" ||
          result.detail?.[0]?.issue === "ACTION_DOES_NOT_MATCH_INTENT";

        return jsonResponse({
          success: isSuccess,
          status,
          captureId,
          error: isSuccess ? null : "Capture failed",
        });
      } catch (error) {
        return jsonResponse(
          { success: false, error: String(error) },
          500
        );
      }
    }

    // Handle order-status
    if (action === "order-status") {
      const { orderId } = body;
      if (!orderId || typeof orderId !== "string") {
        return jsonResponse(
          { success: false, error: "Invalid or missing orderId" },
          400
        );
      }

      try {
        const order = await getOrderStatus(String(orderId));
        return jsonResponse({
          success: true,
          status: order.status ?? "UNKNOWN",
        });
      } catch (error) {
        return jsonResponse(
          { success: false, error: String(error) },
          500
        );
      }
    }

    // Unknown action
    return jsonResponse(
      { success: false, error: "Unknown action: " + (action ?? "null") },
      400
    );
  } catch (error) {
    // Catch-all: any unexpected error
    return jsonResponse(
      { success: false, error: `Unexpected error: ${String(error)}` },
      500
    );
  }
});