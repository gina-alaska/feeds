class LineString < Geometry
  field :type, type: String, default: 'LineString'
  
  def self.from_geojson(json)
    json = JSON.parse(json) if json.kind_of? String
    
    self.new(coordinates: json['coordinates'])
  end
end