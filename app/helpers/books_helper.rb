module BooksHelper
  def make_receipts(year, month)
    @firstday = Time.mktime(year, month, 1,0,0,0).beginning_of_month 
    @lastday  = @firstday.end_of_month 
    # receipt list
    receipts = @book.receipts.where({pay_date: @firstday..@lastday})
    @data = []
    @income = 0
    @payment = 0
    receipts.each do |i|
      @data.push(i)
      if Genre.find(Store.find(i.store_id).genre_id).income == 1
        @income = @income + i.price
      else
        @payment = @payment + i.price
      end
    end
    monthlyincomes = Monthlyinput.where(:book_id => @book.id)
    monthlyincomes.each do |m|
      r = @book.receipts.build({price: m.price, store_id: m.store_id, pay_date: Time.mktime(@year, @month, m.inputday)})
      @data.push(r)
      if Genre.find(Store.find(r.store_id).genre_id).income == 1
        @income = @income + r.price
      else
        @payment = @payment + r.price
      end
    end
    
    @data.sort! do |a, b|
      a[:pay_date] <=> b[:pay_date]
    end
    ret = {data: @data, income: @income, payment: @payment }
  end
  
  def booknav()
    if params[:book_id]
      @bookid = params[:book_id]
      return true
    end
    
    return false
  end
  
  def get_pretime
  pretime = {}
  pretime[:year] = @year
  pretime[:month] = @month - 1

  if(@month == 1)
    pretime[:year] = @year - 1
    pretime[:month] = 12
  end
  
  pretime[:str] = pretime[:year].to_s + "年" + pretime[:month].to_s + "月"
  
  return pretime
  
  end
  
  def get_posttime
  posttime = {}
  posttime[:year] = @year
  posttime[:month] = @month + 1

  if(@month == 12)
    posttime[:year] = @year + 1
    posttime[:month] = 1
  end
  
  posttime[:str] = posttime[:year].to_s + "年" + posttime[:month].to_s + "月"
  
  return posttime

  end
end
