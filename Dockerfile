FROM mcr.microsoft.com/playwright:v1.45.1-focal

WORKDIR /app

COPY package*.json ./

# Install production dependencies
RUN npm ci --only=production

COPY . .

# Playwright browsers are already in the base image, but we might need to ensure they are linked correctly if we were not using the official image.
# Since we ARE using the official image matching the version, we strictly don't need 'npx playwright install' again 
# UNLESS the base image version doesn't match exactly what's in package.json.
# To be safe and ensure compatibility, we can leave it or rely on the base image. 
# The base image v1.45.1-focal contains the browsers for playwright v1.45.1.

ENV PORT=3000
ENV NODE_ENV=production

EXPOSE 3000

CMD ["node", "server.js"]