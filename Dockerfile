FROM node:20-slim AS pnpm-base
ENV PNPM_HOME="/pnpm"
ENV PATH="$PNPM_HOME:$PATH"
RUN corepack enable
WORKDIR /app

# DEPENDENCIES
FROM pnpm-base AS deps

COPY package.json pnpm-lock.yaml* ./

RUN npm pkg delete scripts.prepare

RUN \
  if [ -f pnpm-lock.yaml ]; then pnpm install --frozen-lockfile; \
  else echo "Lockfile not found." && exit 1; \
  fi

# APP BUILDER
FROM pnpm-base AS app-builder

COPY --from=deps /app/node_modules ./node_modules
COPY . .

ENV NEXT_TELEMETRY_DISABLED 1

RUN pnpm build

# RUNNER
FROM gcr.io/distroless/nodejs20-debian12 as runner
WORKDIR /app

ENV NODE_ENV production

ENV NEXT_TELEMETRY_DISABLED 1

COPY --from=app-builder /app/public ./public
COPY --from=app-builder --chown=nonroot /app/.next/standalone ./
COPY --from=app-builder --chown=nonroot /app/.next/static ./.next/static
USER nonroot

EXPOSE 3000

ENV PORT 3000

CMD ["server.js"]
