#!/usr/bin/env bash

hugoVersions=( "$@" )

sortedHugoVersions=( $(
	for v in "${hugoVersions[@]}"; do
		echo "$v"
	done | sort --reverse) )

repo="jny/docker-hugo-firebase:"

# prepare file
echo "#!/usr/bin/env bash" > build-dockerimages.sh
echo "" >> build-dockerimages.sh

for i in "${!sortedHugoVersions[@]}"; do
	string="docker build"
	version=${sortedHugoVersions[$i]}

	if [[ $version =~ ^[0-9]+\.[0-9]+ ]]; then
		versionShort=${BASH_REMATCH[0]}
	else
		echo "Version matching failed." >&2
		continue
	fi

	[[ -d "$versionShort" ]] || mkdir "hugo/$versionShort"

	# on MacOS replace '-r' to '-E' or use 'gsed' instead of 'sed'
	sed -r 's!%%HUGO_VERSION%%!'"$version"'!g' "Dockerfile.template" > "hugo/$versionShort/Dockerfile"

	string="$string -f hugo/$versionShort/Dockerfile"
	if [[ $i == 0 ]]; then
		string="${string} -t ${repo}latest"
	fi

	string="${string} -t ${repo}${version}"

	if [[ $versionShort != $version ]]; then
		string="${string}  -t ${repo}${versionShort}"
	fi

	string="$string ."

	echo "$string" >> build-dockerimages.sh
done