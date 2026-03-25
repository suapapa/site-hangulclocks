# Build Stage
FROM node:22-alpine AS builder

# URL_PREFIX: used for handling sub-path deployments (e.g., GKE)
ARG URL_PREFIX
ENV URL_PREFIX=${URL_PREFIX}

WORKDIR /app

# Install dependencies first to leverage Docker layer caching
COPY package*.json ./
RUN npm ci

# Copy the rest of the application
COPY . .

# Handle URL_PREFIX in Nginx configuration
# If URL_PREFIX is defined, replace the placeholder; otherwise, remove the prefix path
RUN if [ -n "$URL_PREFIX" ]; then \
      sed -i "s|==URL_PREFIX==|${URL_PREFIX}|g" app.conf; \
    else \
      sed -i "s|/==URL_PREFIX==||g" app.conf; \
    fi

# Build the project for production
RUN npm run build

# ---

# Production Stage
FROM nginx:stable-alpine

WORKDIR /usr/share/nginx/html

# Copy only the built assets and configuration
COPY --from=builder /app/dist ./dist
RUN rm /etc/nginx/conf.d/default.conf
COPY --from=builder /app/app.conf /etc/nginx/conf.d/app.conf

# Security and Networking
EXPOSE 80

# Health check (Optional but recommended for GKE/K8s)
HEALTHCHECK --interval=30s --timeout=3s \
  CMD wget --quiet --tries=1 --spider http://localhost/ || exit 1

CMD ["nginx", "-g", "daemon off;"]
