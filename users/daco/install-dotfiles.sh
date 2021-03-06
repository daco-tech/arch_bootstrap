_scriptdir="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"

pushd "$_scriptdir" > /dev/null

source "${HOME}/.env.sh"

[ ! $(command -v printinfo &> /dev/null) ] && \
[ -f "../../misc.sh" ] && \
. "../../misc.sh"

_host_dir="../../hosts/$HOST"
_fix_permissions="false"
while [[ $# -gt 0 ]]
do
	case "$1" in
		--host-dir)
			_host_dir="$2"
			shift
			shift
			;;
		--fix-permissions)
			_fix_permissions="true"
			shift
			;;
		*)
			if [ ! $(command -v printinfo &> /dev/null) ]; then
				echo "Unknown option: '$1'. Will be ignored."
			else
				printwarn "Unknown option: '$1'. Will be ignored."
			fi
			shift
			;;
	esac
done

_vimplug_dir="${HOME}/.local/share/nvim/site/autoload"
if [ ! -f "${_vimplug_dir}/plug.vim" ]; then
	_vimplug_url="https://api.github.com/repos/junegunn/vim-plug/contents/plug.vim"
	echo "$0": Downloading "$_vimplug_url" ...
	mkdir -p "$_vimplug_dir"
	curl "$_vimplug_url" -sS -H "Accept:application/vnd.github.v3.raw" -o "${_vimplug_dir}/plug.vim"
fi



if [ "$_fix_permissions" = "true" ]; then
	sudo chown -R kalstong:kalstong dotfiles
	sudo chmod -R u=rw,g=r,o=r dotfiles
	sudo chmod u=rwx,g=r,o=r dotfiles
fi

touch "${HOME}/.hushlogin"
cd dotfiles
cp .bashrc "${HOME}/"
cp .bash_login "${HOME}/"
cp .zshrc "${HOME}/"
cp .zlogin "${HOME}/"
cp .tmux.conf "${HOME}/"
cp .xinitrc "${HOME}/"
cp gpg.conf "${HOME}/.gnupg/"
cp set-alacritty-colorscheme.sh "${HOME}/.local/bin/"
cp ssh.conf "${HOME}/.ssh/config"
cp .ctags "${XDG_CONFIG_HOME}/ctags/default.ctags"
cp bspwmrc "${XDG_CONFIG_HOME}/bspwm/"
chmod u=rwx "${XDG_CONFIG_HOME}/bspwm/bspwmrc"
cp coc-settings.json "${XDG_CONFIG_HOME}/nvim/"
cp fonts.conf "${XDG_CONFIG_HOME}/fontconfig/"
cp git.conf "${XDG_CONFIG_HOME}/git/config"
cp gtk3.ini "${XDG_CONFIG_HOME}/gtk-3.0/settings.ini"
cp init.vim "${XDG_CONFIG_HOME}/nvim/"
cp mimeapps.list "${XDG_CONFIG_HOME}/"
cp openInNewTab.vim "${XDG_CONFIG_HOME}/nvim/nerdtree_plugin"
cp picom.conf "${XDG_CONFIG_HOME}/"
cp polybar.sh "${XDG_CONFIG_HOME}/polybar/start.sh"
chmod u=rwx "${XDG_CONFIG_HOME}/polybar/start.sh"
cp redshift.conf "${XDG_CONFIG_HOME}/"
cp sxhkdrc "${XDG_CONFIG_HOME}/sxhkd/"
cp terminate-session.sh "${XDG_CONFIG_HOME}/polybar/"
sed -i -r "s/<username>/kalstong/" "${XDG_CONFIG_HOME}/picom.conf"
cd "${_scriptdir}"

cd plugins
if [ "$_fix_permissions" = "true" ]; then
	sudo chown -R kalstong:kalstong nnn polybar tmux
	sudo chmod -R u=rw,g=r,o=r nnn polybar tmux
	sudo chmod u=rwx,g=r,o=r nnn polybar tmux
fi


if [ "$_fix_permissions" = "true" ]; then
	sudo chown -R kalstong:kalstong "${_host_dir}"/dotfiles
	sudo chmod -R u=rw,g=r,o=r "${_host_dir}"/dotfiles
	sudo chmod u=rwx,g=r,o=r "${_host_dir}"/dotfiles
