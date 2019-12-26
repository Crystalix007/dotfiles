if [ -f ~/.profile ]; then
	source ~/.profile
fi

# Path to your oh-my-zsh installation.
# export ZSH=~/.oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
# ZSH_THEME="powerline/powerline"

# Import powerline package
# source /usr/share/zsh-theme-powerlevel9k/powerlevel9k.zsh-theme

# Set list of themes to load
# Setting this variable when ZSH_THEME=random
# cause zsh load theme from this variable instead of
# looking in ~/.oh-my-zsh/themes/
# An empty array have no effect
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
DISABLE_UNTRACKED_FILES_DIRTY="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
# plugins=(
# git
# )

# source $ZSH/oh-my-zsh.sh

# User configuration

# Add fish-like autocomplete
# source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
export EDITOR='nvim'

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Alias from file
if [[ -f ~/.config/zsh/zsh_aliases.zsh ]]; then
	source ~/.config/zsh/zsh_aliases.zsh
fi

# Powerlevel9k prompt shorten context
export POWERLEVEL9K_SHORTEN_STRATEGY="truncate_from_right"
export POWERLEVEL9K_SHORTEN_DIR_LENGTH=3
export POWERLEVEL9K_SHORTEN_DELIMITER=""

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Use VI mode
bindkey -v
export KEYTIMEOUT=1
bindkey '^[^M' self-insert-unmeta

hash -d music=/mnt/Programs/Music/
hash -d android=~/mnt/Android
hash -d D=/mnt/Programs/

