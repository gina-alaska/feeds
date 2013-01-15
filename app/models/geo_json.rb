class GeoJson
  include Mongoid::Document
  include Mongoid::Timestamps
  
  belongs_to :layer, touch: true
  
  def self.from_geojson(json)
    json = JSON.parse(json) if json.kind_of? String
    
    case(json['type'])
    when 'FeatureCollection'
      FeatureCollection.from_geojson(json)
    else
      raise "Unknown collection type #{json['type']}"
    end
  end
end
