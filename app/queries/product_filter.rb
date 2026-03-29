class ProductFilter
  def initialize(params = {})
    @name = params[:name]
    @sort = params[:sort]
    @direction = params[:direction]
  end

  def results
    scope = Product.all
    scope = scope.by_name(@name) if @name.present?
    scope.ordered_by(@sort, @direction)
  end
end
