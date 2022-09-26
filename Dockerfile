FROM node:lts-alpine as builder

ARG URL_PREFIX
ENV URL_PREFIX=${URL_PREFIX}

WORKDIR /app
COPY package.json ./
RUN npm install

COPY . ./
RUN sed "s/==URL_PREFIX==/${URL_PREFIX}/" /app/app.conf > app.conf
RUN npm run build

# ---

FROM nginx:stable-alpine
COPY --from=builder /app/dist /usr/share/nginx/html/dist
RUN rm /etc/nginx/conf.d/default.conf
COPY --from=builder /app/app.conf /etc/nginx/conf.d/app.conf

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
