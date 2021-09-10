# Container image that runs your code
FROM eboisseausierra/stata:0.0.2

COPY stata.lic /usr/local/stata/stata.lic
RUN ["chmod", "a+r", "/usr/local/stata/stata.lic"]

# Copies your code file from your action repository to the filesystem path `/` of the container
COPY entrypoint.sh /entrypoint.sh
RUN ["chmod", "+x", "/entrypoint.sh"]

# Code file to execute when the docker container starts up (`entrypoint.sh`)
ENTRYPOINT ["/entrypoint.sh"]
