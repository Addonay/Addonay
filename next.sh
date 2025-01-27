#!/usr/bin/env bash

set -eo pipefail

# Ensure the script is not running as root
if [ "$EUID" -eq 0 ]; then
  echo "Please do not run this script as root."
  exit 1
fi

# Check Bun installation
if ! command -v bun &>/dev/null; then
  echo "Bun is not installed. Install it from https://bun.sh/"
  exit 1
fi

# Check for permission issues
if ! [ -w "$HOME" ]; then
  echo "Cannot write to $HOME. Please check permissions."
  exit 1
fi

# Use provided argument if exists, otherwise let bun prompt for name
PROJECT_NAME="${1:-}"

if [ -n "$PROJECT_NAME" ]; then
  # If PROJECT_NAME is provided, pass it to bun create
  bun create next-app@latest --ts --app --src-dir --turbopack --use-bun --eslint --tailwind --skip-install --yes "$PROJECT_NAME"
else
  # Otherwise, let bun create prompt for the project name
  bun create next-app@latest --ts --app --src-dir --turbopack --use-bun --eslint --tailwind --skip-install --yes
  # Capture the project name based on the last created directory
  PROJECT_NAME=$(ls -td -- */ | head -n 1 | tr -d '/')
fi

# Verify the project directory was created
if [ -z "$PROJECT_NAME" ] || [ ! -d "$PROJECT_NAME" ]; then
  echo "Error: Project directory could not be determined or does not exist."
  exit 1
fi

# Move into the project directory
cd "$PROJECT_NAME"

# Create necessary directories
mkdir -p src/app/auth
mkdir -p src/app/api/auth/webhook
mkdir -p src/app/auth/sign-in/[[...sign-in]]
mkdir -p src/app/auth/sign-up/[[...sign-up]]

# Install dependencies
bun add @tanstack/react-table
bun add convex@latest @clerk/nextjs@latest @trivago/prettier-plugin-sort-imports@latest prettier-plugin-tailwindcss@latest framer-motion@latest svix@latest @vercel/analytics@latest

# Initialize shadcn components
bunx --bun shadcn@latest init -d 
bunx --bun shadcn@latest add accordion alert alert-dialog aspect-ratio avatar badge breadcrumb button calendar card carousel chart checkbox collapsible command context-menu dialog drawer dropdown-menu form hover-card input input-otp label menubar navigation-menu pagination popover progress radio-group resizable scroll-area select separator sheet sidebar skeleton slider sonner switch table tabs textarea toast toggle toggle-group tooltip

echo "Everything is set up. Now running dev server for the convex db"




cat << 'EOF' > src/app/layout.tsx
import type { Metadata } from "next";
import { Abel, Caveat } from "next/font/google";
import { Analytics } from "@vercel/analytics/react";
import { Providers } from "@/components/providers";
import "./globals.css";

const abel = Abel({
    weight: "400",
    variable: "--font-abel",
    preload: true,
    subsets: ["latin"],
});

const caveat = Caveat({
    variable: "--font-caveat",
    preload: true,
    weight: ["400", "700", "500", "600"],
    subsets: ["latin-ext", "cyrillic-ext"],
});

export const metadata: Metadata = {
    metadataBase: new URL("https://nextstarter.xyz/"),
    title: {
        default: "Next Starter",
        template: `%s | Next Starter`,
    },
    description:
        "The Ultimate Nextjs 15 Starter Kit for quickly building your SaaS, giving you time to focus on what really matters",
    openGraph: {
        description:
            "The Ultimate Nextjs 15 Starter Kit for quickly building your SaaS, giving you time to focus on what really matters",
        images: [
            "https://dwdwn8b5ye.ufs.sh/f/MD2AM9SEY8GucGJl7b5qyE7FjNDKYduLOG2QHWh3f5RgSi0c",
        ],
        url: "https://nextstarter.xyz/",
    },
    twitter: {
        card: "summary_large_image",
        title: "Nextjs Starter Kit",
        description:
            "The Ultimate Nextjs 15 Starter Kit for quickly building your SaaS, giving you time to focus on what really matters",
        siteId: "",
        creator: "@rasmickyy",
        creatorId: "",
        images: [
            "https://dwdwn8b5ye.ufs.sh/f/MD2AM9SEY8GucGJl7b5qyE7FjNDKYduLOG2QHWh3f5RgSi0c",
        ],
    },
};
export default function RootLayout({
    children,
}: Readonly<{
    children: React.ReactNode;
}>) {
    return (
        <html
            lang="en"
            suppressHydrationWarning
            className="text-foreground bg-background"
        >
            <body className={`${(caveat.variable, abel.variable)} antialiased`}>
                <Providers>{children}</Providers>
                <Analytics />
            </body>
        </html>
    );
}
EOF

cat << 'EOF' > src/app/robots.ts
import { MetadataRoute } from 'next'

export default function robots(): MetadataRoute.Robots {
    return {
        rules: {
            userAgent: '*',
            allow: '/',
            disallow: '/dashboard/',
        },
        sitemap: 'https://nextstarter.xyz/sitemap.xml',
    }
}
EOF

