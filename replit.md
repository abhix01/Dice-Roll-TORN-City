# Torn Dice Roll

## Overview

A Torn City browser dice game where players log in with their Torn Public API key and play a one-button dice roll game. Features real-time roll results, a recent winners feed, leaderboard, and personal roll history.

## Stack

- **Monorepo tool**: pnpm workspaces
- **Node.js version**: 24
- **Package manager**: pnpm
- **TypeScript version**: 5.9
- **Frontend**: React + Vite (artifact: `torn-dice`, preview: `/`)
- **API framework**: Express 5 (artifact: `api-server`, path: `/api`)
- **Database**: PostgreSQL + Drizzle ORM
- **Validation**: Zod (`zod/v4`), `drizzle-zod`
- **API codegen**: Orval (from OpenAPI spec)
- **Build**: esbuild (CJS bundle)

## Architecture

### Frontend (`artifacts/torn-dice`)
- Login page: enters Torn API key → verifies via backend
- Home page: animated dice roll UI, payout table, recent winners
- Leaderboard: most won, most rolls, biggest jackpots
- History: personal roll log
- Auth token stored in `localStorage` as `torn_dice_token`, injected via `lib/api-client-react/src/custom-fetch.ts`

### Backend (`artifacts/api-server`)
- `POST /api/auth/login` — verifies Torn API key, upserts player, returns token
- `GET /api/auth/me` — returns current player profile
- `POST /api/game/roll` — generates 1–100 roll, calculates payout, saves to DB
- `GET /api/game/history` — player's roll history
- `GET /api/game/recent-winners` — last N winning rolls
- `GET /api/leaderboard` — most won / most rolls / biggest jackpots
- `GET /api/leaderboard/stats` — overall game stats

### Database (`lib/db`)
- `players` table: tornId, name, level, faction, apiKey, totalRolls, totalWon, totalLost
- `rolls` table: playerId, rollNumber, resultType, payout

### Game Logic (`artifacts/api-server/src/lib/game.ts`)
- Roll 1–100 random number
- 1–60 = Lose (0 payout)
- 61–90 = Small Win (1.4x = $1,400,000)
- 91–98 = Big Win (3x = $3,000,000)
- 99–100 = Jackpot (10x = $10,000,000)
- Roll cost: $1,000,000

### Auth Middleware (`artifacts/api-server/src/middlewares/auth.ts`)
- Token format: `tornId:apiKey`
- Validates against DB on each request

## Key Commands

- `pnpm run typecheck` — full typecheck across all packages
- `pnpm run build` — typecheck + build all packages
- `pnpm --filter @workspace/api-spec run codegen` — regenerate API hooks and Zod schemas from OpenAPI spec
- `pnpm --filter @workspace/db run push` — push DB schema changes (dev only)

## Roadmap

- V2: Wallet (balance, deposit, withdraw, bet sizing)
- V3: Auto-roll + daily bonus + streak multiplier
- V4: Progressive jackpot + faction leaderboard
- V5: Admin panel + house edge dashboard + referrals

See the `pnpm-workspace` skill for workspace structure, TypeScript setup, and package details.
