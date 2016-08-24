##! load this script to enable log output to kafka

module Kafka;

export {
  # redefine this in your script to identify the sepcific logs
  # that should be sent to Kafka. By default, all will be sent.
  # for example:
  #
  # redef KafkaLogger::include_logs = set(HTTP::LOG, Conn::Log, DNS::LOG);
  #
  # that will send the HTTP, Conn, and DNS logs up to Kafka.
  #
  const include_logs: set[Log::ID] &redef;

  # redefine this in your script to identify the logs
  # that should be excluded from sending to Kafka. By default, all
  # will be sent.
  # for example:
  #
  # redef KafkaLogger::exclude_logs = set(HTTP::LOG, Conn::Log, DNS::LOG);
  #
  # that will send all except the HTTP, Conn, and DNS logs up to Kafka.
  #
  const exclude_logs: set[Log::ID] &redef;
}

event bro_init() &priority=-5
{
	for (stream_id in Log::active_streams)
	{
    # Skip if `include_logs` is configured and this stream isn't a member
	  if (|include_logs| > 0 && stream_id !in include_logs){
        next;
    }
    # Skip if `exclude_logs` is configured and this stream is a member
    if (|exclude_logs| > 0 && stream_id in exclude_logs) {
        next;
    }

    local filter: Log::Filter = [
				$name = fmt("kafka-%s", stream_id),
				$writer = Log::WRITER_KAFKAWRITER,
				$config = table(["stream_id"] = fmt("%s", stream_id))
        ];

    Log::add_filter(stream_id, filter);
	}
}