cat << 'EOF' > src/app/robots.ts
type SitemapEntry = {
    url: string;
    lastModified: string;
    changeFrequency:
    | "always"
    | "hourly"
    | "daily"
    | "weekly"
    | "monthly"
    | "yearly"
    | "never";
    priority?: number;
};

export default async function sitemap(): Promise<SitemapEntry[]> {
    const baseUrl = "https://nextstarter.xyz";

    const staticPages: SitemapEntry[] = [
        {
            url: baseUrl,
            lastModified: new Date().toISOString(),
            changeFrequency: "monthly",
            priority: 1,
        },
        {
            url: `${baseUrl}/blog`,
            lastModified: new Date().toISOString(),
            changeFrequency: "weekly",
            priority: 0.8,
        },
    ];

    return [...staticPages];
}
EOF

cat << 'EOF' > src/components/providers.ts
"use client";

import { ReactNode } from "react";
import { ClerkProvider } from "@clerk/nextjs";
import { ConvexProvider, ConvexReactClient } from "convex/react";

const convex = new ConvexReactClient(process.env.NEXT_PUBLIC_CONVEX_URL!);

function ConvexClientProvider({ children }: { children: ReactNode }) {
    return <ConvexProvider client={convex}>{children}</ConvexProvider>;
}
export function Providers({ children }: { children: ReactNode }) {
    return (
        <ClerkProvider>
            <ConvexClientProvider>{children}</ConvexClientProvider>
        </ClerkProvider>
    );
}
EOF

cat << 'EOF' > .prettierrc.json
{
    "semi": true,
    "singleQuote": false,
    "tabWidth": 4,
    "trailingComma": "es5",
    "importOrder": [
        "^(react|next?/?([a-zA-Z/]*))$",
        "<THIRD_PARTY_MODULES>",
        "^@/(.*)$",
        "^[./]"
    ],
    "importOrderSeparation": false,
    "importOrderSortSpecifiers": true,
    "plugins": [
        "@trivago/prettier-plugin-sort-imports",
        "prettier-plugin-tailwindcss"
    ]
}
EOF

cat << 'EOF' > .env.local
NEXT_PUBLIC_CLERK_PUBLISHABLE_KEY=
CLERK_SECRET_KEY=

CLERK_WEBHOOK_SECRET=

NEXT_PUBLIC_CLERK_SIGN_IN_URL=/auth/sign-in
NEXT_PUBLIC_CLERK_SIGN_UP_URL=/auth/sign-up

FRONTEND_URL=https://localhost:3000

STRIPE_SECRET_KEY=
STRIPE_WEBHOOK_SECRET=
NEXT_PUBLIC_STRIPE_PUBLIC_KEY=

NEXT_PUBLIC_STRIPE_PRICE_ID=
EOF


cat << 'EOF' > src/app/api/auth/webhook/route.ts
import { api } from "../../../../../convex/_generated/api";
import { WebhookEvent } from "@clerk/nextjs/server";
import { fetchMutation } from "convex/nextjs";
import { headers } from "next/headers";
import { NextResponse } from "next/server";
import { Webhook } from "svix";

export async function POST(req: Request) {
    // You can find this in the Clerk Dashboard -> Webhooks -> choose the webhook
    const WEBHOOK_SECRET = process.env.CLERK_WEBHOOK_SECRET;

    if (!WEBHOOK_SECRET) {
        throw new Error(
            "Please add WEBHOOK_SECRET from Clerk Dashboard to .env or .env.local"
        );
    }

    // Get the headers
    const headerPayload = await headers();
    const svix_id = headerPayload.get("svix-id");
    const svix_timestamp = headerPayload.get("svix-timestamp");
    const svix_signature = headerPayload.get("svix-signature");

    // If there are no headers, error out
    if (!svix_id || !svix_timestamp || !svix_signature) {
        return new Response("Error occured -- no svix headers", {
            status: 400,
        });
    }

    // Get the body
    const payload = await req.json();
    const body = JSON.stringify(payload);

    // Create a new SVIX instance with your secret.
    const wh = new Webhook(WEBHOOK_SECRET);

    let evt: WebhookEvent;

    // Verify the payload with the headers
    try {
        evt = wh.verify(body, {
            "svix-id": svix_id,
            "svix-timestamp": svix_timestamp,
            "svix-signature": svix_signature,
        }) as WebhookEvent;
    } catch (err) {
        console.error("Error verifying webhook:", err);
        return new Response("Error occured", {
            status: 400,
        });
    }

    const eventType = evt.type;

    switch (eventType) {
        case "user.created":
            try {
                console.log("payload", payload);

                const userData = {
                    userId: payload?.data?.id,
                    email: payload?.data?.email_addresses?.[0]?.email_address,
                    name: `${payload?.data?.first_name ? payload?.data?.first_name : ""}`,
                    username: payload?.data?.username,
                    createdAt: Date.now(),
                    profileImage: payload?.data?.profile_image_url,
                };

                await fetchMutation(api.users.createUser, userData);

                return NextResponse.json({
                    status: 200,
                    message: "User info inserted",
                });
            } catch (error) {
                return NextResponse.json({
                    status: 400,
                    error,
                });
            }

        case "user.updated":
            try {
                return NextResponse.json({
                    status: 200,
                    message: "User info updated",
                });
            } catch (error) {
                return NextResponse.json({
                    status: 400,
                    error,
                });
            }

        default:
            return new Response("Error occured -- unhandeled event type", {
                status: 400,
            });
    }
}
EOF


cat << 'EOF' > src/app/auth/sign-in/[[...sign-in]]/page.tsx
import { SignIn } from "@clerk/nextjs";

export default function Page() {
    return (
        <div className="flex items-center justify-center min-h-screen">
            <SignIn/>
        </div>
    );
}

EOF

cat << 'EOF' > src/app/auth/sign-up/[[...sign-up]]/page.tsx
import { SignUp } from "@clerk/nextjs";

export default function Page() {
    return (
        <div className="flex min-h-screen items-center justify-center">
            <SignUp />
        </div>
    );
}

EOF

cat << 'EOF' > src/app/auth/page.tsx
import { redirect } from "next/navigation";

export default function Page() {
    redirect("/auth/sign-in");
}
EOF

cat << 'EOF' > src/middleware.ts
import { clerkMiddleware, createRouteMatcher } from "@clerk/nextjs/server";
import { type NextRequest } from "next/server";

const isPublicRoute = createRouteMatcher(["/auth(.*)", "/", "/api/auth/webhook"]);

export default clerkMiddleware(async (auth, request: NextRequest) => {
    if (!isPublicRoute(request)) {
        await auth.protect()
    }
})

export const config = {
    matcher: [
        // Skip Next.js internals and all static files, unless found in search params
        '/((?!_next|[^?]*\\.(?:html?|css|js(?!on)|jpe?g|webp|png|gif|svg|ttf|woff2?|ico|csv|docx?|xlsx?|zip|webmanifest)).*)',
        // Always run for API routes
        '/(api|trpc)(.*)',
    ],
}
EOF

echo "Done"

bunx --bun convex@latest dev 


cat << 'EOF' > convex
import { mutation, query } from "./_generated/server";
import { v } from "convex/values";

export const createUser = mutation({
    args: {
        userId: v.string(),
        email: v.string(),
        name: v.string(),
        username: v.string(),
        accountType: v.string(),
        createdAt: v.number(),
        profileImage: v.string(),
    },
    handler: async (ctx, args) => {
        try {
            const newUser = await ctx.db.insert("users", {
                userId: args.userId,
                email: args.email,
                name: args.name,
                username: args.username,
                accountType: args.accountType,
                createdAt: args.createdAt,
                profileImage: args.profileImage,
            });

            return newUser;
        } catch {
            throw new Error("User informated did not insert successfully");
        }
    },
});

export const readUser = query({
    args: {
        userId: v.string(),
    },
    handler: async (ctx, args) => {
        try {
            const userInfo = await ctx.db
                .query("users")
                .filter((user) => {
                    return user.eq(user.field("userId"), args.userId);
                })
                .first();

            return userInfo;
        } catch {
            throw new Error("Reading user did not work");
        }
    },
});

export const updateUsername = mutation({
    args: {
        userId: v.string(),
        username: v.string(),
    },
    handler: async (ctx, args) => {
        const user = await ctx.db
            .query("users")
            .filter((q) => q.eq(q.field("userId"), args.userId))
            .first();

        if (!user) {
            throw new Error("User not found");
        }

        const updateUser = await ctx.db.patch(user._id, {
            username: args.username,
        });

        return updateUser;
    },
});

export const updateProfileImage = mutation({
    args: {
        userId: v.string(),
        profileImage: v.string(),
    },
    handler: async (ctx, args) => {
        const user = await ctx.db
            .query("users")
            .filter((q) => q.eq(q.field("userId"), args.userId))
            .first();

        if (!user) {
            throw new Error("User not found");
        }

        const updateUser = await ctx.db.patch(user._id, {
            profileImage: args.profileImage,
        });

        return updateUser;
    },
});

export const searchUsers = query({
    args: {
        searchTerm: v.string(),
        currentUserId: v.string(),
    },
    handler: async (ctx, args) => {
        if (!args.searchTerm) return [];

        const searchTermLower = args.searchTerm.toLowerCase();

        const users = await ctx.db
            .query("users")
            .filter((q) => q.neq(q.field("userId"), args.currentUserId))
            .collect();

        return users
            .filter((user: { name?: string; email?: string }) => {
                const nameMatch = user?.name?.toLowerCase().includes(searchTermLower);

                const emailMatch = user?.email?.toLowerCase().includes(searchTermLower);

                return nameMatch || emailMatch;
            })
            .slice(0, 10);
    },
});
EOF


echo "Done! Project created at: $(pwd)"
	
	
	
	
	
	
	
	
	
	
