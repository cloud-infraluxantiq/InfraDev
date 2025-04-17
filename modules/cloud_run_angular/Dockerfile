# Step 1: Build the Angular app
FROM node:18 as build

WORKDIR /app
COPY . .

RUN npm install -g @angular/cli && \
    npm install && \
    ng build --configuration=production

# Step 2: Serve the app using nginx
FROM nginx:alpine

COPY --from=build /app/dist/* /usr/share/nginx/html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]