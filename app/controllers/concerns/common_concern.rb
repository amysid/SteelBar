module CommonConcern

  


 def enquiries_search
  binding.pry
    if params[:search]
      @search_params =  params.require(:search).permit(:search,:name,:start,:end).to_h
      @search = @search&.where(get_query,@search_params)
    else
      @search
    end
  end

 
 def get_query
    query= Set.new
    @search_params = @search_params.collect{|k,v| [k.to_sym,v.strip] if v.present? }.compact.to_h
    @search_params[:search] = "%#{@search_params}%"
    @search_params.map{|k,v|
      query << "(name LIKE :#{k})" if k == :search
      if k == :start && @search_params[:start].present? && @search_params[:end].present?
        query << "Date(created_at) BETWEEN :#{k} AND :end"
      elsif (k == :start || k == :end) && query.length < 3
        query << "Date(created_at) >= :#{k}" if k == :start && @search_params[:start].present?
        query << "Date(created_at) <= :#{k}" if k == :end && @search_params[:end].present?
      end
    }
    query.to_a.join(' AND ')
  end

end
