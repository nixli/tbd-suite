BERT_MODEL=../dataset/model
BERT_SOURCE=../source
GLUE_DIR=../dataset/classification

PREFIX="/usr/local/cuda-10.0/NsightCompute-1.0/nv-nsight-cu-cli -o nsight --metrics gpu_time_active,gpu_time_start,gpu_time_end"

$PREFIX /usr/bin/python3.7 $BERT_SOURCE/run_classifier.py \
  --task_name=MRPC \
  --do_train=true \
  --do_eval=true \
  --data_dir=$GLUE_DIR/MRPC \
  --vocab_file=$BERT_MODEL/vocab.txt \
  --bert_config_file=$BERT_MODEL/bert_config.json \
  --init_checkpoint=$BERT_MODEL/bert_model.ckpt \
  --max_seq_length=128 \
  --train_batch_size=32 \
  --learning_rate=2e-5 \
  --num_train_epochs=3.0 \
  --output_dir=$BERT_MODEL/output \