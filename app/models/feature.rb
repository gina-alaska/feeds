class Feature
  include Mongoid::Document
  
  field :properties, type: Hash
  field :type, type: String, default: 'Feature'
  
  belongs_to :feature_collection
  embeds_one :geometry
  
  def as_json(*args)
    { type: self.type, geometry: self.geometry, properties: self.properties }
  end
  
  def self.from_geojson(json)
    json = JSON.parse(json) if json.kind_of? String
    
    feature = self.new(
      properties: json['properties'],
      geometry: Geometry.from_geojson(json['geometry'])
    )
  end
end
