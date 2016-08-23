#ifndef BRO_PLUGIN_BRO_KAFKA_FLEXIJSON_H
#define BRO_PLUGIN_BRO_KAFKA_FLEXIJSON_H

#include <string>
#include <threading/Formatter.h>
#include <threading/formatters/JSON.h>

using threading::formatter::JSON;
using threading::MsgThread;
using threading::Value;
using threading::Field;

namespace threading { namespace formatter {

/*
 * A JSON formatter that adds optional metadata with the log stream path
 * identifier.  For example,
 *   { ..., '@meta' : { 'path': 'conn', ... }}
 *   { ..., '@meta' : { 'path': 'http', ... }}
 */
class FlexiJSON : public JSON {

public:
    FlexiJSON(string stream_name, MsgThread* t, JSON::TimeFormat tf);
    virtual ~FlexiJSON();
    virtual bool Describe(ODesc* desc, int num_fields, const Field* const* fields, Value** vals) const;

private:
    string stream_name;
};

}}
#endif