fi
cp "${_host_dir}/dotfiles/.bashrc" "${HOME}/.bashrc.aux"
cp "${_host_dir}/dotfiles/.pam_environment" "${HOME}/"
cp "${_host_dir}/dotfiles/.Xresources" "${HOME}/"
cp "${_host_dir}/dotfiles/.energypolicy.sh" "${XDG_CONFIG_HOME}/"
cp "${_host_dir}/dotfiles/alacritty.yml" "${XDG_CONFIG_HOME}/alacritty/"
cp "${_host_dir}/dotfiles/brave-flags.conf" "${XDG_CONFIG_HOME}/"
cp "${_host_dir}/dotfiles/dunstrc" "${XDG_CONFIG_HOME}/dunst/"
cp "${_host_dir}/dotfiles/polybar.conf" "${XDG_CONFIG_HOME}/polybar/config"
cp "${_host_dir}/dotfiles/rslsync.conf" "${XDG_CONFIG_HOME}/rslsync/"
sed -i -r "s/<hostname>/${HOST}/" "${XDG_CONFIG_HOME}/rslsync/rslsync.conf"
sed -i -r "s/<username>/kalstong/" "${XDG_CONFIG_HOME}/rslsync/rslsync.conf"

if [ -f "$HOME/.cache/wal/colors.sh" ]; then
	. "$HOME/.cache/wal/colors.sh"
	sed -i -r "s/<urgency-low-bg>/$background/" "${XDG_CONFIG_HOME}/dunst/dunstrc"
	sed -i -r "s/<urgency-low-fg>/$foreground/" "${XDG_CONFIG_HOME}/dunst/dunstrc"
	sed -i -r "s/<urgency-low-frame>/$foreground/" "${XDG_CONFIG_HOME}/dunst/dunstrc"
	sed -i -r "s/<urgency-normal-bg>/$background/" "${XDG_CONFIG_HOME}/dunst/dunstrc"
	sed -i -r "s/<urgency-normal-fg>/$foreground/" "${XDG_CONFIG_HOME}/dunst/dunstrc"
	sed -i -r "s/<urgency-normal-frame>/$foreground/" "${XDG_CONFIG_HOME}/dunst/dunstrc"
	sed -i -r "s/<urgency-critical-bg>/$background/" "${XDG_CONFIG_HOME}/dunst/dunstrc"
	sed -i -r "s/<urgency-critical-fg>/$color3/" "${XDG_CONFIG_HOME}/dunst/dunstrc"
	sed -i -r "s/<urgency-critical-frame>/$color3/" "${XDG_CONFIG_HOME}/dunst/dunstrc"
else
	# sensible defaults
	sed -i -r "s/<urgency-low-bg>/#151515/" "${XDG_CONFIG_HOME}/dunst/dunstrc"
	sed -i -r "s/<urgency-low-fg>/#d0d0d0/" "${XDG_CONFIG_HOME}/dunst/dunstrc"
	sed -i -r "s/<urgency-low-frame>/#d0d0d0/" "${XDG_CONFIG_HOME}/dunst/dunstrc"
	sed -i -r "s/<urgency-normal-bg>/#151515/" "${XDG_CONFIG_HOME}/dunst/dunstrc"
	sed -i -r "s/<urgency-normal-fg>/#d0d0d0/" "${XDG_CONFIG_HOME}/dunst/dunstrc"
	sed -i -r "s/<urgency-normal-frame>/#d0d0d0/" "${XDG_CONFIG_HOME}/dunst/dunstrc"
	sed -i -r "s/<urgency-critical-bg>/#151515/" "${XDG_CONFIG_HOME}/dunst/dunstrc"
	sed -i -r "s/<urgency-critical-fg>/#ddb26f/" "${XDG_CONFIG_HOME}/dunst/dunstrc"
	sed -i -r "s/<urgency-critical-frame>/#ddb26f/" "${XDG_CONFIG_HOME}/dunst/dunstrc"
fi
bash "${HOME}/.local/bin/set-alacritty-colorscheme.sh" &> /dev/null

printsucc "dotfiles successfully installed!"

popd > /dev/null
