FROM node:22-alpine AS build

ARG VITE_API_URL
ENV VITE_API_URL=${VITE_API_URL}

WORKDIR /app
COPY . /app

RUN npm install -g pnpm
RUN pnpm install --frozen-lockfile
RUN pnpm run build

# Production stage
FROM nginx:alpine

# Copy built assets from build stage
COPY --from=build /app/dist /usr/share/nginx/html

# Copy nginx configuration
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Expose port
EXPOSE 3000

# Start nginx
CMD ["nginx", "-g", "daemon off;"]
