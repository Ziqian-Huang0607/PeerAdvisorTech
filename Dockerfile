# Peer Advisor Tech Department — all-in-one image
# Serves the built site AND the workspace API from one Node process.
FROM node:22-alpine

WORKDIR /app

# Install deps first for better layer caching
COPY package.json package-lock.json ./
RUN npm ci

# App source, then production build of the front-end
COPY . .
RUN npm run build

ENV NODE_ENV=production
# The server listens on API_PORT || PORT || 3200 in production.
EXPOSE 3200

CMD ["npm", "start"]
