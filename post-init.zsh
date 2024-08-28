# RUN zsh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
# RUN git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
# RUN git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
# RUN git clone https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/powerlevel10k

# COPY .zshrc ${HOME}/.zshrc
# COPY .p10k.zsh ${HOME}/.p10k.zsh
# COPY authorized_keys ${HOME}/.ssh/authorized_keys

zsh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/powerlevel10k

HOST_HOME=$(echo ../../)

ln "$HOST_HOME/.zshrc" "$HOME/.zshrc"
ln "$HOST_HOME/.p10k.zsh" "$HOME/.p10k.zsh"
mkdir -p $HOME/.ssh/
ln "$HOST_HOME/.ssh/authorized_keys" "$HOME/.ssh/authorized_keys"

FREE_PORT=$(comm -23 <(seq 49152 65535 | sort) <(ss -Htan | awk '{print $4}' | sed 's/.*://g' | sort | uniq) | shuf | head -n 1)
sudo sed -i "s/#Port 22/Port ${FREE_PORT}/g" /etc/ssh/sshd_config && sudo systemctl restart sshd
echo "$FREE_PORT" > "$HOME/openssh-port"
