MAIN_ROOT=$PWD/../../..
KALDI_ROOT=$MAIN_ROOT/tools/kaldi

export PATH=$PWD/utils/:$KALDI_ROOT/tools/openfst/bin:$KALDI_ROOT/tools/sctk/bin:$PWD:$PATH
[ ! -f $KALDI_ROOT/tools/config/common_path.sh ] && echo >&2 "The standard file $KALDI_ROOT/tools/config/common_path.sh is not present -> Exit!" && exit 1
. $KALDI_ROOT/tools/config/common_path.sh
export LC_ALL=C

set -eu
set +u
#. $MAIN_ROOT/tools/activate_python.sh
#. $MAIN_ROOT/tools/venv/bin/activate
source $MAIN_ROOT/tools/venv/etc/profile.d/conda.sh
conda activate base
set -u

pip install numba==0.48.0
python -m nltk.downloader "averaged_perceptron_tagger" "cmudict"

export PATH=$MAIN_ROOT/utils:$MAIN_ROOT/espnet/bin:$PATH
export PATH=${KALDI_ROOT}/tools/sph2pipe_v2.5:$PATH

export OMP_NUM_THREADS=1

# NOTE(kan-bayashi): Use UTF-8 in Python to avoid UnicodeDecodeError when LC_ALL=C
export PYTHONIOENCODING=UTF-8



# You need to change or unset NCCL_SOCKET_IFNAME according to your network environment
# https://docs.nvidia.com/deeplearning/sdk/nccl-developer-guide/docs/env.html#nccl-socket-ifname
#export NCCL_SOCKET_IFNAME="^lo,docker,virbr,vmnet,vboxnet"
export NCCL_SOCKET_IFNAME=lo
export NCCL_DEBUG=INFO
export NCCL_LL_THRESHOLD=0