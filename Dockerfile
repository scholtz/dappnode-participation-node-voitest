FROM scholtz2/algorand-participation-mainnet:3.18.1-stable

WORKDIR /app

EXPOSE 28081

ENTRYPOINT ["/bin/bash", "/app/run-participation-voitest.sh"]
