FROM mcr.microsoft.com/playwright:focal AS base

WORKDIR /app

# Install only production deps to keep image slim
COPY package*.json ./
RUN npm install --production

# Copy source
COPY . .

# Ensure Playwright browsers (Chromium) are installed inside the image.
# This runs at build-time so runtime containers already have the binary.
RUN npx playwright install --with-deps chromium

ENV PORT=3000 \
    NODE_ENV=production

EXPOSE 3000

CMD ["npm", "start"]