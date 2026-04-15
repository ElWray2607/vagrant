# Validate compose files
FROM elwray2607/vagrant-cli:1.0.0 AS step1

WORKDIR /build

# Copy whole workspace
COPY . .

RUN chmod 775 validateVagrantFile.sh && \
    chmod 775 installPlugins.sh

RUN vagrant -v && \
  ./validateVagrantFile.sh