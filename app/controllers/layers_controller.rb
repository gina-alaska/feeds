class LayersController < ApplicationController
  def index
    @layers = Layer
  end
  
  def show
    @layer = Layer.find(params[:id].split('-').first)
    @features = @layer.geojson.features
    if params[:properties]
      tmp = @layer.geojson.features.cache.first
    
      params[:properties].each do |k,v|
        if tmp.properties.keys.include? k
          case tmp.properties[k].class.to_s
          when 'Fixnum'
            v = v.to_i
          when 'Float'
            v = v.to_f
          else
            logger.info tmp.properties[k].class
          end
          
          @features = @features.where("properties.#{k}" => /#{v}/i)
        end
      end
    end
    
    respond_to do |format|
      format.json
    end
  end
end