pwd_login() {
	if [ $# -ne 1 ]; then
		printf "Invalid usage.\nUsage: pwd_login <character index sequence>\n"
	else
		read -s P; echo $P | cut -c "$1"; unset P
	fi
}

zshcache_time="$(date +%s%N)"

autoload -Uz add-zsh-hook

rehash_precmd() {
	if [[ -a /var/cache/zsh/pacman ]]; then
		local paccache_time="$(date -r /var/cache/zsh/pacman +%s%N)"
		if (( zsh_cache_time < paccache_time )); then
			rehash
			zshcache_time="$paccache_time"
		fi
	fi
}

add-zsh-hook -Uz precmd rehash_precmd

unar() {
	newFolder=$(printf "$1" | sed -E 's/\.\w+$//')
	(mkdir -- "$newFolder" && cd -- "$newFolder" && unarchive "../$1")
}

meta() {
	tmp_file=$(mktemp)

	if (( $# < 1 )); then
		cat ~/Templates/meta.txt >! "${tmp_file}"
		vim "${tmp_file}"
		printf "${tmp_file}" | xclip -in
	elif [[ -f "$1" ]]; then
		ffmpeg -y -i "$1" -f ffmetadata "${tmp_file}" 2>/dev/null

		for line in $(cat ~/Templates/meta.txt); do
			search_line=$(printf "${line}" | sed -Ee 's/^[^a-zA-Z_]*([a-zA-Z_]+\=).*$/\1/')
			grep -i -q -e "${search_line}" "${tmp_file}" || printf "${line}\n" >> "${tmp_file}"
		done

		MOD_TIME=$(stat -c %Z "${tmp_file}")
		$EDITOR "${tmp_file}"

		if (( ${MOD_TIME} != $(stat -c %Z "${tmp_file}") )); then
			ffmpeg -i "$1" -f ffmetadata -i "${tmp_file}" -c copy -map_metadata 1 "${1:r}.meta.${1:e}" 2>/dev/null
		fi
	else
		printf "Invalid file\n"
		return -1
	fi
}

lac() {
	if [ $# -lt 1 ]; then
		printf "Usage: lac <filename>\n"
		return -1
	fi

	local tmpfile="$(mktemp)"
	ffmpeg -y -i "$1" -f wav "${tmpfile}" 2>/dev/null
	LAC "${tmpfile}"
	rm -f "${tmpfile}"
}

setopt NO_NOMATCH

ytimg() {
	if (( $# < 1 )); then
		printf "Please enter YouTube url: "
		read url
	else
		local url = "$1"
	fi

	local tag=$(printf "$url" | perl -pe 's/^https?:\/\/(www\.)?(youtube\.com|youtu\.be)\/watch\?.*v\=(?<tag>\w+).*?$/$+{tag}/')

	local jpegs=(maxresdefault
	hqdefault
	default
	mqdefault
	sddefault)

	for filename in $jpegs; do
		curl "https://img.youtube.com/vi/${tag}/${filename}.jpg" | xclip -i -t image/jpg
		if (( $? == 0 )); then
			break
		fi
	done
}

PATH="/home/michaelkuc6/perl5/bin${PATH:+:${PATH}}"; export PATH;
PERL5LIB="/home/michaelkuc6/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
PERL_LOCAL_LIB_ROOT="/home/michaelkuc6/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
PERL_MB_OPT="--install_base \"/home/michaelkuc6/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=/home/michaelkuc6/perl5"; export PERL_MM_OPT;

bindkey '^ ' forward-word

function internetperf() {
	curl -o /dev/null -sS -w "Connect: %{time_connect}s + TTFB: %{time_starttransfer}s = Total: %{time_total}s\n" "$1"
}

function diffedit() {
	if (( $# < 1 || $# > 2 )); then
		printf $'Please run as \'diffedit <file> [patchname]\'\n' >&2
		return 1
	fi

	local file="$1"

	if [[ ! -f "${file}" ]]; then
		printf "File: \"${file}\" not found\n" >&2
		return 2
	fi

	local filename="${file:t}"
	local patchname
	patchname="${filename}.patch"

	if (( $# == 2 )); then
		patchname="$2"
	fi

	local tmpfolder="$(mktemp -d "XXXXX.EDIT")"
	local tmpfile="${tmpfolder}/${filename}"
	cat "${file}" >! "${tmpfile}"

	if [[ -s "${patchname}" ]]; then
		patch --dry-run -p1 "${tmpfile}" "${patchname}"

		if (( $? != 0 )); then
			printf "Previous patch from \"${patchname}\" failed to apply\n" >&2
			return 3
		fi

		printf $'Non-empty patch found. Applied.\n'

		patch --dry-run -R "${tmpfile}" "${patchname}" 2>&1 >/dev/null

		if (( $? != 0 )); then
			patch -p1 "${tmpfile}" "${patchname}" 2>&1 >/dev/null
		fi
	fi

	${EDITOR} "${tmpfile}"

	if (( $? != 0 )); then
		printf "Editing failed. Abandoning diff. See previous edit at \"${tmpfile}\"\n" >&2
		return 4
	fi

	diff -c "${file}" "${tmpfile}" >! "${patchname}"
	rm -f "${tmpfile}"
	rmdir "${tmpfolder}"

	if [[ ! -s "${patchname}" ]]; then
		rm -f "${patchname}"
	fi
}

function urldecode() {
	perl -pe 's/\%(\w\w)/chr hex $1/ge'
}

function metarestrict() {
	if (($# != 1)); then
		return
	fi

	grep -i "$1" --color=none | sed -e "s/$1\=//i" | grep -v '\=' | head -n1
}

function mediasort1() {
	if (($# != 1)); then
		return
	fi

	local metadata="$(ffmpeg -v 0 -loglevel panic -hide_banner -i ${1} -f ffmetadata -)"

	if [ -z "${metadata}" ]; then
		printf "'%s' does not appear to be a valid media file\n" "${1}"
		return
	fi

	local album_artist="$(metarestrict 'Album.*Artist' <<<"${metadata}")"
	local album="$(metarestrict 'Album' <<<"${metadata}")"

	if [ -z "${album_artist}" ]; then
		artist="$(metarestrict 'Artist' <<<"${metadata}")"

		if [ "$(read -q "YN?No album artist found. Accept ${artist}? ")" = "N" ]; then
			return
		fi

		printf "\n"

		album_artist="${artist}"
		metadata=\
"${metadata}
ALBUM_ARTIST=${album_artist}"

		# printf "Using artist: %s\n%s\n" "${album_artist}" "${metadata}"

		ffmpeg -v 0 -loglevel panic -hide_banner -i "${1}" -f ffmetadata -i /dev/stdin -c copy -map_metadata 1 "New.${1}" <<<"${metadata}"
		mv -f --backup=none "New.${1}" "${1}"
	fi

	r128gain "${1}"

	local prefix=~music/
	prefix="${prefix}/${album_artist}"

	if [ ! -d "${prefix}" ]; then
		printf "Creating album artist directory for '%s'\n" "${album_artist}"
		mkdir "${prefix}"

		if (( $? != 0 )); then
			return
		fi
	fi

	prefix="${prefix}/${album}"

	if [ ! -d "${prefix}" ]; then
		printf "Creating album directory for %s's album '%s'\n" "${album_artist}" "${album}"
		mkdir "${prefix}"

		if (( $? != 0 )); then
			return
		fi
	fi

	cp "${1}" "${prefix}/${1}"
}

function mediasort() {
	if (($# == 0)); then
		printf "Please enter a filename\n"
		return
	fi

	for file in "${@}"; do
		mediasort1 "${file}"
	done
}

function syncaur() {
	local packagedir=~/.cache/yay

	if (($# <= 1)); then
		printf "Please enter a destination and some packages to copy\n"
		return
	fi

	for package in "${@:1}"; do
		if [ -d "${packagedir}/${package}" ]; then
			rsync -rav --progress "${packagedir}/${package}" "${@[1]}:${packagedir}/"
		else
			printf "Package %s is not installed locally at %s\n" "${package}" "${packagedir}"
		fi
	done
}

function ffstrip() {
	if (($# != 1)); then
		printf "Usage: ffstrip <filename>\n"
		exit 1
	fi

	local tmpfile="$(mktemp "XXXXX.${1:e}")"
	ffmpeg -v 0 -loglevel panic -hide_banner -y -i "${1}" -map_metadata -1 -c:a copy -c:v copy -c:s copy "${tmpfile}" && mv -f "${tmpfile}" "${1}"
	rm -f "${tmpfile}"
}

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
	source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi
