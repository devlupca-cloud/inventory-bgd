# BGD Inventory System

Multi-site inventory management system for BGD Solutions, built with Next.js and Supabase.

## Features

- Multi-site inventory tracking
- Stock movements (IN, OUT, transfers)
- Purchase request workflow
- Low stock alerts
- Role-based access control (viewer, supervisor, manager, owner)
- Mobile-friendly PWA support

## Tech Stack

- **Frontend**: Next.js 14+ (App Router), TypeScript, Tailwind CSS
- **Backend**: Supabase (Postgres, Auth, RLS, RPC)
- **Deployment**: Vercel (frontend), Supabase Cloud (backend)

## Setup Instructions

### 1. Prerequisites

- Node.js 18+ installed
- Supabase account (free tier works)
- Vercel account (free tier works)

### 2. Local Development Setup

1. Clone the repository:
```bash
git clone <repository-url>
cd inventory_bgd
```

2. Install dependencies:
```bash
npm install
```

3. Create a Supabase project:
   - Go to [supabase.com](https://supabase.com)
   - Create a new project
   - Note your project URL and anon key

4. Set up environment variables:
   - Copy `.env.example` to `.env.local`
   - Fill in your Supabase credentials:
   ```
   NEXT_PUBLIC_SUPABASE_URL=your_supabase_url
   NEXT_PUBLIC_SUPABASE_ANON_KEY=your_anon_key
   ```

5. Run database migrations:
   - In Supabase dashboard, go to SQL Editor
   - Run the migration files in order:
     - `supabase/migrations/001_initial_schema.sql`
     - `supabase/migrations/002_rls_policies.sql`
     - `supabase/migrations/003_rpc_functions.sql`
     - `supabase/migrations/004_triggers.sql`
   - Optionally run `supabase/seed.sql` for test data

6. Configure Supabase Auth:
   - In Supabase dashboard, go to Authentication > URL Configuration
   - Add your local URL to redirect URLs: `http://localhost:3000/api/auth/callback`

7. Start the development server:
```bash
npm run dev
```

8. Open [http://localhost:3000](http://localhost:3000)

### 3. Create Initial Users

1. Go to Supabase dashboard > Authentication > Users
2. Create a user manually or use the sign-up flow
3. Update the user's role in the `user_profiles` table:
   ```sql
   UPDATE user_profiles SET role = 'manager' WHERE email = 'your-email@example.com';
   ```

4. For supervisors, assign them to sites:
   ```sql
   INSERT INTO site_user_roles (user_id, site_id)
   SELECT id, 'site-id-here' FROM user_profiles WHERE email = 'supervisor@example.com';
   ```

## Deployment

### Vercel Deployment

1. Push your code to GitHub
2. Go to [vercel.com](https://vercel.com)
3. Import your repository
4. Add environment variables:
   - `NEXT_PUBLIC_SUPABASE_URL`
   - `NEXT_PUBLIC_SUPABASE_ANON_KEY`
5. Deploy

### Supabase Configuration

1. Update Supabase Auth redirect URLs:
   - Go to Authentication > URL Configuration
   - Add your Vercel domain: `https://your-app.vercel.app/api/auth/callback`

2. Ensure all migrations are run in production Supabase project

## Project Structure

```
inventory_bgd/
├── src/
│   ├── app/              # Next.js App Router pages
│   ├── components/       # React components
│   ├── lib/              # Utilities, queries, RPC wrappers
│   ├── hooks/            # React hooks
│   └── types/            # TypeScript types
├── supabase/
│   └── migrations/       # Database migrations
└── public/               # Static assets
```

## User Roles

- **Viewer**: Read-only access to all sites
- **Supervisor**: Can create purchase requests and register OUT for assigned sites
- **Manager**: Full access to all sites, can approve/receive purchase requests
- **Owner**: Same as manager (admin)

## Development

- Run linter: `npm run lint`
- Build for production: `npm run build`
- Start production server: `npm start`

## License

Private - BGD Solutions
