class BaseRepresenter
  def initialize(resource)
    @resource = resource
  end

  def as_json
    if @resource.respond_to?('map')
      @resource.map do |resource|
        render(resource)
      end
    else
      render(resource)
    end
  end

  private

  attr_reader :resource
end
