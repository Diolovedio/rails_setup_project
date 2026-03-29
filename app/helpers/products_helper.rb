module ProductsHelper
  def next_direction(field, filter_params)
    current_sort = filter_params[:sort]
    current_direction = filter_params[:direction]

    return "asc" unless field.to_s == current_sort.to_s
    current_direction.to_s == "asc" ? "desc" : "asc"
  end
end
