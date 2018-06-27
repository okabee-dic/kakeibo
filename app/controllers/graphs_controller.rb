class GraphsController < ApplicationController
  def linegraph
    if params[:book_id]
      @book = Book.find(params[:book_id])
    else 
      redirect_to books_path
    end
    
    if params[:month]
      @month = params[:month].to_i
    else
      @month = Time.now.month
    end
    
    if params[:year]
      @year = params[:year].to_i
    else
      @year = Time.now.year
    end
    
    years = []
    months = []
    prices = []
    gon.labels = []
    gon.data = []
    for i in 0..10
      month = @month - i
      year  = @year
      if month < 1
        month = month + 12
        year = @year - 1
      end
      years.push(year)
      months.push(month)
      
      receipts = view_context.make_receipts(year, month)
      
      prices.push(receipts[:payment])
      
      
    end
    
    for i in 0..10
      gon.data << prices[10-i]
      gon.labels << months[10-i] 
    end
    
  end
end
