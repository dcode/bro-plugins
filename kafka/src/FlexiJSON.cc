#include "FlexiJSON.h"

namespace threading { namespace formatter {

FlexiJSON::FlexiJSON(string sn, MsgThread* t, JSON::TimeFormat tf, string mj ): JSON(t, tf), stream_name(sn), meta_json(mj)
{ JSON::SurroundingBraces(false); }

FlexiJSON::~FlexiJSON()
{}

bool FlexiJSON::Describe(ODesc* desc, int num_fields, const Field* const* fields, Value** vals) const
{
    desc->AddRaw("{");
    // append the JSON formatted log record itself
    JSON::Describe(desc, num_fields, fields, vals);

    desc->AddRaw(",\"@meta\":{\"path\":");

    // 'tag' the json; aka prepend the stream name to the json-formatted log content
    desc->AddRaw("\"");
    desc->AddRaw(stream_name);
    desc->AddRaw("\"");

    // Add user inputed data, if present
    if( ! meta_json.empty() )
    {
        desc->AddRaw(",");
        desc->AddRaw(meta_json);
    }


    desc->AddRaw("}}");
    return true;
}

}}
