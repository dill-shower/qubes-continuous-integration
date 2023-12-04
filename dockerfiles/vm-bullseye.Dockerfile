FROM debian:bullseye

RUN apt -y update && DEBIAN_FRONTEND=noninteractive apt -y install sudo ca-certificates wget gnupg reprotest && apt -y clean all

RUN printf '\
deb [arch=amd64] https://deb.qubes-os.org/r4.2/vm bullseye main\n\
deb [arch=amd64] https://deb.qubes-os.org/r4.2/vm bullseye-testing main\n\
'\ >> /etc/apt/sources.list
RUN wget -O /tmp/qubes-debian-r4.2.asc https://raw.githubusercontent.com/QubesOS/qubes-builderv2/1f51ebdda6f386370ebfa5c600744b8fd2d9d9db/qubesbuilder/plugins/chroot_deb/keys/qubes-debian-r4.2.asc
RUN gpg --dearmor < /tmp/qubes-debian-r4.2.asc > /etc/apt/trusted.gpg.d/qubes-debian-r4.2.gpg

RUN wget -O /usr/local/bin/faketime https://raw.githubusercontent.com/rustybird/realfaketime/main/faketime

# workaround mkinitramfs not seeing root dev in docker
RUN mkdir -p /etc/initramfs-tools/conf.d && echo MODULES=list > /etc/initramfs-tools/conf.d/gitlab-ci.conf

RUN useradd -m user
