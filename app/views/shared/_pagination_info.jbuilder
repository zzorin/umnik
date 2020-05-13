json.pagination_info do
  json.total_pages paginatable_collection.total_pages
  json.current_page params[:page].to_i
  json.next_page paginatable_collection.next_page
end
