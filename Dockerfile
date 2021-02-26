#FROM node:alpine as builder
FROM node:alpine
WORKDIR '/app'
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build

FROM nginx
# beanstalk needs this to specify the port mapping.
EXPOSE 80
# for aws  use this:
COPY --from=0 /app/build /usr/share/nginx/html
# and change line one as well.
#COPY --from=builder /app/build /usr/share/nginx/html