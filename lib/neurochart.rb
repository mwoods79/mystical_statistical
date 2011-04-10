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

    html = '<html>
        <head>
            <title>Convergence chart</title>
            <script  type="text/javascript" src="http://raphaeljs.com/raphael.js"></script>
            <script type="text/javascript"  src="http://g.raphaeljs.com/g.raphael.js"></script>
            <script type="text/javascript"  src="http://g.raphaeljs.com/g.line.js"></script>
            <script type="text/javascript">
              window.onload = function() {
                // Creates canvas 320 x 300 at 10, 50
                var r = Raphael("holder");

                // Creates a simple line chart at 10, 10
                // width 800, height 600
                var linec = r.g.linechart(40,20,700,390,' + xcsv + ',' + ycsv + ',
                  {"colors":' + colorcsv + ', "symbol":"s", axis:"0 0 1 1"}
                );
      				  linec.hover(function() {
          					this.symbol.attr({"fill":"#CCC"});
          				}, function() {
          					this.symbol.attr({"fill":"#444"});
                });
              }
            </script>
        </head>
        <body>
          <div id="holder" style="width:800px;height:480px;border:1px dashed #CCC;">
        </body>
    </html>'

    File.open("convergence.html", 'w+') {|f| f.write(html) }

    system("open convergence.html") #...on windows

  end

end
