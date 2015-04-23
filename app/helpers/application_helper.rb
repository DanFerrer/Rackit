module ApplicationHelper
  def present(object, klass = nil)
    klass ||= "#{presenter_name(object)}Presenter".constantize
    presenter = klass.new(object, self)
    yield presenter if block_given?
  end

  private
  def presenter_name(object)
    object.class.name == "GooglePlaces::Spot" ? "Attraction" : object.class.name
  end
end
