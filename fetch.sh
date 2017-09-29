#!/bin/bash
source ./config
# Clear the output directory
rm -rf out

# Create necessary directories
mkdir -p out/scel
mkdir -p out/rime

date=$(date +%Y.%m.%d)

# Loop over all the dictionaries
i=0
while [ "x${DICT_IDS[i]}" != "x" ]; do
  id=${DICT_IDS[i]}
  name=${DICT_NAMES[i]}
  shortname=${DICT_SHORTS[i]}
  echo "Fetching ${id}: ${name}"
  curl -L "http://pinyin.sogou.com/d/dict/download_cell.php?id=${id}&name=${name}&f=detail" > out/scel/$id.scel
  python ./scel2txt.py out/scel/$id.scel
  txt=$(cat out/scel/$id.txt)
  header="---\nname: ${DICT_PREFIX}.${shortname}\nversion: \"${date}\"\nsort: original\nuse_preset_vocabulary: true\n...\n\n"
  echo -e "$header${txt}" > out/rime/${DICT_PREFIX}.${shortname}.yaml
  i=$(( $i + 1 ))
done

if [[ ! -z "$COPY" ]]; then
  cp out/rime/* "$COPY"
fi
