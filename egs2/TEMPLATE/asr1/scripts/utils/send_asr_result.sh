#!/bin/bash


if [ $# -eq 2 ]; then
    decode_dir=$1
    test_set=$2
else
    exit;
fi

wer=`cat ${decode_dir}/${test_set}/score_wer/result.txt | grep "Avg" | awk '{ print $(NF-2) }'`
python scripts/utils/ateors.py "\n${decode_dir}\n${test_set}, WER: ${wer} %"