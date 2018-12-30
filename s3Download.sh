#!/usr/bin/env bash

BUCKET_NAME=$1

function _help() {
	echo -e "Usage: bash $0 {BUCKET NAME} --path={PATH NAME} [-rR]"
	echo -e "Options:"
	echo -e "  -p, --path	Path location you want to download"
	echo -e "  -r, --region	Region of S3 (if blank, ap-southeast-1)"
	echo -e "  -R 		Recursive download"
	echo -e "\nYour downloaded results on {BUCKET NAME}_files/\n"
	exit
}

for i in "$@"
do
case $i in
	-h|--help)
		_help
	;;
		-p=*|--path=*)
		OPT_PATH="${i#*=}"
		shift
	;;
		-r=*|--region=*)
		OPT_REGION="${i#*=}"
		shift
	;;
		-R|--recursive)
		OPT_RECURSIVE="--recursive"
		shift
	;;
esac
done

AWS_S3="aws s3 ls s3://${BUCKET_NAME}/${OPT_PATH}/ --human-readable ${OPT_RECURSIVE}"
OUTPUT_DIR="${BUCKET_NAME}_files/"
mkdir "${OUTPUT_DIR}" &> /dev/null


if [[ -z "${BUCKET_NAME}" ]]; then
	_help
else
	if [[ -z "${OPT_REGION}" ]]; then
		OPT_REGION="ap-southeast-1"
	fi

	S3="https://s3-${OPT_REGION}.amazonaws.com/${BUCKET_NAME}/"
	x=1
	while IFS='' read -r FILES; do
		FILE=$(echo "$FILES" | xargs | cut -d ' ' -f 5- | sed -e 's/\ /+/g')
		URI="${S3}${FILE}"
		FNAME=$(basename "${FILE}")
		if [[ $FNAME == *.* ]]; then
			if ! [[ -f ${OUTPUT_DIR}${FNAME} ]]; then
				printf "[${x}] Downloading ${FNAME}...\n"
				DL=$(curl -sD - "${URI}" -o ${OUTPUT_DIR}${FNAME})
				x=$(($x + 1))
			else
				printf "[-] Skip ${FNAME}\n"
			fi
		fi
	done < <(${AWS_S3})
fi

TOTAL=$(($x - 1))

if [[ "${TOTAL}" == "0" ]]; then
	echo "Nothing to download."
else
	echo -e "\nSuccess downloaded $(($x - 1)) files!"
fi
