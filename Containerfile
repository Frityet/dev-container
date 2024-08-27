FROM quay.io/toolbx-images/fedora-toolbox:latest

ARG OPENSSH_PORT
ENV HOME=/root

LABEL com.github.containers.toolbox="true" \
      usage="Container for any development based on Debian" \
      summary="Dev container" \
      maintainer="ambhogal01@gmail.com"

RUN dnf update -y && dnf upgrade -y
RUN dnf install -y            \
            git               \
            zsh               \
            wget              \
                              \
            openssh-server    \
            mosh              \
                              \
            fzf               \
            \
            nano

#now we install powerlevel10k
RUN zsh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
RUN git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
RUN git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
RUN git clone https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/powerlevel10k

COPY .zshrc ${HOME}/.zshrc
COPY .p10k.zsh ${HOME}/.p10k.zsh
COPY ../../.ssh/

RUN rpm --import https://packages.microsoft.com/keys/microsoft.asc
RUN echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" | sudo tee /etc/yum.repos.d/vscode.repo > /dev/null
RUN dnf check-update
RUN dnf install code -y

# so we can ssh into the container easily from another device
RUN sed -i "s/#Port 22/Port ${OPENSSH_PORT}/g" /etc/ssh/sshd_config

# RUN   ln -fs /bin/sh /usr/bin/sh && \
#       ln -fs /usr/bin/distrobox-host-exec /usr/local/bin/docker && \
#       ln -fs /usr/bin/distrobox-host-exec /usr/local/bin/podman

RUN chsh -s $(which zsh)

CMD [ "zsh" ]
