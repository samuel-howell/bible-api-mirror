FROM nginx:alpine

# Install wget for downloading API data
RUN apk add --no-cache wget unzip

# Download pre-generated API files from HelloAOLab
WORKDIR /tmp
RUN wget -O api.zip https://bible.helloao.org/api.zip && \
    unzip -q api.zip -d /usr/share/nginx/html && \
    rm api.zip

# Copy nginx configuration
COPY nginx.conf /etc/nginx/nginx.conf

# Health check (use 127.0.0.1 to avoid IPv6 issues)
HEALTHCHECK --interval=30s --timeout=3s --start-period=10s --retries=3 \
  CMD wget --no-verbose --tries=1 --spider http://127.0.0.1/health || exit 1

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
