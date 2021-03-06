module WelcomeHelper
  
  def picks

    doc = Nokogiri::HTML(URI.open('https://www.lotteryusa.com/pennsylvania/match-6/year'))
    results = []
    doc.css('li').each do |data|
      d = data.content.strip
      if d.to_i != 0
        results.push(d)
      end
    end

    picked = Hash.new(0)
    draws = []
    latest_draws = []
    draw_length = Hash.new
    totals = []

    #push numbers into array and only get enough so that all numbers are accounted for
    100.times do |i|
      draws.push(results.shift(6))
      break if draws.flatten.uniq.length >= 49
    end

    draw_length["Draws"] = draws.length

    draws.each do |draw|
      draw.each do |pick|
        picked[pick] = picked[pick] + 1
      end
    end

    latest_draws = draws.shift(1)

    latest_draws.each do |draw|
      draw.each do |pick|
        picked.delete_if {|k,v| k == pick}
      end
    end

    val = picked.values
    val.sort!
    picked.delete_if {|k,v| v < val.last(12).first}
    totals.push(picked)
    totals.push(draw_length)

    return totals
  end


###########################  power ball ###############################

  def ppicks

    doc = Nokogiri::HTML(URI.open('https://www.lotteryusa.com/powerball/year'))
    results = []
    bonus = []
    doc.css('li').each do |data|
      d = data.content.strip
      if d.to_i != 0
        results.push(d)
      end
    end

    picked = Hash.new(0)
    num_draws = Hash.new
    draws = []
    latest_draws = []
    totals = []

    #push numbers into array and only get enough so that all numbers are accounted for
    100.times do |i|
      draws.push(results.shift(5))
      results.shift(1)
      break if draws.flatten.uniq.length >= 69
    end

    num_draws["draws"] = draws.length

    draws.each do |draw|
      draw.each do |pick|
        picked[pick] = picked[pick] + 1
      end
    end

    latest_draws = draws.shift(2)

    latest_draws.each do |draw|
      draw.each do |pick|
        picked.delete_if {|k,v| k === pick}
      end
    end

    val = picked.values
    val.sort!
    picked.delete_if {|k,v| v < val.last(10).first}

    #########################bonus ball####################################
  

    doc.css('span').each do |data|
      d = data.content.strip
      if d.to_i != 0
        bonus.push(d)
      end
    end

    bonus_ball = Hash.new(0)

    bonus.each do |ball|
      bonus_ball[ball] = bonus_ball[ball] + 1
    end

    valb = bonus_ball.values
    valb.sort!

    bonus_ball.delete_if {|k,v| v < valb.last(8).first}

    totals.push(picked)
    totals.push(bonus_ball)
    totals.push(num_draws)

    return totals
  end

  def row_heads
    array = ["Numbers", "Bonus", "Draws"]
    return array
  end
  


###################### PICK 4 ############################

  def pick4

    doc = Nokogiri::HTML(URI.open('https://www.lotteryusa.com/pennsylvania/pick-4/year'))
    results = []
    doc.css('li').each do |data|
      d = data.content.strip
      if d.length == 1
        if d.to_i < 10
          results.push(d)
        end
      end
    end

    draws = []

    50.times do |i|
      draws.push(results.shift(4))
    end

    pool0 = Hash.new(0)
    pool1 = Hash.new(0)
    pool2 = Hash.new(0)
    pool3 = Hash.new(0)
    pools = Hash.new(0)

    pool_array = [pool0, pool1, pool2, pool3]
    
    pool_array.length.times do |j|
      draws.each do |draw|
        pool_array[j][draw[j]] = pool_array[j][draw[j]] + 1
        break if pool_array[j].size >= 10
      end
    end

    pool_array.each do |pool|
      pools[pool] = pool.values.sum
    end

    pools.each do |pool, total|
      pool.delete_if {|k,v| v < pool.values.sort.last(2).first }
    end

    return pools

  end

  ###################### pick 5 #########################################

  def pick5
    doc = Nokogiri::HTML(URI.open('https://www.lotteryusa.com/pennsylvania/pick-5/year'))
    results = []
    doc.css('li').each do |data|
      d = data.content.strip
      if d.length == 1
        if d.to_i < 10
          results.push(d)
        end
      end
    end

    draws = []

    50.times do |i|
      draws.push(results.shift(5))
    end

    pool0 = Hash.new(0)
    pool1 = Hash.new(0)
    pool2 = Hash.new(0)
    pool3 = Hash.new(0)
    pool4 = Hash.new(0)
    pools = Hash.new(0)

    pool_array = [pool0, pool1, pool2, pool3, pool4]
    
    pool_array.length.times do |j|
      draws.each do |draw|
        pool_array[j][draw[j]] = pool_array[j][draw[j]] + 1
        break if pool_array[j].size >= 10
      end
    end

    pool_array.each do |pool|
      pools[pool] = pool.values.sum
    end

    pools.each do |pool, total|
      pool.delete_if {|k,v| v < pool.values.sort.last(2).first }
    end

    return pools

  end

end