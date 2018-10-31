FROM node:latest

# Create app directory
WORKDIR /usr/src/app

COPY ./src/package*.json ./

# install dependencies
RUN npm install
# automatic security fixes
RUN npm audit fix
# manual security fixes 

# Bundle app source 
COPY ./src .

EXPOSE 3000

CMD [ "npm", "start" ]
