## Description
This is a benchmarking suite for the BERT-large model under PyTorch.
The benchmark source is adopted from NVIDIA's Deep-learning Example @
https://github.com/NVIDIA/DeepLearningExamples/tree/master/PyTorch/LanguageModeling/BERT

The benchmark is performed using the following software environments
CUDA version:   10.1
CUDNN version:  7.6
Ubuntu version: 18.04


## Setup

If this is your first time running the benchmark on the host, please first
prepare the environment by running ./build_image.sh. This will build a docker
image with everything you need to run the benchmark script.

Next, start a docker container by running ./run_container.sh. This will prompt
a shell in the container environment.

You will need to provide a dataset directory to ./run_container.sh, if there is
none provided, the script will use the default dataset on eco-14 located at
/home/SCRATCH/dataset/tbd-bert-wiki-bookcorpus-pytorch/data/

If you are running the benchmark on eco machine, please make sure you allocate
your GPU resource with gardener before launching any scripts.

## Running the benchmark

Once you are in the docker container, you should already be inside a conda
environment, you can run nvidia-smi to confirm your compute resource and CUDA
version.

To start benchmarking:
`cd /workspace/bert/`

Edit the configuration in the scripts i.e. whether to profile, floating point
representation, number of GPUs, bach size, etc
`vim scripts/run_pretraining.sh` for pre-training
or
`vim scripts/run_squad.sh` for fine-tuning

then do
`bash scripts/run_pretraining.sh `
or
`bash scripts/run_squad.sh`

to start the benchmark
