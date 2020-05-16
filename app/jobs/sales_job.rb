class SalesJob < ActiveJob::Base
  def pesquisa(date, periodType)  
    startDate = (DateTime.parse(date)) if(!date.blank?)

      meta_semana = 93
      if('weekly' == periodType) 
        @meta = (meta_semana * 1) * 12
        startDate = (DateTime.now - (7* 6)) if(date.blank?)
        history = pesquisa_semanal(startDate)
      elsif('biweekly' == periodType)
        @meta = (meta_semana * 2) * 12
        startDate = (DateTime.now - (14* 6)) if(date.blank?)
        history = pesquisa_quizenal(startDate)
      elsif('monthly' == periodType) 
        @meta = (meta_semana * 4) * 12
        startDate = (DateTime.now - 6.month) if(date.blank?)
        history = pesquisa_mensal(startDate)       
      elsif('quarterly' == periodType)
        @meta = (meta_semana * 8) * 12
        startDate = (DateTime.now - (3 * 6).month) if(date.blank?)
        history = pesquisa_trimestral(startDate)     
      elsif('semiannual' == periodType)
        @meta = (meta_semana * 16) * 12
        startDate = (DateTime.now - (6 * 6).month) if(date.blank?)
        history = pesquisa_semestral(startDate)    
      elsif('yearly' == periodType)
        @meta = (meta_semana * 32) * 12
        startDate = (DateTime.now - (6 * 12).month) if(date.blank?)
        history = pesquisa_anual(startDate)
      else    
        @meta = (meta_semana * 4) * 12
        startDate = (DateTime.now - 6.month) if(date.blank?)
        history = pesquisa_mensal(startDate)     
        periodType = "monthly"  
      end
      return {
        Amount: @meta.to_s, 
        Start: startDate,
        End: "",
        PeriodType: periodType,
        History: history
      }      
  end
  def pesquisa_semanal(startDate)
    sale = Sale.all
    resultado = sale.select{|x| x.date > startDate}

    dados = []    
    12.times do |i|
      date = startDate + (i * 7)
      date_fim = startDate + (i * 7) + 7

      value = 0
      projection = true
    
        r = resultado.select{|x| date < x.date && x.date < date_fim}
        
        next if(r.blank?)
        r.each do |valores|
          value += valores.total
          projection = false
        end
    
      d = {"Date" => date.strftime('%d/%m/%Y'), "Value" => value.to_s}
      d["Projection"] = projection
      dados << d
    end
    while(dados.length < 12)
      dd = (DateTime.parse(dados[dados.length - 1]["Date"]) + 7).strftime('%d/%m/%Y')
      dados << {"Projection" => true, "Date" => dd, "Value" => "0"}
    end
    return  dados.sort_by { |x| DateTime.parse(x["Date"]) }
  end
  def pesquisa_quizenal(startDate)
    sale = Sale.all
    resultado = sale.select{|x| x.date > startDate}
    dados = []    
    12.times do |i|
    
      date = startDate + (i * 14)
      date_fim = startDate + (i * 14) + 14

      value = 0
      projection = true
    
        r = resultado.select{|x| date < x.date && x.date < date_fim}
        
        next if(r.blank?)
        r.each do |valores|
          value += valores.total
          projection = false
        end
    
      
        d = {"Date" => date.strftime('%d/%m/%Y'), "Value" => value.to_s}
        d["Projection"] = projection
        dados << d
    end
    while(dados.length < 12)
      dd = (DateTime.parse(dados[dados.length - 1]["Date"]) + 14).strftime('%d/%m/%Y')
      dados << {"Projection" => true, "Date" => dd, "Value" => "0"}
    end

    return  dados.sort_by { |x| DateTime.parse(x["Date"]) }
  end
  def pesquisa_mensal(startDate)
      sale = Sale.all
      resultado = sale.select{|x| x.date > startDate}
      dados = []    
      12.times do |i|
        date = startDate.next_month(i)
        r = resultado.select{|x| x.date.strftime('%m/%Y') == date.strftime('%m/%Y')}
        data = "01/#{date.strftime('%m/%Y')}"
        value = 0
        projection = true
        r.each do |valores|
          projection = false
          value += valores.total
        end

     
        d = {"Date" => date.strftime('%d/%m/%Y'), "Value" => value.to_s}
        d["Projection"] = projection
        dados << d
      end
      while(dados.length < 12)
        dd = (DateTime.parse(dados[dados.length - 1]["Date"]).next_month(1)).strftime('%d/%m/%Y')
        dados << {"Projection" => true, "Date" => dd, "Value" => "0"}
      end
      return  dados.sort_by { |x| DateTime.parse(x["Date"]) }
    end
    def pesquisa_trimestral(startDate)
      sale = Sale.all
      resultado = sale.select{|x| x.date > startDate}
      dados = []    
      12.times do |i|
        date = startDate.next_month(i * 3)
        date_fim = startDate.next_month(i * 3).next_month(3)
  
        value = 0
        projection = true
      
          r = resultado.select{|x| date < x.date && x.date < date_fim}
          
          next if(r.blank?)
          r.each do |valores|
            value += valores.total
            projection = false
          end
    
          d = {"Date" => date.strftime('%d/%m/%Y'), "Value" => value.to_s}
          d["Projection"] = projection
          dados << d
      end
      while(dados.length < 12)
        dd = DateTime.parse(dados[dados.length - 1]["Date"]).next_month(3).strftime('%d/%m/%Y')
        dados << {"Projection" => true, "Date" => dd, "Value" => "0"}
      
      end
      return  dados.sort_by { |x| DateTime.parse(x["Date"]) }
    end
    def pesquisa_semestral(startDate)
      sale = Sale.all
      resultado = sale.select{|x| x.date > startDate}
      dados = []    
      12.times do |i|
        date = startDate.next_month(i * 6)
        date_fim = startDate.next_month(i * 6).next_month(6)
  
        value = 0
        projection = true
      
          r = resultado.select{|x| date < x.date && x.date < date_fim}
          
          next if(r.blank?)
          r.each do |valores|
            value += valores.total
            projection = false
          end
      
    
          d = {"Date" => date.strftime('%d/%m/%Y'), "Value" => value.to_s}
          d["Projection"] = projection
          dados << d
      end
      while(dados.length < 12)
        dd = DateTime.parse(dados[dados.length - 1]["Date"]).next_month(6).strftime('%d/%m/%Y')
        dados << {"Projection" => true, "Date" => dd, "Value" => "0"}
      
      end
      return  dados.sort_by { |x| DateTime.parse(x["Date"]) }
    end
    def pesquisa_anual(startDate)
      sale = Sale.all
      resultado = sale.select{|x| x.date > startDate}
      dados = []    
      12.times do |i|
        date = startDate.next_month(i * 12)
        date_fim = startDate.next_month(i * 12).next_month(12)
  
        value = 0
        projection = true
      
          r = resultado.select{|x| date < x.date && x.date < date_fim}
          
          next if(r.blank?)
          r.each do |valores|
            value += valores.total
            projection = false
          end
    
          d = {"Date" => date.strftime('%d/%m/%Y'), "Value" => value.to_s}
          d["Projection"] = projection
          dados << d
      end
      while(dados.length < 12)
        dd = DateTime.parse(dados[dados.length - 1]["Date"]).next_month(12).strftime('%d/%m/%Y')
        dados << {"Projection" => true, "Date" => dd, "Value" => "0"}
      
      end
      return  dados.sort_by { |x| DateTime.parse(x["Date"]) }
    end
end
