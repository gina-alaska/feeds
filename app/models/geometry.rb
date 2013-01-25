class Geometry
  include Mongoid::Document
  
  field :coordinates, type: Array
  
  embedded_in :features
  
  def as_json(*args)
    { type: self.type, coordinates: self.coordinates }
  end
  
  def self.from_geojson(json)
    json = JSON.parse(json) if json.kind_of? String
    
    if %w{ Point LineString Polygon MultiPolygon }.include?(json['type'])
      json['type'].constantize.from_geojson(json)
    else
      raise "Unknown geometry type #{json['type']}"
    end
  end
end
