FROM quay.io/toolbx-images/fedora-toolbox:latest

LABEL com.github.containers.toolbox="true" \
      usage="Container for any development based on Fedora" \
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
# RUN zsh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
# RUN git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
# RUN git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
# RUN git clone https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/powerlevel10k

# COPY .zshrc ${HOME}/.zshrc
# COPY .p10k.zsh ${HOME}/.p10k.zsh
# COPY authorized_keys ${HOME}/.ssh/authorized_keys

RUN chsh -s $(which zsh)
CMD [ "zsh" ]
