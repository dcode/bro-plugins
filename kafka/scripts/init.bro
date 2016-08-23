module Kafka;

export {
  const topic_name: string = "" &redef;
  const max_wait_on_shutdown: count = 3000 &redef;

  type JSONFormat: enum {
      ## JSON will be formatted using default Bro JSON formatting with only
      ## log data as fields
      ## example:
      ##  { "id.orig_h":"...", }
      JS_DEFAULT,
      ## JSON will be formatted with the log path name tagging the log data
      ## example:
      ##   { "conn": { "id.orig_h": "...", ... }}
      JS_TAGGED,
      ## JSON will be formatted with additional "@meta" object that contains
      ## the log path name, and optionally other user-supplied string.
      ## WARNING: Bro does no validation on user-inputted value, esure it is valid JSON
      ## example:
      ## { "id_orig_h": "...", ..., "@meta": { "path": "conn", ... }}
      JS_FLEXIBLE,
    };

  const json_format: Kafka::JSONFormat;
  const json_timestamps: JSON::TimestampFormat;
  const tag_json: bool = F &redef;
  const kafka_conf: table[string] of string = table(
    ["metadata.broker.list"] = "localhost:9092"
  ) &redef;
}
