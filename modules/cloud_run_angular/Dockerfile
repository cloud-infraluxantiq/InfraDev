FROM node:18

WORKDIR /app
COPY . .

RUN npm install -g @angular/cli && \
    npm install && \
    ng build --configuration=production

CMD ["npx", "http-server", "dist/angular-app", "-p", "8080"]