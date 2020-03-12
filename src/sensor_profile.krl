ruleset sensor_profile {
  meta {
    shares __testing, get_settings
    provides get_hame, get_location, get_threshold, get_phone
  }
  global {
    __testing = { "queries": [
      { "name": "__testing" },
      { "name": "get_settings" }
      //, { "name": "entry", "args": [ "key" ] }
      ] , "events":
      [ //{ "domain": "d1", "type": "t1" }
      //, { "domain": "d2", "type": "t2", "attrs": [ "a1", "a2" ] }
      ]
    }


    get_settings = function(){
      {
        "name": ent:name,
        "location": ent:location,
        "threshold": ent:threshold,
        "phone": ent:phone,
      }
    }


    get_name = function(){ ent:name }
    get_location = function(){ ent:location }
    get_threshold = function(){ ent:threshold.defaultsTo(100) }
    get_phone = function(){ ent:phone }


  }




  rule update_profile {
    select when sensor profile_updated
    pre {
      name = event:attr("name")
      location = event:attr("location")
      threshold = event:attr("threshold")
      phone = event:attr("phone")
    }

    always {
      ent:name := name
      ent:location := location
      ent:threshold := threshold
      ent:phone := phone
    }

  }




}
