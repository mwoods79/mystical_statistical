class NeuroChart

  def initialize(xVals, lineYs)
    @xVals = xVals
    @lineYs = lineYs
    @colors = ["'#F00'", "'#0F0'", "'#00F'", "'#0FF'", "'#FF0'", "'#F0F'"]
  end

  def createSVGChart
    ycsv = ""
    @lineYs.each do |line|
      ycsv += simple_csv line
      ycsv += ","
    end
    ycsv.chop! # cuts the last character off a string

    xcsv = simple_csv @xVals

    colorcsv = simple_csv @colors

    display_in_browser "convergence.html", binding
  end

  def simple_csv(array)
    "[#{array.to_csv.chomp}]"
  end

  def display_in_browser(file_name, this_binding = nil)
    create_html file_name, this_binding
    open_in_browser file_name
  end

  def create_html(file_name, this_binding = nil)
    File.open(File.dirname(__FILE__) + "/../#{file_name}", 'w' ) do |f|
      f.write get_template( file_name, this_binding )
    end
  end

  def open_in_browser(file_name)
    `open #{file_name}`
  end

  def get_template( name, this_binding = nil )
    erb = ERB.new(File.read(File.dirname(__FILE__) + "/templates/#{name}.erb"))
    erb.result this_binding
  end

end

