FROM ubuntu:jammy

RUN apt -y update && DEBIAN_FRONTEND=noninteractive apt -y install sudo ca-certificates wget gnupg reprotest && apt -y clean all

RUN printf '\
deb [arch=amd64 signed-by=/usr/share/keyrings/qubes-archive-keyring-4.2.gpg] https://debu.qubes-os.org/r4.2/vm jammy main\n\
deb [arch=amd64 signed-by=/usr/share/keyrings/qubes-archive-keyring-4.2.gpg] https://debu.qubes-os.org/r4.2/vm jammy-testing main\n\
'\ >> /etc/apt/sources.list
RUN wget -O /tmp/qubes-debian-r4.2.asc https://raw.githubusercontent.com/QubesOS/qubes-secpack/main/keys/template-keys/qubes-release-4.2-ubuntu.asc
RUN gpg --dearmor < /tmp/qubes-debian-r4.2.asc > /usr/share/keyrings/qubes-archive-keyring-4.2.gpg
RUN wget -O /tmp/qubes-debian-r4.3.asc https://raw.githubusercontent.com/QubesOS/qubes-secpack/main/keys/template-keys/qubes-release-4.3-ubuntu.asc
RUN gpg --dearmor < /tmp/qubes-debian-r4.3.asc > /usr/share/keyrings/qubes-archive-keyring-4.3.gpg

RUN wget -O /usr/local/bin/faketime https://raw.githubusercontent.com/rustybird/realfaketime/main/faketime

RUN useradd -m user
