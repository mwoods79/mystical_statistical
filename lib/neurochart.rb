class NeuroChart

  def initialize(xVals, lineYs)
    @xVals = xVals
    @lineYs = lineYs
    @colors = ["'#F00'", "'#0F0'", "'#00F'", "'#0FF'", "'#FF0'", "'#F0F'"]
  end

  def createSVGChart

    colorList = @colors[0,@lineYs.length]
    #puts colorList.to_a
    ycsv = "["
    @lineYs.each_with_index do |line,i|
      ycsv += "["
      ycsv += CSV.generate do |csv|
        #puts line
        csv << line
      end
      ycsv += "]"
      ycsv += "," if (@lineYs.length-1>i)
    end
    ycsv += "]"
    #puts ycsv

    xcsv = "["
    xcsv += CSV.generate do |csv|
      csv << @xVals
    end
    xcsv += "]"
    #puts xcsv

    colorcsv = "["
    colorcsv += CSV.generate do |csv|
      csv << @colors
    end
    colorcsv += "]"

    display_in_browser "convergence.html"

  end

  def display_in_browser(file_name)
    create_html file_name
    open_in_browser file_name
  end

  def create_html(file_name)
    `echo #{get_template(file_name)} > #{file_name}`
  end

  def open_in_browser(file_name)
    `open #{file_name}`
  end

  def get_template( name, this_binding = nil )
    erb = ERB.new(File.read(File.dirname(__FILE__) + "/templates/#{name}.erb"))
    erb.result this_binding
  end

end
