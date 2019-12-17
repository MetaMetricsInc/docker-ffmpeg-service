FROM jrottenberg/ffmpeg:4.2-centos

MAINTAINER Paul Visco <paul.visco@gmail.com>

#####################################################################
#
# A Docker image to convert audio and video for web using web API
#
#   with
#     - Latest FFMPEG (built)
#     - NodeJS
#     - fluent-ffmpeg
#
#   For more on Fluent-FFMPEG, see
#
#            https://github.com/fluent-ffmpeg/node-fluent-ffmpeg
#
#####################################################################

# Add the following two dependencies for nodejs
RUN curl -sL https://rpm.nodesource.com/setup_11.x | bash - && yum install -y nodejs && yum update -y && yum clean all

# Custom Builds go here
RUN npm install -g fluent-ffmpeg

#Create app dir
RUN mkdir -p /usr/src/app/uploads
WORKDIR /usr/src/app

#Install Dependencies
COPY package.json /usr/src/app
RUN npm install

#Bundle app source
COPY . /usr/src/app

EXPOSE 3000
ENTRYPOINT []
CMD [ "node", "app.js" ]
