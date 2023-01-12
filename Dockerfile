FROM node as builder

WORKDIR /app

COPY . /app/

RUN npm install --silent
RUN npm install react-scripts@5.0.1 -g --silent

RUN npm run build

FROM nginx:alpine
COPY --from=builder /app/build /usr/share/nginx/html
COPY nginx/nginx.conf /etc/nginx/conf.daemon

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]