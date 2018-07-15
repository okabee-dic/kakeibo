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
    spends = []
    incomes = []
    totals = []
    gon.labels = []
    gon.spends = []
    gon.incomes = []
    gon.totals = []
    
    #10か月分取得
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
      
      spends.push(receipts[:payment])
      incomes.push(receipts[:income])
      totals.push(receipts[:income] - receipts[:payment])
    end
    
    # データを逆順にする
    for i in 0..10
      gon.incomes << incomes[10-i]
      gon.spends << spends[10-i]
      gon.totals << totals[10-i]
      gon.labels << months[10-i] 
    end
    
  end
end
