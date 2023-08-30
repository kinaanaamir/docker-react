FROM node:16-alpine as builder

WORKDIR '/app'

COPY ./package.json .

RUN npm install

COPY . .

RUN npm run build


# /app/build is going to contain the build directory
# Second FROM command indicates that the above phase has ended. One phase can only have one FROM statement
FROM nginx
COPY --from=builder /app/build /usr/share/nginx/html

# default command of nginx is Start nginx so we do not have to start it up
# by ourselves
