FROM node:16
# Create app directory
WORKDIR /usr/src/app
COPY . .
RUN npm install \
    && npm install -g http-server \
    && npm run build
EXPOSE 80
ENTRYPOINT ["http-server", "dist/frontend/", "-p", "8080", "--proxy", "http://sausage-store:80"]
